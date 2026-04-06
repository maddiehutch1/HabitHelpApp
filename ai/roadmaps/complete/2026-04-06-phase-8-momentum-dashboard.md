# Phase 8 — Momentum & Dashboard Redesign
*Created: April 6, 2026*
*Part of: Micro-Deck v2 Feature Expansion*
*Previous: [Phase 7 — Voice AI Suggestions](complete/2026-03-31-phase-7-voice-ai-suggestions.md)*
*Roadmap: [Roadmap — Phase 8](2026-04-06-roadmap-phase-8-momentum-dashboard.md)*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> This is a clean codebase with no migration debt. Every new screen, model field, and abstraction must earn its place. If something feels like scaffolding for a future feature, cut it.

---

## Goal

Redesign the home dashboard interaction model and add a momentum-capture flow that helps users naturally continue from one tiny step to the next. When a user finishes a timer, they should be gently prompted to define their next step — and when they return to the deck later, they should see a subtle nudge to pick up where they left off.

**The single sentence version:** Make finishing one step the natural on-ramp to the next one.

---

## Background & Context

### Why this exists

The current app does a great job getting users to *start* — but after the 2-minute timer ends, the flow dead-ends. The user taps "Done" and lands on the deck with no sense of what comes next. For ADHD users, that gap between "I just did something" and "what now?" is exactly where momentum dies.

Additionally, the deck's tap-to-start behavior gives no way to view, edit, or complete a card. Users can't fix typos, can't mark goals as finished, and get no satisfaction from completing something. The "rest" / archive prompt mechanic is confusing and doesn't map to how users think about their tasks.

### What already exists (do not rebuild)

- `lib/screens/timer/timer_screen.dart` — timer with Done / Keep going buttons
- `lib/screens/deck/deck_screen.dart` — card list with tap-to-start and swipe-to-defer
- `lib/screens/create_card/create_card_action_screen.dart` — action input with AI assist (reusable pattern)
- `lib/services/ai_service.dart` — OpenAI integration with `generateFirstSteps()` and `makeSmaller()`
- `lib/data/models/card_model.dart` — card model with `goalLabel`, `actionLabel`, `isArchived`
- `lib/data/repositories/card_repository.dart` — all DB access
- `lib/providers/cards_provider.dart` — Riverpod state management

### Design decisions locked in (from planning discussion)

- **Tap card → bottom sheet** (not full-screen detail page). The sheet has "Start" as the dominant action, with Continue / Edit / Complete below. This preserves low-friction starting.
- **No duration picker** on the continuation flow. Timer is always 2 minutes. "Keep going" handles extensions. This is core philosophy.
- **Continuation prompt only after "Done"** — never after "End session" (paused bail-out). Prompting someone who quit early would feel like pressure.
- **"Complete" is not "rest"** — completing a goal is a deliberate, satisfying action. Rest/archive prompt (3-deferral mechanic) is being removed.
- **Next step = new card with same goalLabel** — no sub-task hierarchy, no parent-child relationships. The connection between cards is implicit (shared goal text).
- **Completion celebration is warm but minimal** — a brief full-screen moment with affirming copy, not confetti or gamification.
- **AI button on next-step screen** — uses existing `generateFirstSteps()` pattern, clearly visible and optional.
- **Dashboard nudge is goal-scoped** — only shows "Continue" on cards where the user has recent session activity on that goal.

---

## User Flows

### Flow A — Continuation after timer

```
Timer completes → user taps "Done"
  ↓
Session stored (existing behavior)
  ↓
Post-completion handled (notifications, explainer — existing behavior)
  ↓
Continuation Prompt (NEW)
  "Nice work. Ready for the next tiny step?"
  [Yes, let's go]  [Not now]
  ↓                    ↓
NextStepScreen      DeckScreen
  ↓                 (with nudge on this goal)
Shows goal at top
"What's the next tiny step?"
  [text input]
  [✨ Help me think of one]  ← AI button
  ↓
[Start] button
  ↓
Creates new card (same goalLabel, new actionLabel)
  ↓
TimerScreen (2 min, standard)
  ↓
(cycle repeats — continuation prompt again after Done)
```

### Flow B — Card detail bottom sheet

```
Deck → tap any card
  ↓
Bottom sheet slides up:
  ┌─────────────────────────────────┐
  │  "Put on running shoes"         │  ← action label
  │   Goal: Get back into running   │  ← goal label (if present)
  │   2 min                         │  ← duration badge
  │                                 │
  │  ┌───────────────────────────┐  │
  │  │    ▶ Start  (2 min)      │  │  ← primary FilledButton
  │  └───────────────────────────┘  │
  │                                 │
  │  What's next? →                 │  ← goes to NextStepScreen
  │  Edit                           │  ← inline edit mode
  │  Complete ✓                     │  ← marks goal as done
  └─────────────────────────────────┘
```

