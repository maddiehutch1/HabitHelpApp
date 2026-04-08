import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/card_model.dart';
import '../../theme.dart';
import '../timer/celebration_screen.dart' show celebrationPhrases;

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
  final String _headline = (celebrationPhrases.toList()..shuffle()).first;

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

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonOpacity = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    );

    _buttonTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _buttonTimer?.cancel();
    _buttonController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasNextStep =
        widget.card.goalLabel != null &&
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
                numberOfParticles: 10,
                maxBlastForce: 15,
                minBlastForce: 5,
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
                      widget.card.actionLabel,
                      style: AppTextStyles.bodyMuted,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _headline,
                      style: AppTextStyles.completion,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    FadeTransition(
                      opacity: _buttonOpacity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasNextStep) ...[
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: widget.onNextStep,
                                child: const Text('Plan my next step →'),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                          ],
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: widget.onComplete,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textMuted,
                                side: const BorderSide(color: AppColors.border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Go back to home'),
                            ),
                          ),
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
