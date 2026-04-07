import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/card_model.dart';
import '../../providers/cards_provider.dart';
import '../../routes.dart';
import '../../services/ai_service.dart';
import '../../theme.dart';
import '../timer/timer_screen.dart';

class NextStepScreen extends ConsumerStatefulWidget {
  const NextStepScreen({super.key, required this.goalLabel});

  final String goalLabel;

  @override
  ConsumerState<NextStepScreen> createState() => _NextStepScreenState();
}

class _NextStepScreenState extends ConsumerState<NextStepScreen> {
  final _controller = TextEditingController();
  bool _loadingSuggestions = false;
  List<String>? _suggestions;
  String? _smallerSuggestion;
  bool _loadingSmaller = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    final card = CardModel(
      id: now.toString(),
      goalLabel: widget.goalLabel,
      actionLabel: text,
      durationSeconds: 120,
      sortOrder: 0,
      createdAt: now,
    );

    await ref.read(cardsProvider.notifier).addCard(card);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      fadeRoute(TimerScreen(card: card)),
    );
  }

  Future<void> _showAISuggestions() async {
    final hasConsent = await AIService.requestConsent(context);
    if (!hasConsent) return;

    setState(() => _loadingSuggestions = true);

    try {
      final suggestions =
          await AIService.generateFirstSteps(widget.goalLabel);
      if (mounted) {
        setState(() {
          _suggestions = suggestions;
          _loadingSuggestions = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingSuggestions = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not load suggestions. Please try again.'),
          ),
        );
      }
    }
  }

  Future<void> _makeSmaller() async {
    final hasConsent = await AIService.requestConsent(context);
    if (!hasConsent) return;

    setState(() => _loadingSmaller = true);

    try {
      final smaller = await AIService.makeSmaller(_controller.text.trim());
      if (mounted) {
        setState(() {
          _smallerSuggestion = smaller;
          _loadingSmaller = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loadingSmaller = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not generate suggestion. Please try again.'),
          ),
        );
      }
    }
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
              // Scrollable content — expands to fill space between back button
              // and the pinned CTA button, and scrolls when keyboard appears.
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        widget.goalLabel,
                        style: AppTextStyles.contextLabel,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        "What's the next tiny step?",
                        style: AppTextStyles.headline,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Think in terms of 2 minutes or less.',
                        style: AppTextStyles.bodyMuted,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _controller,
                        autofocus: true,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _start(),
                        decoration: const InputDecoration(
                          hintText: 'e.g. Write the first paragraph',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      if (!_loadingSuggestions && _suggestions == null)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: OutlinedButton.icon(
                            onPressed: _showAISuggestions,
                            icon: const Icon(Icons.auto_awesome, size: 16),
                            label: const Text('Help me think of one'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.aiAccent,
                              side: BorderSide(color: AppColors.aiAccent.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      if (_loadingSuggestions)
                        const Padding(
                          padding: EdgeInsets.only(top: AppSpacing.sm),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      if (_suggestions != null)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _suggestions!.map((suggestion) {
                              return ActionChip(
                                label: Text(
                                  suggestion,
                                  softWrap: true,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.text = suggestion;
                                    _suggestions = null;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      if (_controller.text.trim().isNotEmpty &&
                          !_loadingSmaller)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: OutlinedButton.icon(
                            onPressed: _makeSmaller,
                            icon: const Icon(Icons.auto_awesome, size: 16),
                            label: const Text('Make this smaller'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.aiAccent,
                              side: BorderSide(color: AppColors.aiAccent.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      if (_loadingSmaller)
                        const Padding(
                          padding: EdgeInsets.only(top: AppSpacing.sm),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      if (_smallerSuggestion != null)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: ActionChip(
                            label: Text(
                              _smallerSuggestion!,
                              softWrap: true,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.text = _smallerSuggestion!;
                                _smallerSuggestion = null;
                              });
                            },
                          ),
                        ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
              // CTA button pinned above keyboard
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: Semantics(
                  button: true,
                  label: 'Start',
                  child: FilledButton(
                    onPressed:
                        _controller.text.trim().isEmpty ? null : _start,
                    child: const Text('Start'),
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
