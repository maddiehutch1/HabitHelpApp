import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/card_model.dart';
import '../../routes.dart';
import '../../services/notification_service.dart';
import '../../theme.dart';
import '../create_card/next_step_screen.dart';
import '../deck/deck_screen.dart';

class CelebrationScreen extends StatefulWidget {
  const CelebrationScreen({
    super.key,
    required this.card,
    required this.elapsedSeconds,
    required this.extraTimeSeconds,
  });

  final CardModel card;
  final int elapsedSeconds;
  final int extraTimeSeconds;

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    HapticFeedback.mediumImpact();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String _formatFocusTime(int seconds) {
    if (seconds < 60) return '$seconds seconds of focus';
    final minutes = seconds ~/ 60;
    return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} of focus';
  }

  Future<void> _handleDone() async {
    await _maybeRequestNotificationPermission();
    await _maybeShowExplainer();
    if (!mounted) return;

    // Show continuation prompt if card has a goal label
    if (widget.card.goalLabel != null && widget.card.goalLabel!.isNotEmpty) {
      _showContinuationPrompt();
    } else {
      Navigator.of(
        context,
      ).pushAndRemoveUntil(fadeRoute(const DeckScreen()), (route) => false);
    }
  }

  void _showContinuationPrompt() {
    showModalBottomSheet<bool>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: false,
      builder: (_) => const _ContinuationPromptSheet(),
    ).then((continueNext) {
      if (!mounted) return;
      if (continueNext == true) {
        Navigator.of(context).pushAndRemoveUntil(
          fadeRoute(NextStepScreen(goalLabel: widget.card.goalLabel!)),
          (route) => route.isFirst,
        );
      } else {
        Navigator.of(
          context,
        ).pushAndRemoveUntil(fadeRoute(const DeckScreen()), (route) => false);
      }
    });
  }

  Future<void> _maybeRequestNotificationPermission() async {
    try {
      final prefs = SharedPreferencesAsync();
      final asked =
          await prefs.getBool('hasAskedNotificationPermission') ?? false;
      if (asked) return;
      await prefs.setBool('hasAskedNotificationPermission', true);
      await NotificationService.instance.requestPermission();
    } catch (_) {}
  }

  Future<void> _maybeShowExplainer() async {
    try {
      final prefs = SharedPreferencesAsync();
      final seen = await prefs.getBool('hasSeenExplainer') ?? false;
      if (seen) return;
      await prefs.setBool('hasSeenExplainer', true);
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const _ExplainerSheet(),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Confetti anchored at top-center
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  numberOfParticles: 30,
                  maxBlastForce: 20,
                  minBlastForce: 8,
                  emissionFrequency: 0.05,
                  colors: const [
                    Color(0xFFFFD700),
                    Color(0xFFFF6B6B),
                    Color(0xFF4ECDC4),
                    Color(0xFF95E1D3),
                    Color(0xFFF38181),
                  ],
                ),
              ),
              // Main content
              Align(
                alignment: const Alignment(0, -0.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.page,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'You did it.',
                        style: AppTextStyles.completion,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _formatFocusTime(widget.elapsedSeconds),
                        style: AppTextStyles.bodyMuted,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // I'm finished — go straight home
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context)
                              .pushAndRemoveUntil(
                                fadeRoute(const DeckScreen()),
                                (route) => false,
                              ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textMuted,
                            side: const BorderSide(color: AppColors.border),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("I'm finished"),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Do next task — runs full post-completion flow
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _handleDone,
                          child: const Text('Do next task'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Post-Completion Explainer ────────────────────────────────────────────────

class _ExplainerSheet extends StatelessWidget {
  const _ExplainerSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("That's how it works.", style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            "Two minutes was enough to start. The hardest part isn't the doing — it's deciding to begin. You just did that.",
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

// ─── Continuation Prompt ──────────────────────────────────────────────────────

class _ContinuationPromptSheet extends StatelessWidget {
  const _ContinuationPromptSheet();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.md + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nice work.', style: AppTextStyles.headline),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Ready for the next tiny step?',
            style: AppTextStyles.bodyMuted,
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes, let's continue"),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Not now'),
            ),
          ),
        ],
      ),
    );
  }
}
