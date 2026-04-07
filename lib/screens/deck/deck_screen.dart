import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/card_model.dart';
import '../../providers/cards_provider.dart';
import '../../services/ai_service.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../create_card/create_card_goal_screen.dart';
import '../create_card/voice_ai_suggestions_screen.dart';
import '../past_days/past_days_screen.dart';
import '../settings/settings_screen.dart';
import '../timer/timer_screen.dart';
import '../create_card/next_step_screen.dart';
import 'completion_screen.dart';
import 'widgets/card_detail_sheet.dart';
import 'widgets/voice_input_sheet.dart';

class DeckScreen extends ConsumerStatefulWidget {
  const DeckScreen({super.key});

  @override
  ConsumerState<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends ConsumerState<DeckScreen>
    with WidgetsBindingObserver {
  bool _navigating = false;
  bool _isFreshStartMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() async {
      await _loadPreferences();
      await _checkDailyRollover();
      await _onLoad();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reschedule notifications when app comes back to foreground
      // NotificationService.instance.rescheduleAll() is intentionally not
      // awaited here — fire and forget to avoid blocking the UI.

      // Check for daily rollover
      Future.microtask(() async {
        await _checkDailyRollover();
        if (mounted) await _onLoad();
      });
    }
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = SharedPreferencesAsync();
      final isFreshStart = await prefs.getBool('isFreshStartMode') ?? false;
      if (mounted) {
        setState(() {
          _isFreshStartMode = isFreshStart;
        });
      }
    } catch (_) {
      // Fail silently, defaults are fine
    }
  }

  Future<void> _checkDailyRollover() async {
    if (!_isFreshStartMode) return;

    try {
      final prefs = SharedPreferencesAsync();
      final lastOpenDate = await prefs.getInt('lastOpenDate');
      final now = DateTime.now();
      final todayMidnight = DateTime(
        now.year,
        now.month,
        now.day,
      ).millisecondsSinceEpoch;

      if (lastOpenDate == null || lastOpenDate < todayMidnight) {
        // New day detected - archive all active cards with yesterday's date
        final yesterday = DateTime(now.year, now.month, now.day - 1);
        final yesterdayTimestamp = yesterday.millisecondsSinceEpoch;

        await ref
            .read(cardsProvider.notifier)
            .archiveAllActiveCards(yesterdayTimestamp);

        // Update lastOpenDate to today
        await prefs.setInt('lastOpenDate', todayMidnight);
      }
    } catch (_) {
      // Fail silently - daily rollover is non-critical
    }
  }

  Future<void> _onLoad() async {
    try {
      await ref.read(cardsProvider.notifier).loadCards();
      await _loadPreferences();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not load cards.')));
      }
    }
  }

  Future<void> _openCardDetail(CardModel card) async {
    if (_navigating) return;
    final result = await showModalBottomSheet<_CardAction>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CardDetailSheet(
        card: card,
        onStart: () => Navigator.of(context).pop(_CardAction.start),
        onEdit: () => Navigator.of(context).pop(_CardAction.edit),
        onComplete: () => Navigator.of(context).pop(_CardAction.complete),
        onContinue: card.goalLabel != null && card.goalLabel!.isNotEmpty
            ? () => Navigator.of(context).pop(_CardAction.continueNext)
            : null,
      ),
    );

    if (!mounted || result == null) return;

    switch (result) {
      case _CardAction.start:
        setState(() => _navigating = true);
        await Navigator.of(context).push(fadeRoute(TimerScreen(card: card)));
        if (mounted) {
          setState(() => _navigating = false);
          await _onLoad();
        }
      case _CardAction.edit:
        await _showEditSheet(card);
      case _CardAction.complete:
        await Navigator.of(context).push(
          fadeRoute(
            CompletionScreen(
              card: card,
              onComplete: () async {
                await ref.read(cardsProvider.notifier).completeCard(card.id);
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    fadeRoute(const DeckScreen()),
                    (route) => false,
                  );
                }
              },
              onNextStep: card.goalLabel != null && card.goalLabel!.isNotEmpty
                  ? () async {
                      await ref
                          .read(cardsProvider.notifier)
                          .completeCard(card.id);
                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          fadeRoute(const DeckScreen()),
                          (route) => false,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                NextStepScreen(goalLabel: card.goalLabel!),
                          ),
                        );
                      }
                    }
                  : null,
            ),
          ),
        );
      case _CardAction.continueNext:
        if (card.goalLabel != null && card.goalLabel!.isNotEmpty) {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NextStepScreen(goalLabel: card.goalLabel!),
            ),
          );
          if (mounted) await _onLoad();
        }
    }
  }

  Future<void> _showEditSheet(CardModel card) async {
    String? savedAction;
    String? savedGoal;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _EditCardSheet(
        initialAction: card.actionLabel,
        initialGoal: card.goalLabel ?? '',
        onSave: (action, goal) {
          savedAction = action;
          savedGoal = goal;
          Navigator.of(ctx).pop();
        },
        onCancel: () => Navigator.of(ctx).pop(),
      ),
    );

    if (savedAction != null && mounted) {
      await ref
          .read(cardsProvider.notifier)
          .updateCard(
            card.id,
            actionLabel: savedAction!,
            goalLabel: savedGoal!.isEmpty ? null : savedGoal,
          );
      await _onLoad();
    }
  }

  Future<void> _openVoiceInput() async {
    final transcription = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const VoiceInputSheet(),
    );

    if (transcription == null || transcription.isEmpty || !mounted) return;

    // Check consent — if the user has not enabled AI suggestions, skip parsing
    // and fall through to the manual goal screen directly.
    final hasConsent = await AIService.hasConsent();
    if (!mounted) return;

    List<String> suggestions = [];
    if (hasConsent) {
      // Show a brief loading indicator while the AI parses the transcription.
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        builder: (_) => const _VoiceProcessingDialog(),
      );

      suggestions = await AIService.suggestTasksFromTranscription(
        transcription,
      );

      if (mounted) Navigator.of(context).pop(); // Dismiss loading dialog
    }

    if (!mounted) return;

    if (suggestions.isEmpty) {
      // Fallback: go straight to CreateCardGoalScreen with raw transcription.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CreateCardGoalScreen(prefilledGoal: transcription),
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: '/voiceSuggestions'),
        builder: (_) => VoiceAISuggestionsScreen(
          suggestions: suggestions,
          transcription: transcription,
        ),
      ),
    );
  }

  Future<void> _showAddMethodSheet() async {
    final result = await showModalBottomSheet<_AddMethod>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _AddMethodSheet(),
    );

    if (!mounted) return;

    if (result == _AddMethod.voice) {
      await _openVoiceInput();
    } else if (result == _AddMethod.manual) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const CreateCardGoalScreen()));
    }
  }

  Future<void> _openPastDays() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const PastDaysScreen()));
    if (mounted) await _onLoad();
  }

  Widget _buildFreshStartActions() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _openVoiceInput,
              icon: const Icon(Icons.mic_outlined, size: 20),
              label: const Text('Voice planning'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textMuted,
                side: const BorderSide(color: AppColors.surfaceHigh),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Semantics(
            label: 'View completed',
            button: true,
            child: TextButton(
              onPressed: _openPastDays,
              style: TextButton.styleFrom(foregroundColor: AppColors.textFaint),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('Completed')],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(cardsProvider);

    return Scaffold(
      body: SafeArea(child: _buildDeckView(cards)),
      floatingActionButton: Semantics(
        label: 'Add card',
        button: true,
        child: FloatingActionButton(
          onPressed: _showAddMethodSheet,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDeckView(List<CardModel> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.md,
            AppSpacing.page,
            AppSpacing.xs,
          ),
          child: Row(
            children: [
              const Text('Your Deck', style: AppTextStyles.screenTitle),
              if (cards.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${cards.length}',
                  style: AppTextStyles.screenTitle.copyWith(
                    color: AppColors.textFaint,
                  ),
                ),
              ],
              const Spacer(),
              Semantics(
                label: 'Completed',
                button: true,
                child: IconButton(
                  onPressed: _openPastDays,
                  icon: const Icon(
                    Icons.archive_outlined,
                    color: AppColors.textFaint,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              Semantics(
                label: 'Settings',
                button: true,
                child: IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                    if (mounted) await _onLoad();
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: AppColors.textFaint,
                    size: 20,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: cards.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (_, i) {
                    final card = cards[i];
                    return Dismissible(
                      key: ValueKey(card.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceHigh,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'Complete',
                          style: AppTextStyles.bodyMuted,
                        ),
                      ),
                      confirmDismiss: (_) async {
                        await Navigator.of(context).push(
                          fadeRoute(
                            CompletionScreen(
                              card: card,
                              onComplete: () async {
                                await ref
                                    .read(cardsProvider.notifier)
                                    .completeCard(card.id);
                                if (mounted) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    fadeRoute(const DeckScreen()),
                                    (route) => false,
                                  );
                                }
                              },
                              onNextStep:
                                  card.goalLabel != null &&
                                      card.goalLabel!.isNotEmpty
                                  ? () async {
                                      await ref
                                          .read(cardsProvider.notifier)
                                          .completeCard(card.id);
                                      if (mounted) {
                                        Navigator.of(
                                          context,
                                        ).pushAndRemoveUntil(
                                          fadeRoute(const DeckScreen()),
                                          (route) => false,
                                        );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => NextStepScreen(
                                              goalLabel: card.goalLabel!,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        );
                        return false;
                      },
                      child: _CardTile(
                        card: card,
                        onTap: () => _openCardDetail(card),
                      ),
                    );
                  },
                ),
        ),
        if (_isFreshStartMode) _buildFreshStartActions(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add your first card\nto get started.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            button: true,
            label: 'Add a card',
            child: FilledButton.icon(
              onPressed: _showAddMethodSheet,
              icon: const Icon(Icons.add),
              label: const Text('Add a card'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Card Action Enum ─────────────────────────────────────────────────────────

enum _CardAction { start, edit, complete, continueNext }

// ─── Card Tile ────────────────────────────────────────────────────────────────

class _CardTile extends StatelessWidget {
  const _CardTile({required this.card, required this.onTap});

  final CardModel card;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Semantics(
        button: true,
        label: '${card.actionLabel}. Tap for options.',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.actionLabel,
                        style: AppTextStyles.cardAction,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (card.goalLabel != null && card.goalLabel!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            card.goalLabel!,
                            style: AppTextStyles.cardGoal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(card.durationLabel, style: AppTextStyles.badge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Add Method Sheet ─────────────────────────────────────────────────────────

enum _AddMethod { voice, manual }

class _AddMethodSheet extends StatelessWidget {
  const _AddMethodSheet();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final safePadding = bottomInset > 24.0 ? bottomInset : 24.0;
    final buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: AppColors.textMuted,
      side: const BorderSide(color: AppColors.surfaceHigh),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.md + safePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Add a card', style: AppTextStyles.sheetTitle),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(_AddMethod.voice),
              icon: const Icon(Icons.mic_outlined, size: 20),
              label: const Text('Use voice'),
              style: buttonStyle,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(_AddMethod.manual),
              icon: const Icon(Icons.edit_outlined, size: 20),
              label: const Text('Use keyboard'),
              style: buttonStyle,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

// ─── Edit Card Sheet ──────────────────────────────────────────────────────────

class _EditCardSheet extends StatefulWidget {
  const _EditCardSheet({
    required this.initialAction,
    required this.initialGoal,
    required this.onSave,
    required this.onCancel,
  });

  final String initialAction;
  final String initialGoal;
  final void Function(String action, String goal) onSave;
  final VoidCallback onCancel;

  @override
  State<_EditCardSheet> createState() => _EditCardSheetState();
}

class _EditCardSheetState extends State<_EditCardSheet> {
  late final TextEditingController _actionController;
  late final TextEditingController _goalController;

  @override
  void initState() {
    super.initState();
    _actionController = TextEditingController(text: widget.initialAction);
    _goalController = TextEditingController(text: widget.initialGoal);
  }

  @override
  void dispose() {
    _actionController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final safePadding = bottomPadding > 24.0 ? bottomPadding : 24.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.md + bottomInset + safePadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit card', style: AppTextStyles.sheetTitle),
            const SizedBox(height: AppSpacing.sm),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _actionController,
              builder: (context, value, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _actionController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    style: AppTextStyles.body,
                    decoration: const InputDecoration(
                      labelText: 'Action label',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    controller: _goalController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    style: AppTextStyles.body,
                    decoration: const InputDecoration(
                      labelText: 'Goal label',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: value.text.trim().isEmpty
                          ? null
                          : () => widget.onSave(
                                _actionController.text.trim(),
                                _goalController.text.trim(),
                              ),
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: widget.onCancel,
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Voice Processing Dialog ──────────────────────────────────────────────────

/// Shown while [AIService.suggestTasksFromTranscription] is running.
/// Dismissed by the caller once the async call completes.
class _VoiceProcessingDialog extends StatelessWidget {
  const _VoiceProcessingDialog();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 56,
        height: 56,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
