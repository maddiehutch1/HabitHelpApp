import 'package:flutter/material.dart';

import '../../services/ai_service.dart';
import '../../theme.dart';
import 'create_card_confirm_screen.dart';

class CreateCardActionScreen extends StatefulWidget {
  const CreateCardActionScreen({
    super.key,
    required this.goal,
    this.onCardSaved,
  });

  final String goal;
  final VoidCallback? onCardSaved;

  @override
  State<CreateCardActionScreen> createState() => _CreateCardActionScreenState();
}

class _CreateCardActionScreenState extends State<CreateCardActionScreen> {
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

  void _advance() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateCardConfirmScreen(
          goal: widget.goal,
          action: text,
          onCardSaved: widget.onCardSaved,
        ),
      ),
    );
  }

  Future<void> _showAISuggestions() async {
    // Check/request consent
    final hasConsent = await AIService.requestConsent(context);
    if (!hasConsent) return;

    setState(() => _loadingSuggestions = true);

    try {
      final suggestions = await AIService.generateFirstSteps(widget.goal);
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
                        widget.goal,
                        style: AppTextStyles.contextLabel,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        "What's one tiny step you could take first?",
                        style: AppTextStyles.headline,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      const Text(
                        'Think in terms of 2 minutes or less. Smaller is better.',
                        style: AppTextStyles.bodyMuted,
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
                          hintText: 'e.g. Open the document',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      if (!_loadingSuggestions && _suggestions == null)
                        Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: OutlinedButton.icon(
                            onPressed: _showAISuggestions,
                            icon: const Icon(Icons.auto_awesome, size: 16),
                            label: const Text("I'm stuck – show ideas"),
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
                          child: Column(
                            children: _suggestions!.map((suggestion) {
                              return _SuggestionTile(
                                text: suggestion,
                                onTap: () {
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
                          child: _SuggestionTile(
                            text: _smallerSuggestion!,
                            onTap: () {
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
                  label: "Let's go",
                  child: FilledButton(
                    onPressed: _controller.text.trim().isEmpty
                        ? null
                        : _advance,
                    child: const Text("Let's go →"),
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

class _SuggestionTile extends StatelessWidget {
  const _SuggestionTile({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.surfaceHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.aiAccent.withOpacity(0.3)),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(text, style: AppTextStyles.body),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_upward,
                  size: 16,
                  color: AppColors.aiAccent.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
