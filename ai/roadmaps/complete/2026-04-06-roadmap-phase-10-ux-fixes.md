# Roadmap — Phase 10: UX Fixes
*Created: April 6, 2026*
*Detailed plan: [Phase 10 Plan](2026-04-06-phase-10-ux-fixes.md)*
*Previous: [Phase 9 — Sheet & AI Polish](complete/2026-04-06-roadmap-phase-9-sheet-and-ai-polish.md)*
*Status: ✅ Complete*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Fix three usability issues from user testing: enlarge the Continue nudge tap target on deck cards, skip celebration when finishing overtime, and batch-save voice suggestions instead of stepping through card creation one-by-one.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M10.1 | Enlarge Continue nudge | "Continue ->" on deck cards has >= 44px tap target and spans full tile width | — | ✅ |
| M10.2 | Skip celebration after overtime | "Do next task" in overtime goes to NextStepScreen (or DeckScreen) without confetti | — | ✅ |
| M10.3 | Batch save voice suggestions | "Add selected" creates all checked items as cards at once, returns to deck | — | ✅ |
| M10.4 | Verify | `flutter analyze` clean; manual testing checklist passes | All above | ✅ |

---

## Suggested Implementation Order

1. **M10.1 — Continue nudge** — Smallest change, single file, quick win.
2. **M10.2 — Overtime flow** — Isolated to timer_screen.dart, straightforward navigation change.
3. **M10.3 — Voice batch save** — Slightly more involved since it replaces the step-by-step flow with direct card creation.
4. **M10.4 — Verify** — Run analysis and manual tests after all changes.

---

## Out of Scope

- Swipe-to-complete gesture on deck cards
- Changes to the normal (non-overtime) celebration flow
- Timer behavior changes beyond overtime
- Redesigning VoiceAISuggestionsScreen layout
- New AI features or prompt changes

---

## Manual Testing Checklist

**Continue Nudge (M10.1):**
- [ ] Cards with recent goal activity show "Continue ->" nudge
- [ ] Nudge is visually larger than before (not tiny 12px text)
- [ ] Tapping anywhere on the nudge row triggers navigation to NextStepScreen
- [ ] Tap target feels comfortable (not fiddly)
- [ ] Cards without goal activity do not show the nudge

**Overtime Flow (M10.2):**
- [ ] Start a timer, let it count down to 0, enter overtime
- [ ] Tap "Do next task" — no confetti, no "I did it" celebration
- [ ] If card has a goal, navigates to NextStepScreen
- [ ] If card has no goal, navigates to DeckScreen
- [ ] Tap "I'm finished" — goes to DeckScreen (unchanged)
- [ ] Normal timer completion (before overtime) still shows celebration with confetti

**Voice Batch Save (M10.3):**
- [ ] Record voice → AI suggestions appear as checklist
- [ ] Can check/uncheck and edit items inline (unchanged behavior)
- [ ] Tap "Add selected" → all checked items saved as cards immediately
- [ ] After save, navigates to DeckScreen
- [ ] New cards appear in the deck
- [ ] "Add manually instead" still navigates to CreateCardGoalScreen

**Regression:**
- [ ] Deck card tap → detail sheet → Start still works
- [ ] Card detail sheet "What's next?" still works
- [ ] Timer countdown, haptic, overtime entry all work
- [ ] CelebrationScreen still works for normal (non-overtime) completions
- [ ] Onboarding flow unaffected
- [ ] Settings unaffected

---

## Definition of Done

- [ ] All milestones M10.1-M10.4 complete
- [ ] All manual testing checklist items pass
- [ ] `flutter analyze` clean
- [ ] No regressions in existing functionality

---

## Dependencies

- [x] Phase 9 complete
- [x] Card repository insert support exists
- [x] Riverpod card provider for invalidation exists

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Apr 6 | M10.1–M10.4 | All milestones complete; `flutter analyze` clean |
