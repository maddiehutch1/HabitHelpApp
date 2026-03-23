# Roadmap — Phase 2: Polish & Stability
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Detailed plan: [Phase 2 Plan](2026-02-19-phase-2-polish.md)*
*Previous: [Roadmap — Phase 1](2026-02-19-roadmap-phase-1-mvp-demo.md)*
*Next: [Roadmap — Phase 3](2026-02-19-roadmap-phase-3-v1-features.md)*
*Status: Complete — Feb 21, 2026*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal
The Phase 1 demo loop feels like a real product — dark, calm, fast, and trustworthy. No rough edges visible in a demo or user test.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M2.1 | Theme locked | All colors, typography, spacing from `ThemeData` constants — no hardcoded values | M1.7 | ✅ Complete — Feb 21, 2026 |
| M2.2 | Timer animations | Pulsing dot (slow sine-wave) + completion fade working correctly | M2.1 | ✅ Complete — Feb 21, 2026 |
| M2.3 | Screen transitions | Onboarding slides, timer fades, deck pop — all transitions intentional | M2.1 | ✅ Complete — Feb 21, 2026 |
| M2.4 | Edge cases handled | Empty deck, keyboard, back nav, rapid taps, app backgrounded — all behave correctly | M2.1 | ✅ Complete — Feb 21, 2026 |
| M2.5 | Error handling | DB failures and prefs failures handled gracefully — no silent crashes | M2.4 | ✅ Complete — Feb 21, 2026 |
| M2.6 | Accessibility pass | Tap targets ≥44pt, contrast ≥4.5:1, semantic labels on interactive elements | M2.1 | ✅ Complete — Feb 21, 2026 |
| M2.7 | Performance targets met | Cold launch <1.5s, card tap to timer <200ms — verified with `--profile` | M2.1 | ✅ Complete — confirmed Feb 21, 2026 |
| M2.8 | Device tested | Full loop verified on Android + iOS real device, haptic type finalized | M2.2–M2.7 | ✅ Complete — confirmed Feb 21, 2026 |

---

## Performance Targets (Reference)

| Metric | Target |
|---|---|
| Cold launch to deck visible | < 1.5 seconds |
| Card tap to timer screen | < 200ms |
| Timer accuracy | ± 1 second over 10 min |
| Haptic delay at 0:00 | < 100ms |

---

## Definition of Done
- Full demo loop runs on real iOS and Android devices without visible rough edges
- Theme is consistent throughout — no defaults, no hardcoded colors
- Pulsing dot animates and stops on pause
- All listed edge cases handled
- Cold launch under 1.5s on mid-range device
- Haptic type finalized and locked in

---

## Dependencies
- Phase 1 complete (M1.7 — demo ready)

## Blocks
- Phase 3 cannot start until M2.8 is complete

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Feb 21, 2026 | M2.1–M2.6 | Theme, animations, transitions, edge cases, error handling, accessibility — all code complete. `flutter analyze` clean. |
| Feb 21, 2026 | M2.7–M2.8 | Performance and device testing confirmed. App looks great. Phase 2 complete. |
