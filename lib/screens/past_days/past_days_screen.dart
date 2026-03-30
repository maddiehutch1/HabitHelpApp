import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models/card_model.dart';
import '../../data/repositories/card_repository.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../timer/timer_screen.dart';

class PastDaysScreen extends ConsumerStatefulWidget {
  const PastDaysScreen({super.key});

  @override
  ConsumerState<PastDaysScreen> createState() => _PastDaysScreenState();
}

class _PastDaysScreenState extends ConsumerState<PastDaysScreen> {
  final _repo = CardRepository();
  List<CardModel> _archivedCards = [];
  bool _loading = true;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _loadArchivedCards();
  }

  Future<void> _loadArchivedCards() async {
    try {
      final cards = await _repo.getArchivedByDate();
      setState(() {
        _archivedCards = cards;
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not load archived cards.')),
        );
      }
    }
  }

  Future<void> _openTimer(CardModel card) async {
    if (_navigating) return;
    setState(() => _navigating = true);
    await Navigator.of(context).push(fadeRoute(TimerScreen(card: card)));
    if (mounted) {
      setState(() => _navigating = false);
      await _loadArchivedCards();
    }
  }

  Future<void> _moveToToday(CardModel card) async {
    try {
      await _repo.moveToToday(card.id);
      await _loadArchivedCards();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${card.actionLabel}" moved to today'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not move card.')),
        );
      }
    }
  }

  void _showMoveToTodaySheet(CardModel card) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Move to today?',
              style: AppTextStyles.headline,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(card.actionLabel, style: AppTextStyles.bodyMuted),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _moveToToday(card);
                },
                child: const Text('Move to today'),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }

  Map<String, List<CardModel>> _groupByDate(List<CardModel> cards) {
    final Map<String, List<CardModel>> grouped = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final card in cards) {
      if (card.archivedDate == null) continue;

      final archivedDateTime =
          DateTime.fromMillisecondsSinceEpoch(card.archivedDate!);
      final archivedDay = DateTime(
        archivedDateTime.year,
        archivedDateTime.month,
        archivedDateTime.day,
      );

      String dateLabel;
      if (archivedDay == yesterday) {
        dateLabel = 'Yesterday';
      } else {
        dateLabel = DateFormat.MMMd().format(archivedDateTime);
      }

      if (!grouped.containsKey(dateLabel)) {
        grouped[dateLabel] = [];
      }
      grouped[dateLabel]!.add(card);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedCards = _groupByDate(_archivedCards);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.md,
                AppSpacing.page,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
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
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Text('Past Days', style: AppTextStyles.screenTitle),
                ],
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.textMuted,
                      ),
                    )
                  : _archivedCards.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.page),
                            child: Text(
                              'No past days yet. Cards will appear here each day when you enable Fresh Start mode.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMuted,
                            ),
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          children: [
                            for (final entry in groupedCards.entries) ...[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  AppSpacing.sm,
                                  AppSpacing.sm,
                                  AppSpacing.sm,
                                  AppSpacing.xs,
                                ),
                                child: Text(
                                  entry.key,
                                  style: AppTextStyles.label.copyWith(
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              for (final card in entry.value)
                                _PastDayCardTile(
                                  card: card,
                                  onTap: () => _openTimer(card),
                                  onLongPress: () => _showMoveToTodaySheet(card),
                                ),
                            ],
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Past Day Card Tile ───────────────────────────────────────────────────────

class _PastDayCardTile extends StatelessWidget {
  const _PastDayCardTile({
    required this.card,
    required this.onTap,
    required this.onLongPress,
  });

  final CardModel card;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Semantics(
        button: true,
        label: '${card.actionLabel}. Tap to start timer, long press for options.',
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.actionLabel,
                        style: AppTextStyles.cardAction,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (card.goalLabel != null && card.goalLabel!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            card.goalLabel!,
                            style: AppTextStyles.cardGoal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(card.durationLabel, style: AppTextStyles.badge),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
