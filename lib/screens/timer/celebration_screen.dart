import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/card_model.dart';
import '../../routes.dart';
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

const celebrationPhrases = [
  'You did it.',
  'Nice work.',
  'Nailed it.',
  'Way to go.',
  "That's a win.",
  'You showed up.',
  'One step done.',
  'Look at that.',
  'That counts.',
  'Momentum built.',
];

class _CelebrationScreenState extends State<CelebrationScreen> {
  late final ConfettiController _confettiController;
  final String _headline = (celebrationPhrases.toList()..shuffle()).first;

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

  void _handleNextTask() {
    Navigator.of(context).pushAndRemoveUntil(
      fadeRoute(NextStepScreen(goalLabel: widget.card.goalLabel!)),
      (route) => route.isFirst,
    );
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
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _formatFocusTime(widget.elapsedSeconds),
                        style: AppTextStyles.bodyMuted,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      if (widget.card.goalLabel != null && widget.card.goalLabel!.isNotEmpty) ...[
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _handleNextTask,
                            child: const Text('Do next task'),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () =>
                              Navigator.of(context).pushAndRemoveUntil(
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
                          child: const Text('Go back to home'),
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

