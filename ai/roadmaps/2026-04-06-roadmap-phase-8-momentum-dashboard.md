# Roadmap — Phase 8: Momentum & Dashboard Redesign
*Created: April 6, 2026*
*Detailed plan: [Phase 8 Plan](2026-04-06-phase-8-momentum-dashboard.md)*
*Previous: [Phase 7 — Voice AI Suggestions](complete/2026-03-31-phase-7-voice-ai-suggestions.md)*
*Status: 🔲 Not started*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Redesign the deck interaction model (tap → bottom sheet with Start / Edit / Complete / Continue) and add a momentum-capture flow (post-timer continuation prompt + dashboard nudge) so that finishing one tiny step naturally leads to defining the next one.

---

## Milestones

Milestones are ordered by dependency. Work them in sequence — each builds on the previous.

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M8.1 | Data model changes | `completedAt` column added to cards table; `completeCard()` and `getCompletedCards()` wired through repo → provider | — | 🔲 |
| M8.2 | Card detail bottom sheet | Tap card → sheet with Start / What's next / Edit / Complete; Start opens timer | M8.1 | 🔲 |
| M8.3 | Edit card | Inline editing of goal + action labels from the detail sheet | M8.2 | 🔲 |
| M8.4 | Completion celebration | "Complete" in sheet → full-screen warm moment → card archived with `completedAt` | M8.1, M8.2 | 🔲 |
| M8.5 | Past Days: Completed section | Completed cards shown in Past Days, distinct from daily-rollover archives | M8.1, M8.4 | 🔲 |
| M8.6 | NextStepScreen | New screen: goal context + action input + AI button + Start → creates card and starts timer | M8.1 | 🔲 |
| M8.7 | Continuation prompt (post-timer) | After "Done" on timer → "Ready for the next tiny step?" → Yes goes to NextStepScreen | M8.6 | 🔲 |
| M8.8 | Dashboard nudge | "Continue →" chip on cards with recent goal activity; tap → NextStepScreen | M8.6 | 🔲 |
| M8.9 | Remove rest/archive prompt | Delete `_ArchivePromptSheet`, `_checkArchivePrompts()`, `getCardsNeedingArchivePrompt()`; keep swipe-to-defer | — | 🔲 |
| M8.10 | Analyze & test | `flutter analyze` clean; integration tests updated; manual testing checklist passes | All above | 🔲 |

---

## Suggested Implementation Order

The milestones have some parallelism, but the recommended sequence for a single implementer is:

1. **M8.1** — Data model (foundation for everything)
2. **M8.9** — Remove rest/archive prompt (quick cleanup, reduces code to navigate around)
3. **M8.2** — Card detail bottom sheet (changes the core deck interaction)
4. **M8.3** — Edit card (extends the sheet)
5. **M8.4** — Completion celebration (extends the sheet)
6. **M8.5** — Past Days completed section (shows completed cards)
7. **M8.6** — NextStepScreen (new screen, independent of sheet work)
8. **M8.7** — Continuation prompt (connects timer → NextStepScreen)
9. **M8.8** — Dashboard nudge (connects deck → NextStepScreen)
10. **M8.10** — Final cleanup, analyze, test

---

## Out of Scope

- Sub-task hierarchy or parent-child card relationships
- Analytics or stats view for completed cards
- Undo/restore for completed cards
- Timer duration picker
- Changes to onboarding, voice input, or Just One mode
- Backend, cloud sync, or user accounts

---

## Manual Testing Checklist

**Card Detail Bottom Sheet:**
- [ ] Tap card → bottom sheet appears with action label, goal label, duration
- [ ] "Start" button opens TimerScreen for that card
- [ ] Sheet dismisses correctly on swipe-down
- [ ] Cards without a goalLabel display correctly (no empty space)
- [ ] Sheet works for cards with long action/goal labels (no overflow)

**Edit Card:**
- [ ] "Edit" in sheet → labels become editable TextFields
- [ ] Pre-filled with current values
- [ ] "Save" updates the card and refreshes the deck
- [ ] Dismissing without saving discards changes
- [ ] Empty action label is rejected (validation)

**Completion Flow:**
- [ ] "Complete" in sheet → full-screen celebration appears
- [ ] Goal label shown large and centered
- [ ] Warm affirming copy displayed
- [ ] Check/completion animation plays smoothly
- [ ] "Back to deck" button fades in after ~1.5s delay
- [ ] Card no longer appears in active deck after completion
- [ ] Card appears in Past Days under "Completed" section

**Past Days — Completed Section:**
- [ ] Completed cards show goal, action, and completion date
- [ ] Completed section is visually distinct from date-grouped archives
- [ ] Empty completed section doesn't show (or shows gracefully)

**NextStepScreen:**
- [ ] Goal label displayed at top as context
- [ ] Text field accepts input for next action
- [ ] AI button visible and clearly labeled
- [ ] AI button checks consent before calling API
- [ ] AI suggestions appear as tappable chips
- [ ] "Make this smaller" appears after user types something
- [ ] "Start" creates a new card with same goalLabel and starts timer
- [ ] Back navigation works (no card created if user backs out)

**Continuation Prompt:**
- [ ] After timer "Done" → prompt appears: "Ready for the next tiny step?"
- [ ] "Yes, let's go" → navigates to NextStepScreen with correct goalLabel
- [ ] "Not now" → navigates to DeckScreen
- [ ] Prompt does NOT appear after "End session" (paused bail-out)
- [ ] Prompt does NOT appear for cards without a goalLabel
- [ ] Full cycle works: timer → prompt → NextStepScreen → new card → timer → prompt again

**Dashboard Nudge:**
- [ ] Cards with recent sessions on their goal show "Continue →" chip
- [ ] Only the most recent card per goal shows the nudge
- [ ] Cards without goalLabel never show the nudge
- [ ] Tapping "Continue →" opens NextStepScreen with correct goalLabel
- [ ] Nudge does not appear for goals with no sessions in last 7 days

**Rest/Archive Prompt Removal:**
- [ ] No "rest it" prompt ever appears after repeated deferrals
- [ ] Swipe-to-defer ("Later") still works and moves card to bottom
- [ ] Settings screen has no "rest" references

**Regression:**
- [ ] Just One mode works correctly (Start button in Just One still opens timer)
- [ ] Voice input flow unaffected (FAB → voice → suggestions → card creation)
- [ ] Fresh Start daily rollover still works
- [ ] Onboarding flow (first launch) unaffected
- [ ] "Keep going" on timer still works
- [ ] Notification permission request still works (first completion)
- [ ] Explainer sheet still shows (first completion)
- [ ] Cards persist across app restarts

---

## Definition of Done

- [ ] All milestones M8.1–M8.10 complete
- [ ] All manual testing checklist items pass on real device
- [ ] `flutter analyze` clean
- [ ] No regressions in existing functionality

---

## Dependencies

- Phase 7 complete ✅
- Database migration system at version 4 ✅
- `ai_service.dart` operational ✅
- `card_repository.dart` and `cards_provider.dart` functional ✅

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| | | |
