# Phase 12 UI Polish — Roadmap
*Apr 7, 2026*

> Paired plan: [2026-04-07-phase-12-ui-polish.md](2026-04-07-phase-12-ui-polish.md)

**Note: Avoid over-engineering, cruft, and legacy-compatibility features in this clean code project.**

---

## Tasks

- [x] Fix completion screen: show `actionLabel`, rename button to "Go Back to Home", add `onNextStep` callback + "Plan my next step →" `OutlinedButton`
- [x] Update both `CompletionScreen` callers in `deck_screen.dart` to pass `onNextStep`
- [x] Voice AI suggestions screen: icon size `18` → `22`; confirm icon color `textFaint` → `textPrimary`
- [x] Card detail sheet: replace `TextButton` secondary actions with `OutlinedButton` style
- [x] Remove "Continue →" nudge from deck list cards; clean up `_recentGoalLabels` state and `_CardTile` props
- [x] Fix `TextEditingController` disposed-before-rebuild crash in `_showEditSheet` — extracted `_EditCardSheet` `StatefulWidget`
- [x] Confetti on timer overtime moved to "I'm finished" tap; overtime "Do next task" removed; overtime finish routes to `CelebrationScreen`
- [x] Completion screens unified layout: small muted task label → randomized headline → focus time (where available) → buttons
- [x] Button order swapped: "Do next task" / "Plan my next step →" = `FilledButton`; "Go back to home" = `OutlinedButton`
- [x] Randomized celebration headline (`celebrationPhrases` const list, 10 phrases, shared across both screens)
- [x] Removed post-completion explainer sheet ("That's how it works.") and continuation prompt ("Ready for the next tiny step?") from `CelebrationScreen` — both added modal friction after task completion; "Do next task" now navigates directly to `DeckScreen`

---

## Status: Complete