### Flow C — Completion celebration

```
Bottom sheet → tap "Complete ✓"
  ↓
Full-screen completion moment:
  ┌─────────────────────────────────┐
  │                                 │
  │        ✓ (animated check)       │
  │                                 │
  │  "Get back into running"        │  ← goal label, large
  │                                 │
  │     Done. You finished it.      │  ← warm, simple copy
  │                                 │
  │       [Back to deck]            │  ← fades in after ~1.5s
  └─────────────────────────────────┘
  ↓
Card gets completedAt timestamp
Card removed from active deck
Visible in Past Days under "Completed" section
```

### Flow D — Dashboard nudge

```
Deck screen, normal view:
  Each card tile checks: does this goal have a recent session?
  If yes → show subtle "Continue →" chip on the tile
  ↓
Tap "Continue →"
  ↓
NextStepScreen (same as Flow A, pre-filled with this card's goalLabel)
```

---

## Plan

### Feature 1 — Data Model Changes

**Goal:** Add `completedAt` to CardModel and migrate the database.

- Add `completedAt` field (nullable `int`) to `CardModel`
- Update `toMap()` and `fromMap()` in `card_model.dart`
- Add database migration: version 4 → 5, `ALTER TABLE cards ADD COLUMN completedAt INTEGER`
- Update `database.dart` `onUpgrade` to handle version 5
- Add `completeCard(String cardId)` method to `card_repository.dart` — sets `completedAt` to current timestamp and `isArchived = 1`
- Add `getCompletedCards()` method to `card_repository.dart` — returns cards where `completedAt IS NOT NULL`, ordered by `completedAt DESC`
- Wire through to `cards_provider.dart` — add `completeCard()` and `getCompletedCards()` methods to the notifier

**What NOT to do:**
- Do not add sub-task relationships, parent IDs, or hierarchy fields
- Do not add a separate "completed" table — reuse the cards table with the new column
- Do not change the meaning of `isArchived` — completed cards are also archived, they just have a `completedAt` timestamp too

---

### Feature 2 — Card Detail Bottom Sheet

**Goal:** Replace tap-to-start with a bottom sheet that shows card details and multiple actions.

- Create `lib/screens/deck/widgets/card_detail_sheet.dart` — a new widget for the bottom sheet
- The sheet receives a `CardModel` and callbacks for each action
- **Layout (top to bottom):**
  - Action label (large text, `AppTextStyles.cardAction` or similar)
  - Goal label below it (muted, `AppTextStyles.cardGoal`) — only if goalLabel is non-null/non-empty
  - Duration badge
  - Vertical spacing
  - **"Start" button** — full-width `FilledButton`, primary action, visually dominant
  - **"What's next?"** — `TextButton` or subtle row, navigates to NextStepScreen with this card's goalLabel
  - **"Edit"** — `TextButton`, opens edit mode (see Feature 3)
  - **"Complete"** — `TextButton` with check icon, triggers completion flow
- In `deck_screen.dart`, change `_openTimer(card)` to `_openCardDetail(card)` which shows this bottom sheet
- The "Start" action in the sheet calls the existing timer navigation (`Navigator.push → TimerScreen(card: card)`)
- Swipe-to-defer ("Later") behavior on the card list remains unchanged

**What NOT to do:**
- Do not create a full-screen detail page — the bottom sheet is intentionally lightweight
- Do not add navigation complexity — the sheet is a simple modal, dismissed when any action is taken

---

### Feature 3 — Edit Card

**Goal:** Allow users to edit a card's action label and goal label from the detail bottom sheet.

- Add an edit mode to the card detail sheet — when "Edit" is tapped, the labels become editable `TextField`s pre-filled with current values
- Show a "Save" button that calls a new `updateCard()` method
- Add `updateCard(String cardId, {String? goalLabel, String? actionLabel})` to `card_repository.dart`
- Wire through to `cards_provider.dart`
- After saving, dismiss the sheet and reload the deck
- If user dismisses without saving (swipe down, back), discard changes — no confirmation dialog needed

**What NOT to do:**
- Do not allow editing duration from this sheet — keep it simple
- Do not create a separate edit screen — inline editing in the sheet is sufficient

---

### Feature 4 — Completion Flow & Celebration

**Goal:** When user taps "Complete" on a card, show a brief, warm celebration screen and archive the card as completed.

