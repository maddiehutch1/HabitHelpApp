import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/card_model.dart';
import '../../routes.dart';
import '../../services/notification_service.dart';
import '../../theme.dart';
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
    Navigator.of(
      context,
    ).pushAndRemoveUntil(fadeRoute(const DeckScreen()), (route) => false);
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
              Center(
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
                      // Keep going (grayed, future feature)
                      SizedBox(
                        width: double.infinity,
                        child: Tooltip(
                          message: 'Coming soon',
                          child: TextButton(
                            onPressed: null,
                            child: const Text('Keep going'),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      // Done
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _handleDone,
                          child: const Text('Done'),
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
