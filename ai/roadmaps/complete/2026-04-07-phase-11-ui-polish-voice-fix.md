# Phase 11 — UI Polish & Voice Fix
*Created: April 7, 2026*
*Roadmap: [Roadmap — Phase 11](2026-04-07-roadmap-phase-11-ui-polish-voice-fix.md)*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> This is a clean codebase with no migration debt. Every new screen, model field, and abstraction must earn its place. If a simpler approach works, use it. Delete code freely. Build for what's needed now, not for hypothetical future requirements.

---

## Goal

Fix four usability issues from hands-on testing: shorten the voice transcription button text that wraps awkwardly, add confetti to the goal-completion screen for consistency, fix voice-created tasks so they use the correct task hierarchy and support continuation flow, and fix the card detail bottom sheet overflow that hides Edit/Complete.

---

## Background & Context

### Why this exists
User testing surfaced four polish/functionality issues:
1. The transcription modal's "Create cards from this" button text wraps and looks awkward next to "Discard".
2. The CompletionScreen (shown when marking a goal complete from the deck) has no confetti — only the CelebrationScreen (shown after timer) does. These should feel consistent.
3. Voice-created tasks are stored as `actionLabel` only (no `goalLabel`), which means they never get "What's next?" in the detail sheet and "Do next task" just returns to deck. The voice input also maps titles to the wrong field — a phrase like "Finish history essay" should be the big task (goal), not the tiny step (action).
4. The card detail bottom sheet overflows by ~1.3px when a card has a goalLabel and the "What's next?" row is visible, cutting off the Edit/Complete row.

### What already exists (do not rebuild)
- `lib/screens/deck/widgets/voice_input_sheet.dart` — transcription modal with "Discard" and "Create cards from this" buttons (lines 304–320)
- `lib/screens/deck/completion_screen.dart` — goal-completion screen with animated checkmark, no confetti (uses `TickerProviderStateMixin` for scale animation)
- `lib/screens/timer/celebration_screen.dart` — timer-completion screen WITH confetti (imports `package:confetti/confetti.dart`)
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — AI suggestion list; `_onAddSelected()` (lines 68–91) batch-creates cards with `actionLabel` only, no `goalLabel`
- `lib/screens/deck/widgets/card_detail_sheet.dart` — bottom sheet with Start, What's next, Edit, Complete (107 lines total)

### Design decisions locked in
- Shorten the white button to "Create cards" (two words, no wrapping)
- Add confetti + haptic to CompletionScreen to match CelebrationScreen's celebratory feel
- Voice-created tasks: the AI-extracted title becomes the `goalLabel`; `actionLabel` gets a generic starter like "Get started" so the card is immediately usable
- Card detail sheet overflow: reduce spacing or wrap content to prevent overflow on cards with goals

---

## User Flows

### Fix 1: Transcription button text

```
Voice Input Sheet (after recording)
  "Your transcription" header
  Editable text area
  [Discard]   [Create cards]    <-- shortened from "Create cards from this"
```

### Fix 2: Consistent completion confetti

```
Card Detail Sheet → tap "Complete" → CompletionScreen
  Confetti plays on entry (matches CelebrationScreen)
  Animated checkmark scales in
  Goal name displayed
  "Done. You finished it."
  [Back to deck]
```

### Fix 3: Voice task hierarchy

```
Voice Input Sheet → AI extracts tasks → VoiceAISuggestionsScreen
  User checks "Finish history essay", "Send emails to professors"
  Taps "Add selected"
    → Each task saved as:
        goalLabel = "Finish history essay"
        actionLabel = "Get started"
        durationSeconds = 120
    → Cards now have goals, so:
        - Card detail sheet shows "What's next?" button
        - Timer overtime "Do next task" routes to NextStepScreen
```

### Fix 4: Card detail sheet overflow

```
Card Detail Sheet (card with goalLabel):
  Task title
  Goal label
  [2 min] badge
  [Start] button
  What's next? →
  Edit    Complete        <-- no longer clipped
```

---

## Plan

### Feature 1 — Shorten Transcription Button Text

**Goal:** Prevent the white "Create cards" button from wrapping text awkwardly.

- In `lib/screens/deck/widgets/voice_input_sheet.dart`, line 317:
  - Change the `FilledButton` child text from `'Create cards from this'` to `'Create cards'`

**What NOT to do:**
- Don't change the button layout (flex ratios, Row structure)
- Don't change the Discard button
- Don't change what the button does (it still returns transcription text via `Navigator.pop`)