- Create `lib/screens/deck/widgets/completion_screen.dart` (or handle inline in deck_screen — implementer's choice based on complexity)
- **When "Complete" is tapped in the detail sheet:**
  1. Dismiss the bottom sheet
  2. Navigate to a full-screen completion moment
- **Completion screen layout:**
  - Dark background (consistent with app theme)
  - Animated checkmark — a simple scale + fade-in animation, nothing flashy. A circular outline that draws itself or a check icon that fades in works well.
  - Goal label displayed large and centered below the check
  - Warm copy below: pick one of a few rotating messages like "Done. You finished it.", "That's a wrap.", "You did it." — or just use a single static message. Keep it simple for v1.
  - "Back to deck" button — fades in after ~1.5 second delay (using `AnimationController` + `Timer`)
- **On "Back to deck":**
  - Call `completeCard(cardId)` on the provider (sets `completedAt`, archives the card)
  - Navigate back to DeckScreen
  - Card should no longer appear in active deck
- **Completion should feel final but not permanent** — completed cards are visible in Past Days if the user ever wants to look back

---

### Feature 5 — Past Days: Completed Section

**Goal:** Show completed cards in the Past Days screen, clearly distinguished from daily-rollover archived cards.

- In `past_days_screen.dart`, add a "Completed" section above or below the existing date-grouped archived cards
- Query completed cards using the new `getCompletedCards()` repository method
- Each completed card shows:
  - Goal label (primary text)
  - Action label (secondary, muted)
  - Completed date (formatted, muted)
- No restore action on completed cards — they're done. If the user wants to reopen a goal, they can create a new card.
- Keep the existing date-grouped archived cards section unchanged

**What NOT to do:**
- Do not build a stats/analytics view — just a simple list
- Do not add undo/restore for completed cards in this phase

---

### Feature 6 — NextStepScreen

**Goal:** A screen where the user defines their next tiny step for a goal, with optional AI assistance.

- Create `lib/screens/create_card/next_step_screen.dart`
- **Receives:** `String goalLabel` (the goal they're continuing)
- **Layout (top to bottom):**
  - Goal context label at top — shows the goal text in muted style so the user knows what they're continuing
  - Prompt: "What's the next tiny step?" (or similar calm copy)
  - `TextField` for the next action — same style as `CreateCardActionScreen`
  - **AI button** — prominent, clearly visible. Label: "Help me think of one" (or similar). Uses `AIService.generateFirstSteps(goalLabel)` to get suggestions, shown as tappable chips below the text field (same pattern as `CreateCardActionScreen`)
  - **"Make this smaller"** button — appears after user types something, same as existing pattern
  - **"Start" button** — full-width `FilledButton` at bottom. Creates a new card with the same `goalLabel` and the entered `actionLabel`, duration 120s, then immediately navigates to `TimerScreen` with that card.
- The new card should be inserted at the top of the deck (`sortOrder = 0`, bump others)
- After the timer flow completes, the continuation prompt will appear again (natural cycle)

**Reuse patterns from `CreateCardActionScreen`:**
- AI consent check before calling AI
- Loading state while AI responds
- Suggestion chips UI
- Input validation (non-empty action label)

**What NOT to do:**
- Do not add a "Save for later" button on this screen — if they got here, they want to start. If they back out, no card is created. Simple.
- Do not create a new AI method — reuse `generateFirstSteps()` which already does exactly this
- Do not allow changing the goal label from this screen — it's inherited from the parent card

---

### Feature 7 — Continuation Prompt (Post-Timer)

**Goal:** After timer completion, prompt the user to continue with their next tiny step.

- **Modify `timer_screen.dart`'s `_handleDone()` method:**
  1. Store session (existing)
  2. Handle post-completion (notifications, explainer — existing)
  3. Instead of navigating directly to DeckScreen, show a continuation prompt
- **Continuation prompt implementation** — a bottom sheet or a new in-screen state (implementer's choice). Bottom sheet is recommended for consistency.
- **Prompt content:**
  - Warm copy: "Nice work. Ready for the next tiny step?" (or similar)
  - **"Yes, let's go"** button → navigates to `NextStepScreen(goalLabel: widget.card.goalLabel)`. If `goalLabel` is null, skip the prompt entirely and go to deck (no goal = no continuation context).
  - **"Not now"** button → navigates to DeckScreen (existing `_goToDeck()` behavior)
- **Only show after "Done"** — the "End session" path (paused bail-out) should continue going directly to DeckScreen with no prompt
- **Only show if the card has a goalLabel** — cards without a goal have no continuation context

**What NOT to do:**
- Do not show the prompt after "End session" — that would feel like pressure on someone who bailed
- Do not make the prompt blocking or un-dismissible — "Not now" must always be available
- Do not persist the prompt state — it's ephemeral, shown once per timer completion

---

### Feature 8 — Dashboard Nudge ("Continue" chip)

**Goal:** On the deck screen, show a subtle "Continue" indicator on cards whose goal has recent activity, prompting the user to define their next step.

- **Logic to determine which cards get the nudge:**
  - Query the `sessions` table for sessions completed in the last 7 days
  - Group by the card's `goalLabel` (join sessions → cards to get goalLabels)
  - Any active card whose `goalLabel` matches a recently-active goal gets the nudge
  - Only show the nudge on the *most recent* card for that goal (by `createdAt` or `sortOrder`), not on every card with the same goal
- **UI change in `_CardTile`:**
  - Add an optional `showContinueNudge` boolean parameter
  - When true, show a small "Continue →" text button or chip below the goal label
  - Style: muted, subtle — `AppTextStyles.bodyMuted` or smaller, with an arrow. Should not compete with the main action label.
- **Tap behavior:**
  - Tapping the "Continue →" chip navigates to `NextStepScreen(goalLabel: card.goalLabel)`
  - Tapping the card tile itself still opens the card detail bottom sheet (Feature 2)
- **Data loading:**
  - Add a method to the repository: `getGoalLabelsWithRecentSessions({int days = 7})` — returns a `Set<String>` of goal labels that have sessions in the last N days
  - Call this in `_onLoad()` in `deck_screen.dart` and store the result in state
  - Pass the nudge flag when building each `_CardTile`

**What NOT to do:**
- Do not nudge every card — only the most relevant one per goal
- Do not show nudges on cards without a goalLabel
- Do not make the nudge visually loud — it should be noticeable but not feel like pressure

---

### Feature 9 — Remove Rest / Archive Prompt

**Goal:** Clean up the "rest" mechanic that no longer fits the mental model.

- **Remove the archive prompt sheet** (`_ArchivePromptSheet` in `deck_screen.dart`)
- **Remove `_checkArchivePrompts()`** and its call in `_onLoad()`
- **Remove `getCardsNeedingArchivePrompt()`** from `card_repository.dart` and `cards_provider.dart`
- **Keep swipe-to-defer** — it's still useful as a reordering mechanism ("Later" moves card to bottom of deck)
- **Keep the deferrals table** — it's cheap and the data could be useful later, but remove the code that checks deferral counts for archive prompts
- **Remove "rest" language** from Settings if it appears there (check `settings_screen.dart`)
- **Keep `isArchived` and `archivedDate`** — these are still used by Fresh Start daily rollover and now by completion. Just remove the "rest" UI and prompt logic.

**What NOT to do:**
- Do not delete the deferrals table or data
- Do not remove the Dismissible swipe behavior from the card list
- Do not remove Fresh Start mode or daily rollover — those are separate features

---

## Out of Scope for This Phase

- Sub-task hierarchy or parent-child card relationships
- Analytics or stats view for completed cards
- Undo/restore for completed cards
- Timer duration picker on the next-step flow
- "Save for later" on the NextStepScreen
- Changes to the onboarding flow (Welcome → Goal → Action → Confirm)
- Changes to voice input or VoiceAISuggestionsScreen
- Changes to Just One mode (it should continue working with the new bottom sheet)
- Any backend, cloud sync, or user accounts

---

## Definition of Done

- [ ] Tapping a card opens the detail bottom sheet with Start / What's next / Edit / Complete
- [ ] "Start" in the sheet opens the timer (same behavior as current tap-to-start)
- [ ] "Edit" allows inline editing of goal and action labels
- [ ] "Complete" shows a warm full-screen celebration, then archives the card with `completedAt`
- [ ] Completed cards appear in Past Days under a "Completed" section
- [ ] After timer "Done", continuation prompt asks "Ready for the next tiny step?"
- [ ] "Yes" on continuation prompt → NextStepScreen → new card created → timer starts
- [ ] "Not now" on continuation prompt → DeckScreen
- [ ] NextStepScreen shows goal context, text input, AI button, and Start button
- [ ] AI suggestions work on NextStepScreen (reuses `generateFirstSteps`)
- [ ] Dashboard shows subtle "Continue →" nudge on cards with recent goal activity
- [ ] Tapping "Continue →" nudge opens NextStepScreen
- [ ] Archive/rest prompt removed — no more "rest it" sheets
- [ ] Swipe-to-defer still works as reordering mechanism
- [ ] Just One mode still works correctly
- [ ] `flutter analyze` clean

---

## Dependencies

- Phase 7 complete ✅
- `ai_service.dart` operational ✅
- `card_repository.dart` and `cards_provider.dart` functional ✅
- Database migration system functional (currently version 4) ✅
