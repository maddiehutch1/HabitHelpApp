import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/card_model.dart';
import '../../providers/cards_provider.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../create_card/create_card_goal_screen.dart';
import '../past_days/past_days_screen.dart';
import '../settings/settings_screen.dart';
import '../timer/timer_screen.dart';
import 'widgets/voice_input_sheet.dart';

class DeckScreen extends ConsumerStatefulWidget {
  const DeckScreen({super.key});

  @override
  ConsumerState<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends ConsumerState<DeckScreen>
    with WidgetsBindingObserver {
  bool _navigating = false;
  bool _justOneMode = false;
  int _justOneIndex = 0;
  bool _isFreshStartMode = false;
  int _archivedCardCount = 0;

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
      final archivedCount =
          await ref.read(cardsProvider.notifier).getArchivedCardCount();
      if (mounted) {
        setState(() {
          _isFreshStartMode = isFreshStart;
          _archivedCardCount = archivedCount;
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
      final todayMidnight =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

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
      await _checkArchivePrompts();
      await _loadPreferences();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not load cards.')));
      }
    }
  }

  Future<void> _checkArchivePrompts() async {
    final candidates = await ref
        .read(cardsProvider.notifier)
        .getCardsNeedingArchivePrompt();
    if (candidates.isNotEmpty && mounted) {
      _showArchivePrompt(candidates.first);
    }
  }

  void _showArchivePrompt(CardModel card) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => _ArchivePromptSheet(
          card: card,
          onRest: () => ref.read(cardsProvider.notifier).archiveCard(card.id),
        ),
      );
    });
  }

  Future<void> _openTimer(CardModel card) async {
    if (_navigating) return;
    setState(() => _navigating = true);
    await Navigator.of(context).push(fadeRoute(TimerScreen(card: card)));
    if (mounted) {
      setState(() => _navigating = false);
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

    if (transcription != null && transcription.isNotEmpty && mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CreateCardGoalScreen(
            prefilledGoal: transcription,
          ),
        ),
      );
    }
  }

  void _enterJustOneMode() {
    final cards = ref.read(cardsProvider);
    if (cards.isEmpty) return;
    setState(() {
      _justOneMode = true;
      _justOneIndex = 0;
    });
  }

  void _exitJustOneMode() => setState(() => _justOneMode = false);

  Future<void> _openPastDays() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PastDaysScreen()),
    );
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
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.md,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Semantics(
            label: 'View past days',
            button: true,
            child: TextButton(
              onPressed: _openPastDays,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textFaint,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xs,
                  horizontal: AppSpacing.sm,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Past days'),
                  if (_archivedCardCount > 0) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$_archivedCardCount',
                        style: AppTextStyles.badge.copyWith(fontSize: 11),
                      ),
                    ),
                  ],
                ],
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
      body: SafeArea(
        child: _justOneMode ? _buildJustOneMode(cards) : _buildDeckView(cards),
      ),
      floatingActionButton: _justOneMode
          ? null
          : Semantics(
              label: 'Add card',
              button: true,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CreateCardGoalScreen(),
                    ),
                  );
                },
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
              if (cards.isNotEmpty)
                Semantics(
                  label: 'Just One mode',
                  button: true,
                  child: IconButton(
                    onPressed: _enterJustOneMode,
                    icon: const Icon(
                      Icons.filter_1_outlined,
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
                          'Later',
                          style: AppTextStyles.bodyMuted,
                        ),
                      ),
                      onDismissed: (_) {
                        ref.read(cardsProvider.notifier).deferCard(card.id);
                      },
                      child: _CardTile(
                        card: card,
                        onTap: () => _openTimer(card),
                      ),
                    );
                  },
                ),
        ),
        if (_isFreshStartMode) _buildFreshStartActions(),
      ],
    );
  }

  Widget _buildJustOneMode(List<CardModel> cards) {
    if (cards.isEmpty || _justOneIndex >= cards.length) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("That's all of them.", style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: _exitJustOneMode,
              child: const Text('Back to deck'),
            ),
          ],
        ),
      );
    }

    final card = cards[_justOneIndex];
    return GestureDetector(
      onTap: _exitJustOneMode,
      behavior: HitTestBehavior.opaque,
      child: Column(
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
                const Spacer(),
                Semantics(
                  label: 'Exit Just One mode',
                  button: true,
                  child: IconButton(
                    onPressed: _exitJustOneMode,
                    icon: const Icon(Icons.close, color: AppColors.textFaint),
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
          const Spacer(flex: 2),
          GestureDetector(
            onTap: () {}, // Absorb taps on the card itself
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(card.actionLabel, style: AppTextStyles.cardAction),
                    if (card.goalLabel != null &&
                        card.goalLabel!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(card.goalLabel!, style: AppTextStyles.cardGoal),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Text(card.durationLabel, style: AppTextStyles.badge),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      _exitJustOneMode();
                      _openTimer(card);
                    },
                    child: const Text('Start'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref.read(cardsProvider.notifier).deferCard(card.id);
                      final newCards = ref.read(cardsProvider);
                      if (_justOneIndex >= newCards.length) {
                        _exitJustOneMode();
                      } else {
                        setState(() {});
                      }
                    },
                    child: const Text('Not today'),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateCardGoalScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add a card'),
            ),
          ),
        ],
      ),
    );
  }
}

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
        label: '${card.actionLabel}. Tap to start timer.',
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

// ─── Archive Prompt Sheet ─────────────────────────────────────────────────────

class _ArchivePromptSheet extends StatelessWidget {
  const _ArchivePromptSheet({required this.card, required this.onRest});

  final CardModel card;
  final VoidCallback onRest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "You've set this one aside a few times. Want to rest it for now?",
            style: AppTextStyles.headline,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(card.actionLabel, style: AppTextStyles.bodyMuted),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRest();
              },
              child: const Text('Rest it'),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Keep it'),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

