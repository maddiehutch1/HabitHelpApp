import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/card_model.dart';
import '../../providers/cards_provider.dart';
import '../../theme.dart';
import 'create_card_goal_screen.dart';

/// Displays up to 3 AI-extracted task titles from a voice transcription.
///
/// The user picks which suggestions to keep (all checked by default), can
/// inline-edit any title, then taps [Add selected] to batch-create cards for
/// all checked items at once.
///
/// If the user wants to skip AI parsing entirely they can tap
/// "Add manually instead" to go straight to [CreateCardGoalScreen] with the
/// raw transcription prefilled.
class VoiceAISuggestionsScreen extends ConsumerStatefulWidget {
  const VoiceAISuggestionsScreen({
    super.key,
    required this.suggestions,
    required this.transcription,
  });

  final List<String> suggestions;

  /// Raw transcription returned by [VoiceInputSheet]. Used as a fallback
  /// prefilled goal when the user taps "Add manually instead".
  final String transcription;

  @override
  ConsumerState<VoiceAISuggestionsScreen> createState() =>
      _VoiceAISuggestionsScreenState();
}

class _SuggestionItem {
  _SuggestionItem(this.title) : checked = true, editing = false;

  String title;
  bool checked;
  bool editing;
}

class _VoiceAISuggestionsScreenState
    extends ConsumerState<VoiceAISuggestionsScreen> {
  late final List<_SuggestionItem> _items;
  late final List<TextEditingController> _editControllers;

  @override
  void initState() {
    super.initState();
    _items = widget.suggestions.map(_SuggestionItem.new).toList();
    _editControllers = _items
        .map((item) => TextEditingController(text: item.title))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _editControllers) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _hasSelection => _items.any((item) => item.checked);

  Future<void> _onAddSelected() async {
    final titles = _items
        .where((item) => item.checked)
        .map((item) => item.title.trim())
        .where((t) => t.isNotEmpty)
        .toList();
    if (titles.isEmpty) return;

    final notifier = ref.read(cardsProvider.notifier);

    for (var i = 0; i < titles.length; i++) {
      final now = DateTime.now().millisecondsSinceEpoch + i;
      final card = CardModel(
        id: now.toString(),
        actionLabel: 'Decide what to do first',
        goalLabel: titles[i],
        durationSeconds: 120,
        sortOrder: 0,
        createdAt: now,
      );
      await notifier.addCard(card);
    }

    if (!mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _goManual() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            CreateCardGoalScreen(prefilledGoal: widget.transcription),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
                children: [
                  const SizedBox(height: AppSpacing.md),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Semantics(
                      label: 'Back',
                      button: true,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textMuted,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 24,
                        constraints: const BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Text(
                    "Here's what I heard",
                    style: AppTextStyles.headline,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Pick what to work on',
                    style: AppTextStyles.bodyMuted,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ...List.generate(
                    _items.length,
                    (index) => _buildTile(index),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Semantics(
                      button: true,
                      label: 'Add selected tasks',
                      child: FilledButton(
                        onPressed: _hasSelection ? _onAddSelected : null,
                        child: const Text('Next Step'),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Center(
                    child: TextButton(
                      onPressed: _goManual,
                      child: const Text('Add manually instead'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(int index) {
    final item = _items[index];
    final controller = _editControllers[index];

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.checked,
            onChanged: (v) => setState(() => item.checked = v ?? false),
            activeColor: AppColors.textPrimary,
            checkColor: AppColors.background,
          ),
          Expanded(
            child: item.editing
                ? TextField(
                    controller: controller,
                    autofocus: true,
                    style: AppTextStyles.body,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      setState(() {
                        item.title =
                            value.trim().isEmpty ? item.title : value.trim();
                        item.editing = false;
                      });
                    },
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: AppSpacing.xs,
                      ),
                    ),
                  )
                : Text(item.title, style: AppTextStyles.body),
          ),
          Semantics(
            label: item.editing ? 'Confirm edit' : 'Edit suggestion',
            button: true,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (item.editing) {
                    item.title = controller.text.trim().isEmpty
                        ? item.title
                        : controller.text.trim();
                    item.editing = false;
                  } else {
                    controller.text = item.title;
                    item.editing = true;
                  }
                });
              },
              icon: Icon(
                item.editing ? Icons.check : Icons.edit_outlined,
                color: item.editing
                    ? AppColors.textPrimary
                    : AppColors.textFaint,
                size: 22,
              ),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            ),
          ),
        ],
      ),
    );
  }
}
