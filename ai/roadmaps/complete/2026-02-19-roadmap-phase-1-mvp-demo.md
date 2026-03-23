# Roadmap — Phase 1: MVP Demo
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Detailed plan: [Phase 1 Plan](2026-02-19-phase-1-mvp-demo.md)*
*Previous: [Roadmap — Phase 0](2026-02-19-roadmap-phase-0-foundation.md)*
*Next: [Roadmap — Phase 2](2026-02-19-roadmap-phase-2-polish.md)*
*Status: Complete — Feb 21, 2026*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Polish means fixing what's rough, not adding new features. Every item here should make the existing demo loop feel better — not extend its scope.

---

## Phase Goal
A working Flutter app that demonstrates the full demo loop end-to-end on a real device.

**Demo loop:** Welcome → Goal → Action → Confirm → Timer → Haptic → Deck

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M1.1 | Data layer | `CardModel`, database, repository, and Riverpod provider all working | M0.5 | ✅ Complete — Feb 21, 2026 |
| M1.2 | App shell & routing | `main.dart` + `app.dart` wired, launch routing based on onboarding flag | M1.1 | ✅ Complete — Feb 21, 2026 |
| M1.3 | Welcome screen | First-launch screen renders, [Let's begin] navigates forward | M1.2 | ✅ Complete — Feb 21, 2026 |
| M1.4 | Onboarding screens | 1A (goal) → 1B (action) → Confirm — all three screens connected, card created on confirm | M1.3 | ✅ Complete — Feb 21, 2026 |
| M1.5 | Timer screen | Full-screen countdown, wakelock active, haptic fires at zero, completion word shown | M1.4 | ✅ Complete — Feb 21, 2026 |
| M1.6 | Deck screen | Card list renders, tap opens timer, [+] adds a card, cards persist on restart | M1.5 | ✅ Complete — Feb 21, 2026 |
| M1.7 | Demo ready | Full loop works cold-to-haptic in under 90s on real device, loop is repeatable | M1.6 | ✅ Complete — confirmed Feb 21, 2026 |

---

## 6-Screen Summary

| Screen | File | Navigates To |
|---|---|---|
| Welcome | `screens/welcome/welcome_screen.dart` | Onboarding 1A |
| Onboarding 1A (Goal) | `screens/onboarding/onboarding_goal_screen.dart` | Onboarding 1B |
| Onboarding 1B (Action) | `screens/onboarding/onboarding_action_screen.dart` | Onboarding Confirm |
| Onboarding Confirm | `screens/onboarding/onboarding_confirm_screen.dart` | Timer or Deck |
| Timer | `screens/timer/timer_screen.dart` | Deck |
| Deck | `screens/deck/deck_screen.dart` | Timer (on card tap) |

---

## Definition of Done
- Cold launch to haptic completion in under 90 seconds on a real device
- Loop is repeatable (tap a deck card again → timer runs again)
- Cards persist across app restarts
- "Save for later" path works
- Adding a card from the deck works
- No crashes on any demo step

---

## Dependencies
- Phase 0 complete (M0.5 minimum — emulator running)

## Blocks
- Phase 2 cannot start until M1.7 is complete

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Feb 21, 2026 | M1.1–M1.6 | All screens and data layer built; `flutter analyze` returns no issues. |
| Feb 21, 2026 | M1.7 | Full demo loop confirmed on Android emulator. App clean. |
