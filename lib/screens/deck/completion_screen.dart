import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/card_model.dart';
import '../../theme.dart';

class CompletionScreen extends StatefulWidget {
  const CompletionScreen({
    super.key,
    required this.card,
    required this.onComplete,
    this.onNextStep,
  });

  final CardModel card;
  final VoidCallback onComplete;

  /// Optional callback for "Plan my next step". When provided and the card
  /// has a goalLabel, a secondary OutlinedButton is shown below the primary
  /// action.
  final VoidCallback? onNextStep;

  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen>
    with TickerProviderStateMixin {
  late final ConfettiController _confettiController;

  late final AnimationController _checkController;
  late final Animation<double> _checkScale;

  late final AnimationController _buttonController;
  late final Animation<double> _buttonOpacity;

  Timer? _buttonTimer;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    HapticFeedback.mediumImpact();
    _confettiController.play();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkScale = CurvedAnimation(
      parent: _checkController,
      curve: Curves.easeOutBack,
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonOpacity = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    );

    _checkController.forward();

    _buttonTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _buttonTimer?.cancel();
    _checkController.dispose();
    _buttonController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasNextStep = widget.card.goalLabel != null &&
        widget.card.goalLabel!.isNotEmpty &&
        widget.onNextStep != null;

    return Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.page),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ScaleTransition(
                      scale: _checkScale,
                      child: const Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      widget.card.actionLabel,
                      style: AppTextStyles.completion,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Done. You finished it.',
                      style: AppTextStyles.bodyMuted,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    FadeTransition(
                      opacity: _buttonOpacity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: widget.onComplete,
                              child: const Text('Go Back to Home'),
                            ),
                          ),
                          if (hasNextStep) ...[
                            const SizedBox(height: AppSpacing.xs),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: widget.onNextStep,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.textMuted,
                                  side: const BorderSide(
                                    color: AppColors.surfaceHigh,
                                  ),
                                ),
                                child: const Text('Plan my next step \u2192'),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
