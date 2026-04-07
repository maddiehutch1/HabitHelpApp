# Roadmap — Phase 11: UI Polish & Voice Fix
*Created: April 7, 2026*
*Detailed plan: [Phase 11 Plan](2026-04-07-phase-11-ui-polish-voice-fix.md)*
*Previous: [Phase 10 — UX Fixes](complete/2026-04-06-roadmap-phase-10-ux-fixes.md)*
*Status: Complete*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Fix four usability issues from testing: shorten the transcription button text, add confetti to the goal-completion screen, fix voice-created task hierarchy so continuation flow works, and fix the card detail sheet bottom overflow.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M11.1 | Shorten transcription button | "Create cards from this" shortened to "Create cards"; no text wrapping | — | [x] |
| M11.2 | Completion screen confetti | CompletionScreen plays confetti + haptic on entry, matching CelebrationScreen | — | [x] |
| M11.3 | Voice task hierarchy | Voice-created cards have goalLabel (AI title) and actionLabel ("Get started"); continuation flow works | — | [x] |
| M11.4 | Card detail sheet overflow | Edit/Complete row fully visible on cards with goalLabel; no bottom overflow | — | [x] |
| M11.5 | Verify | `flutter analyze` clean; manual testing checklist passes | All above | [x] |

---

## Suggested Implementation Order

1. **M11.1 — Shorten button text** — One-line text change, instant win.
2. **M11.4 — Card detail sheet overflow** — Small spacing adjustment, single file.
3. **M11.2 — Completion screen confetti** — Adds confetti to an existing screen, follows existing pattern from CelebrationScreen.
4. **M11.3 — Voice task hierarchy** — Changes the card model field mapping in voice creation; slightly more impactful but isolated to one method.
5. **M11.5 — Verify** — Run analysis and manual tests after all changes.

---

## Out of Scope

- Redesigning the voice flow (multi-step breakdown)
- Adding a "define tiny step" screen for voice tasks
- AI prompt or task extraction logic changes
- Timer behavior changes
- Swipe-to-complete gestures
- Changes to CelebrationScreen itself

---

## Manual Testing Checklist

**Transcription Button (M11.1):**
- [ ] Record voice, stop recording, see transcription view
- [ ] Button text reads "Create cards" (not "Create cards from this")
- [ ] Button text does not wrap to a second line
- [ ] Tapping "Create cards" with transcription text proceeds to AI parsing or manual flow
- [ ] Tapping "Discard" closes the sheet (unchanged)

**Completion Screen Confetti (M11.2):**
- [ ] From deck, tap a card → tap "Complete" → CompletionScreen appears
- [ ] Confetti plays immediately on screen entry
- [ ] Haptic fires on entry
- [ ] Animated checkmark still scales in as before
- [ ] "Back to deck" button still works
- [ ] CelebrationScreen (after timer) still has its own confetti (unchanged)

**Voice Task Hierarchy (M11.3):**
- [ ] Record voice → AI extracts suggestions → tap "Add selected"
- [ ] New cards appear in deck with the AI title as the goal label (shown in smaller muted text below action)
- [ ] Card action label shows "Get started"
- [ ] Tap a voice-created card → detail sheet shows "What's next?" button
- [ ] Start a voice-created card timer → complete → overtime "Do next task" navigates to NextStepScreen
- [ ] Deck shows "Continue ->" nudge on voice-created cards after activity
- [ ] "Add manually instead" still works (unchanged)
- [ ] Editing a voice-created card shows both action and goal fields

**Card Detail Sheet (M11.4):**
- [ ] Tap a card with a goalLabel → detail sheet opens
- [ ] All content visible: title, goal, badge, Start, What's next, Edit, Complete
- [ ] No overflow warning in debug mode
- [ ] Edit and Complete buttons are fully visible and tappable
- [ ] Cards without goalLabel still display correctly (no extra spacing issues)

**Regression:**
- [ ] Deck card tap → detail sheet → Start → timer flow still works
- [ ] Timer countdown, haptic, overtime entry all work
- [ ] CelebrationScreen after normal timer completion still has confetti
- [ ] Card creation via "Write it down" (manual) still works
- [ ] Settings unaffected
- [ ] Past Days screen unaffected
- [ ] Fresh Start mode still works

---

## Definition of Done

- [ ] All milestones M11.1–M11.5 complete
- [ ] All manual testing checklist items pass
- [ ] `flutter analyze` clean
- [ ] No regressions in existing functionality

---

## Dependencies

- [x] Phase 10 complete
- [x] `confetti` package in pubspec
- [x] Card model supports `goalLabel`
- [x] Card detail sheet handles goalLabel presence

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Apr 7 | M11.1–M11.5 | All milestones complete; `flutter analyze` clean; also added restore-from-archive for completed cards |
