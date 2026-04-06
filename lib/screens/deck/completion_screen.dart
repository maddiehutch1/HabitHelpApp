import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/models/card_model.dart';
import '../../theme.dart';

class CompletionScreen extends StatefulWidget {
  const CompletionScreen({
    super.key,
    required this.card,
    required this.onComplete,
  });

  final CardModel card;
  final VoidCallback onComplete;

  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _checkController;
  late final Animation<double> _checkScale;

  late final AnimationController _buttonController;
  late final Animation<double> _buttonOpacity;

  Timer? _buttonTimer;

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goalText = widget.card.goalLabel ?? widget.card.actionLabel;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
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
                  goalText,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: widget.onComplete,
                      child: const Text('Back to deck'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