---

### Feature 2 — Add Confetti to CompletionScreen

**Goal:** Make the goal-completion screen feel as celebratory as the timer celebration screen.

- In `lib/screens/deck/completion_screen.dart`:
  - Import `package:confetti/confetti.dart` and `package:flutter/services.dart`
  - Add a `ConfettiController` (same setup as `celebration_screen.dart` lines 30–39)
  - Initialize and play confetti in `initState`, dispose in `dispose`
  - Fire `HapticFeedback.mediumImpact()` in `initState` (same as celebration)
  - Add a `ConfettiWidget` in a `Stack` above the existing content (same visual config as `celebration_screen.dart` lines 134–151)
- Keep the existing animated checkmark and "Done. You finished it." copy — just layer confetti on top

**What NOT to do:**
- Don't change the text copy or add new buttons
- Don't change navigation behavior (still calls `widget.onComplete` which goes back to deck)
- Don't add "I'm finished" / "Do next task" buttons — this screen is for goal completion, not timer completion
- Don't duplicate the entire CelebrationScreen — just add confetti and haptic to the existing screen

---

### Feature 3 — Fix Voice Task Hierarchy

**Goal:** Voice-created tasks should use the correct field mapping so they work with the continuation flow.

- In `lib/screens/create_card/voice_ai_suggestions_screen.dart`, in `_onAddSelected()` (lines 68–91):
  - Change the `CardModel` construction so the AI-extracted title is stored as `goalLabel` instead of `actionLabel`
  - Set `actionLabel` to a generic starter string like `'Get started'`
  - This means voice-created cards will have a goalLabel, which enables:
    - "What's next?" shows in the card detail sheet
    - "Do next task" in overtime routes to NextStepScreen instead of DeckScreen
    - "Continue ->" nudge appears on deck cards

**What NOT to do:**
- Don't change the AI prompt or `suggestTasksFromTranscription()` — the AI already extracts good task titles
- Don't add a new screen for entering the tiny step — the generic "Get started" is enough for now
- Don't change the "Add manually instead" flow
- Don't change the inline editing behavior for suggestions
- Don't modify `card_detail_sheet.dart` or `timer_screen.dart` — those already handle goalLabel correctly

---

### Feature 4 — Fix Card Detail Sheet Overflow

**Goal:** Prevent the Edit/Complete row from being clipped when a card has a goalLabel.

- In `lib/screens/deck/widgets/card_detail_sheet.dart`:
  - The current bottom padding (`AppSpacing.md + safePadding`) plus all the content rows adds up to slightly more than the sheet allows
  - Reduce the `SizedBox` height between the duration badge and the Start button (currently `AppSpacing.lg` at line 59) to `AppSpacing.md`
  - Reduce the `SizedBox` height between the "What's next?" button and the Edit/Complete row (currently `AppSpacing.xs` at line 84) to `4.0`
  - This reclaims enough vertical space to prevent the overflow

**What NOT to do:**
- Don't wrap content in a `SingleChildScrollView` — the sheet should fit without scrolling
- Don't remove the "What's next?" button
- Don't change the Edit/Complete row layout
- Don't change padding calculations for the safe area

---

## Out of Scope for This Phase

- Redesigning the voice flow entirely (multi-step breakdown per task)
- Adding a "define tiny step" screen for voice-created tasks
- Changes to the AI prompt or task extraction logic
- Timer behavior changes
- Swipe-to-complete gestures
- Changes to the CelebrationScreen itself

---

## Definition of Done

- [ ] "Create cards from this" button text shortened to "Create cards" — no text wrapping
- [ ] CompletionScreen plays confetti and haptic on entry, matching CelebrationScreen's celebration feel
- [ ] Voice-created tasks have `goalLabel` set to the AI title and `actionLabel` set to "Get started"
- [ ] Voice-created cards show "What's next?" in the card detail sheet
- [ ] Voice-created cards support "Do next task" continuation after timer overtime
- [ ] Card detail sheet does not overflow when showing a card with goalLabel
- [ ] Edit and Complete buttons are fully visible in the detail sheet
- [ ] `flutter analyze` clean
- [ ] No regressions in existing flows

---

## Dependencies

- [x] Phase 10 complete (batch save, overtime skip, continue nudge)
- [x] `confetti` package already in pubspec (used by CelebrationScreen)
- [x] Card model supports `goalLabel` field
- [x] Card detail sheet already handles `goalLabel` presence
