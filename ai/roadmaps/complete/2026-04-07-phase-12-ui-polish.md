# Phase 12 UI Polish — Plan
*Apr 7, 2026*

> Paired roadmap: [2026-04-07-roadmap-phase-12-ui-polish.md](2026-04-07-roadmap-phase-12-ui-polish.md)

**Note: Avoid over-engineering, cruft, and legacy-compatibility features in this clean code project.**

---

## Goals

Polish three areas of the UI based on UX testing feedback:

1. Fix the completion screen copy (showed the big goal instead of the small step completed), rename the primary button, and add a "Plan my next step" shortcut.
2. Improve the voice AI suggestions edit/confirm icon affordance — they were too small and hard to distinguish.
3. Redesign the card detail sheet secondary buttons to have proper visual weight without competing with the primary Start action. Remove the inline "Continue →" nudge from deck list cards — it added visual noise and cognitive load without adding value beyond the detail sheet.

---

## Changes

### 1. `lib/screens/deck/completion_screen.dart`
- Show `widget.card.actionLabel` (the small step) instead of `goalLabel ?? actionLabel`
- Rename primary button "I'm finished" → "Go Back to Home"
- Add optional `VoidCallback? onNextStep` parameter
- When `onNextStep != null` and card has a `goalLabel`, show a full-width `OutlinedButton` ("Plan my next step →") that fades in with the primary button

### 2. `lib/screens/deck/deck_screen.dart`
- Both `CompletionScreen` usages (card detail action + swipe-to-complete) updated to pass `onNextStep` callback that: completes the card, pops to DeckScreen, then pushes `NextStepScreen`
- Only passed when `card.goalLabel` is non-empty
- Removed `_recentGoalLabels` state field
- Removed `getGoalLabelsWithRecentSessions()` call from `_onLoad()`
- Simplified `_CardTile` call site — removed `showContinueNudge` and `onContinue` args
- Cleaned up `_CardTile` widget — removed those props and the nudge `OutlinedButton`

### 3. `lib/screens/create_card/voice_ai_suggestions_screen.dart`
- Edit/confirm icon size: `18` → `22`
- Confirm (checkmark) icon color: `AppColors.textFaint` → `AppColors.textPrimary`
- Pencil icon stays `AppColors.textFaint`

### 4. `lib/screens/deck/widgets/card_detail_sheet.dart`
- "What's next?" changed from `TextButton` → full-width `OutlinedButton` (border `AppColors.surfaceHigh`, foreground `AppColors.textMuted`)
- Edit + Complete changed from `TextButton.icon` row → equal-width `OutlinedButton.icon` row with same subdued style
- Button hierarchy: FilledButton (Start) → OutlinedButton (What's next?) → OutlinedButton row (Edit | Complete)

---

### 5. Completion screen button order & randomized headline

- Swap primary/secondary buttons on both `CelebrationScreen` and `CompletionScreen`: "Do next task" / "Plan my next step →" is now `FilledButton` (primary); "Go back to home" is now `OutlinedButton` (secondary)
- Extract a shared `const celebrationPhrases` list in `celebration_screen.dart`; both screens pick a random phrase in `initState` so the headline never feels repetitive
  - Phrases: "You did it.", "Nice work.", "Nailed it.", "Way to go.", "That's a win.", "You showed up.", "One step done.", "Look at that.", "That counts.", "Momentum built."

---

### 6. Remove post-completion modals from `CelebrationScreen`

- Removed `_ExplainerSheet` ("That's how it works.") — timing was backwards; it fired after the user already completed a task, so the lesson was redundant
- Removed `_ContinuationPromptSheet` ("Ready for the next tiny step?") — redundant with the deck screen, which already surfaces all available cards; the double-modal chain broke momentum on the celebration screen
- `_handleDone` now navigates directly to `DeckScreen` for both "Do next task" and "Go back to home"
- Removed unused imports: `shared_preferences`, `notification_service`, `next_step_screen`

---

## Out of Scope

- No changes to timer, notification, or data layer
- No new screens or routes
