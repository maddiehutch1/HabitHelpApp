# Phase 10 — UX Fixes
*Created: April 6, 2026*
*Roadmap: [Roadmap — Phase 10](2026-04-06-roadmap-phase-10-ux-fixes.md)*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> This is a clean codebase with no migration debt. Every new screen, model field, and abstraction must earn its place. If a simpler approach works, use it. Delete code freely. Build for what's needed now, not for hypothetical future requirements.

---

## Goal

Fix three real usability issues surfaced from user testing: the "Continue" nudge on deck cards is too small to tap, overtime completion incorrectly shows a celebration, and the voice flow forces users through a tedious step-by-step card creation process instead of batch-saving.

---

## Background & Context

### Why this exists
User testing revealed three friction points that undermine the app's "low friction" philosophy. The Continue nudge is a tiny 12px text target. The timer overtime flow celebrates when users just want to keep going. And the voice suggestions flow forces users through CreateCardGoalScreen once per task instead of saving all at once.

### What already exists (do not rebuild)
- `lib/screens/deck/deck_screen.dart` — `_CardTile` widget renders the "Continue ->" nudge at line ~787 as a `GestureDetector` wrapping 12px `AppTextStyles.badge` text
- `lib/screens/timer/timer_screen.dart` — `_buildOvertimeBody()` at line ~306 shows "I'm finished" and "Do next task" buttons; `_handleOvertimeAction(doNextTask: true)` navigates to `CelebrationScreen`
- `lib/screens/timer/celebration_screen.dart` — always plays confetti in `initState()`, then offers continuation prompt
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — shows AI-extracted tasks as an editable checklist; `_onAddSelected()` queues checked items and processes them one-by-one through `CreateCardGoalScreen`

### Design decisions locked in
- The "Continue" nudge should become a full-width tappable tile area (not just the text)
- Overtime "Do next task" should skip the celebration screen entirely
- Voice suggestions should batch-save all checked items as cards directly, no step-by-step flow

---

## User Flows

### Fix 1: Continue nudge → larger tap target

```
Deck Screen
  Card tile with recent goal activity
    [entire "Continue ->" row is tappable, not just the text]
    Tap anywhere on the row → NextStepScreen
```

### Fix 2: Overtime → skip celebration

```
Timer (overtime, counting up)
  User taps "I'm finished" → DeckScreen (no change)
  User taps "Do next task"  → NextStepScreen directly (skip CelebrationScreen)
                               If card has no goalLabel → DeckScreen
```

### Fix 3: Voice suggestions → batch save

```
VoiceAISuggestionsScreen
  User checks/unchecks tasks, edits inline
  Taps "Add selected"
    → All checked items saved directly as cards (with goalLabel from transcription context)
    → Navigate back to DeckScreen
    → No step-by-step CreateCardGoalScreen flow
```

---

## Plan

### Feature 1 — Larger Continue Nudge Tap Target

**Goal:** Make the "Continue" nudge on deck cards easy to tap.

- In `lib/screens/deck/deck_screen.dart`, in the `_CardTile` widget (~line 787):
  - Wrap the "Continue ->" area in an `InkWell` or expand the existing `GestureDetector` to span the full width of the tile
  - Increase text size from `AppTextStyles.badge` (12px) to something more tappable (~14-15px)
  - Add vertical padding to increase the touch target to at least 44px height (Apple HIG minimum)
  - Keep the muted color — this is a secondary action, not a primary CTA

**What NOT to do:**
- Don't make it a full button with a border/background — it should still feel like a subtle nudge
- Don't change the condition for when the nudge appears (`showContinueNudge`)
- Don't modify the card detail sheet's "What's next?" button

---

### Feature 2 — Skip Celebration After Overtime

**Goal:** When the user has been working past 2 minutes and taps "Do next task", go directly to the next step without celebration.

- In `lib/screens/timer/timer_screen.dart`, in `_handleOvertimeAction()` (~line 178):
  - When `doNextTask` is true: instead of navigating to `CelebrationScreen`, navigate directly to `NextStepScreen` if the card has a `goalLabel`, otherwise to `DeckScreen`
  - The session is already saved before navigation — no data logic changes needed
- Optionally: update the button label from "Do next task" to "What's next?" to better match expectations

**What NOT to do:**
- Don't change the normal (non-overtime) completion flow — when the 2-min timer finishes naturally, the celebration is still appropriate
- Don't remove or modify `CelebrationScreen` itself
- Don't change the "I'm finished" button behavior

---

### Feature 3 — Batch Save Voice Suggestions

**Goal:** Save all checked voice suggestions as cards at once without going through CreateCardGoalScreen for each one.

- In `lib/screens/create_card/voice_ai_suggestions_screen.dart`, replace `_onAddSelected()` and `_processNextTask()`:
  - Instead of queuing tasks and navigating to `CreateCardGoalScreen` for each, directly create `CardModel` objects for each checked item
  - Use the card repository to batch-insert the new cards
  - Each card should have:
    - `actionLabel` set to the task title
    - `goalLabel` set to a reasonable default (could derive from the transcription or leave blank)
    - `durationSeconds` set to the default (120)
  - After saving, invalidate the card provider and navigate back to DeckScreen
- Remove or simplify `_processNextTask()` since it's no longer needed

**What NOT to do:**
- Don't remove the "Add manually instead" option — it still serves users who want the full flow
- Don't change the inline editing UI — it already works well
- Don't add a new screen or intermediate step

---

## Out of Scope for This Phase

- Swipe-to-complete gesture on deck cards (nice-to-have, deferred)
- Any timer behavior changes beyond the overtime flow
- Changes to the normal (non-overtime) celebration flow
- Redesigning the VoiceAISuggestionsScreen layout
- New AI features or prompt changes

---

## Definition of Done

- [ ] Continue nudge on deck cards has a tap target of at least 44px height
- [ ] Tapping "Do next task" in overtime mode does NOT show confetti or celebration
- [ ] Tapping "Do next task" in overtime mode navigates to NextStepScreen (if goal exists) or DeckScreen
- [ ] Normal timer completion (2 min) still shows celebration as before
- [ ] Voice "Add selected" saves all checked items as cards without step-by-step flow
- [ ] Voice "Add manually instead" still works as before
- [ ] `flutter analyze` clean
- [ ] No regressions in existing flows

---

## Dependencies

- [x] Phase 9 complete (card detail sheet, AI polish)
- [x] Card repository with insert support (`lib/data/repositories/`)
- [x] Riverpod card provider for invalidation
