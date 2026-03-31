import 'package:flutter/material.dart';

import '../../theme.dart';
import 'create_card_goal_screen.dart';

/// Displays up to 3 AI-extracted task titles from a voice transcription.
///
/// The user picks which suggestions to keep (all checked by default), can
/// inline-edit any title, then taps [Add selected] to route each chosen task
/// through [CreateCardGoalScreen] one at a time. After all selected tasks are
/// processed the navigator pops back to the deck.
///
/// If the user wants to skip AI parsing entirely they can tap
/// "Add manually instead" to go straight to [CreateCardGoalScreen] with the
/// raw transcription prefilled.
class VoiceAISuggestionsScreen extends StatefulWidget {
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
  State<VoiceAISuggestionsScreen> createState() =>
      _VoiceAISuggestionsScreenState();
}

class _SuggestionItem {
  _SuggestionItem(this.title) : checked = true, editing = false;

  String title;
  bool checked;
  bool editing;
}

class _VoiceAISuggestionsScreenState extends State<VoiceAISuggestionsScreen> {
  late final List<_SuggestionItem> _items;
  late final List<TextEditingController> _editControllers;

  /// Remaining tasks to process. Populated when [_onAddSelected] is called.
  final List<String> _queue = [];

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

  void _onAddSelected() {
    _queue
      ..clear()
      ..addAll(
        _items
            .where((item) => item.checked)
            .map((item) => item.title.trim())
            .where((t) => t.isNotEmpty),
      );
    _processNextTask();
  }

  /// Processes the next task in [_queue].
  ///
  /// Called immediately after [_onAddSelected] and again via the
  /// [CreateCardGoalScreen.onCardSaved] callback each time a card is saved
  /// via "Save for later" in the confirm screen.
  void _processNextTask() {
    if (!mounted) return;
    if (_queue.isEmpty) {
      // All tasks processed — return to deck (first route in the stack).
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }
    final task = _queue.removeAt(0);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateCardGoalScreen(
          prefilledGoal: task,
          onCardSaved: _processNextTask,
        ),
      ),
    );
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              Semantics(
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
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (_, index) => _buildTile(index),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Semantics(
                  button: true,
                  label: 'Add selected tasks',
                  child: FilledButton(
                    onPressed: _hasSelection ? _onAddSelected : null,
                    child: const Text('Add selected'),
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
                color: AppColors.textFaint,
                size: 18,
              ),
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            ),
          ),
        ],
      ),
    );
  }
}
