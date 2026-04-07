# Roadmap — Phase 9: Card Detail Sheet Cleanup & AI Button Polish
*Created: April 6, 2026*
*Detailed plan: [Phase 9 Plan](2026-04-06-phase-9-sheet-and-ai-polish.md)*
*Previous: [Phase 8 — Momentum & Dashboard Redesign](2026-04-06-roadmap-phase-8-momentum-dashboard.md)*
*Status: ✅ Complete*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Reduce visual clutter in the card detail bottom sheet and make AI buttons recognizable at a glance across the app.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M9.1 | Add AI accent color | `AppColors.aiAccent` defined in `lib/theme.dart` | — | ✅ |
| M9.2 | Redesign card detail sheet | Start + What's next stacked; Edit + Complete in compact icon row | — | ✅ |
| M9.3 | Polish AI buttons | All 4 AI buttons show sparkle icon + accent color | M9.1 | ✅ |
| M9.4 | Verify | `flutter analyze` clean; visual check on device | All above | ✅ |

---

## Manual Testing Checklist

**Card Detail Sheet:**
- [ ] Tap card → sheet appears with clear hierarchy: Start prominent, Edit/Complete compact
- [ ] Start button still opens timer
- [ ] What's next? still navigates to NextStepScreen (only for cards with goals)
- [ ] Edit still opens inline editing
- [ ] Complete still triggers completion celebration
- [ ] Sheet looks clean for cards with and without goalLabel
- [ ] No overflow for long labels

**AI Buttons:**
- [ ] "I'm stuck – show ideas" on CreateCardActionScreen shows sparkle icon and accent color
- [ ] "Make this smaller" on CreateCardActionScreen shows sparkle icon and accent color
- [ ] "Help me think of one" on NextStepScreen shows sparkle icon and accent color
- [ ] "Make this smaller" on NextStepScreen shows sparkle icon and accent color
- [ ] Accent color is visually distinct from regular muted buttons but not jarring
- [ ] Sparkle icon renders cleanly at chosen size

**Regression:**
- [ ] Timer flow unaffected
- [ ] Deck interactions still work (tap, swipe-to-defer, Just One mode)
- [ ] Voice input flow unaffected
- [ ] Onboarding flow unaffected

---

## Definition of Done

- [ ] All milestones M9.1–M9.4 complete
- [ ] `flutter analyze` clean
- [ ] Manual testing checklist passes
