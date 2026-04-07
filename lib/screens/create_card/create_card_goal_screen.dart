import 'package:flutter/material.dart';

import '../../theme.dart';
import 'create_card_action_screen.dart';

class CreateCardGoalScreen extends StatefulWidget {
  const CreateCardGoalScreen({super.key, this.prefilledGoal, this.onCardSaved});

  final String? prefilledGoal;

  /// Optional callback invoked after a card is saved via "Save for later" in
  /// the confirm screen. Used by [VoiceAISuggestionsScreen] to process a
  /// multi-task queue without returning to the deck between each card.
  final VoidCallback? onCardSaved;

  @override
  State<CreateCardGoalScreen> createState() => _CreateCardGoalScreenState();
}

class _CreateCardGoalScreenState extends State<CreateCardGoalScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.prefilledGoal != null) {
      _controller.text = widget.prefilledGoal!;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _advance() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateCardActionScreen(
          goal: text,
          onCardSaved: widget.onCardSaved,
        ),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      const Text(
                        'What feels big and difficult right now?',
                        style: AppTextStyles.headline,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _controller,
                        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _advance(),
                        decoration: const InputDecoration(
                          hintText: 'e.g. Write my 15-page research paper',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: Semantics(
                  button: true,
                  label: 'Next',
                  child: FilledButton(
                    onPressed: _controller.text.trim().isEmpty
                        ? null
                        : _advance,
                    child: const Text('Next →'),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
