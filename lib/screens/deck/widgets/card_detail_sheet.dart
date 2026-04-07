import 'package:flutter/material.dart';

import '../../../data/models/card_model.dart';
import '../../../theme.dart';

class CardDetailSheet extends StatelessWidget {
  const CardDetailSheet({
    super.key,
    required this.card,
    required this.onStart,
    required this.onEdit,
    required this.onComplete,
    this.onContinue,
  });

  final CardModel card;
  final VoidCallback onStart;
  final VoidCallback onEdit;
  final VoidCallback onComplete;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    final safePadding = bottomInset > 24.0 ? bottomInset : 24.0;
    final hasGoal = card.goalLabel != null && card.goalLabel!.isNotEmpty;

    final compactTextButtonStyle = TextButton.styleFrom(
      foregroundColor: AppColors.textFaint,
      textStyle: const TextStyle(fontSize: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.md + safePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(card.actionLabel, style: AppTextStyles.cardAction),
          if (hasGoal) ...[
            const SizedBox(height: 6),
            Text(card.goalLabel!, style: AppTextStyles.cardGoal),
          ],
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(card.durationLabel, style: AppTextStyles.badge),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onStart,
              child: const Text('Start'),
            ),
          ),
          if (hasGoal) ...[
            const SizedBox(height: AppSpacing.xs),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onContinue,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("What's next?"),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit'),
                style: compactTextButtonStyle,
              ),
              const SizedBox(width: 24),
              TextButton.icon(
                onPressed: onComplete,
                icon: const Icon(Icons.check),
                label: const Text('Complete'),
                style: compactTextButtonStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
