# Phase 12 UI Polish — Plan
*Apr 7, 2026*

> Paired roadmap: [2026-04-07-roadmap-phase-12-ui-polish.md](2026-04-07-roadmap-phase-12-ui-polish.md)

**Note: Avoid over-engineering, cruft, and legacy-compatibility features in this clean code project.**

---

## Goals

Polish several areas of the UI based on UX testing feedback, and remove friction for demo readiness:

1. Fix the completion screen copy (showed the big goal instead of the small step completed) and unify button labels across all completion flows.
2. Improve the voice AI suggestions edit/confirm icon affordance — they were too small and hard to distinguish.
3. Redesign the card detail sheet secondary buttons to have proper visual weight without competing with the primary Start action. Remove the inline "Next Step →" nudge from deck list cards — it added visual noise and cognitive load without adding value beyond the detail sheet.
4. Remove post-completion modals (explainer + continuation prompt) that broke momentum and were redundant.
5. Add "Save for later" to `NextStepScreen` to match the create card flow.
6. Update welcome screen branding to "MicroDeck" with "Deck" bolded.

---

## Changes

### 1. `lib/screens/deck/completion_screen.dart`
- Show `widget.card.actionLabel` (the small step) instead of `goalLabel ?? actionLabel`
- Removed `onNextStep` prop — both "Do next task" (FilledButton) and "Go back to home" (OutlinedButton) call `onComplete` and navigate to `DeckScreen`
- UI now matches `CelebrationScreen` exactly

### 2. `lib/screens/deck/deck_screen.dart`
- Both `CompletionScreen` usages (card detail action + swipe-to-complete) updated to remove `onNextStep` — completion always returns to `DeckScreen`
- Removed `_recentGoalLabels` state field
- Removed `getGoalLabelsWithRecentSessions()` call from `_onLoad()`
- Removed `showContinueNudge` and `onContinue` props from `_CardTile` and all call sites
- Removed "Next Step →" `OutlinedButton` from `_CardTile` body

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

- Both `CelebrationScreen` and `CompletionScreen` use "Do next task" (FilledButton, primary) + "Go back to home" (OutlinedButton, secondary)
- Shared `const celebrationPhrases` list (10 phrases) in `celebration_screen.dart`; both screens pick a random phrase per session so completion never feels repetitive

---

### 6. Remove post-completion modals from `CelebrationScreen`

- Removed `_ExplainerSheet` ("That's how it works.") — timing was backwards; it fired after the user already completed a task, so the lesson was redundant
- Removed `_ContinuationPromptSheet` ("Ready for the next tiny step?") — redundant with the deck screen, which already surfaces all available cards; the double-modal chain broke momentum on the celebration screen
- `_handleDone` now navigates directly to `DeckScreen` for both "Do next task" and "Go back to home"
- Removed unused imports: `shared_preferences`, `notification_service`, `next_step_screen`

---

### 7. "Save for later" on `NextStepScreen`

- Added `_saveLater()` method and `_submitting` guard
- Extracted shared `_buildAndSaveCard()` helper used by both `_start()` and `_saveLater()`
- "Save for later" `TextButton` added below "Start" — saves card to deck without starting the timer, navigates to `DeckScreen`
- Matches the `CreateCardConfirmScreen` pattern

### 8. Welcome screen branding

- App name updated from "Micro-Deck" to "MicroDeck"
- Rendered via `RichText`/`TextSpan`: "Micro" at `FontWeight.w300`, "Deck" at `FontWeight.w700` — visually joined, "Deck" bolded

---

## Out of Scope

- No changes to timer, notification, or data layer
