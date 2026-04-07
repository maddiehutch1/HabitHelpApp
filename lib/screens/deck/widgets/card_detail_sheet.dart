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

    final secondaryOutlinedStyle = OutlinedButton.styleFrom(
      foregroundColor: AppColors.textMuted,
      side: const BorderSide(color: AppColors.surfaceHigh),
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
          const SizedBox(height: AppSpacing.md),
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
              child: OutlinedButton(
                onPressed: onContinue,
                style: secondaryOutlinedStyle,
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
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                  style: secondaryOutlinedStyle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Complete'),
                  style: secondaryOutlinedStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
