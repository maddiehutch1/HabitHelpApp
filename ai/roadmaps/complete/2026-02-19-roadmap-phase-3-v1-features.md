# Roadmap — Phase 3: v1 Feature Build
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Detailed plan: [Phase 3 Plan](2026-02-19-phase-3-v1-features.md)*
*Previous: [Roadmap — Phase 2](2026-02-19-roadmap-phase-2-polish.md)*
*Next: [Roadmap — Phase 4](2026-02-19-roadmap-phase-4-app-store.md)*
*Status: ✅ Complete — all code complete Feb 21, 2026; tested and confirmed Feb 23, 2026. M3.7 + M3.8 platform setup (App Store Connect / Play Console / notification icon) required before submission.*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal
Ship a complete v1 product. All PRD features implemented, tested, and stable. No features from the PRD out-of-scope list included.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M3.1 | Adjustable timer | Duration slider on card creation, badge reflects actual duration | M2.8 | ✅ Complete — Feb 21, 2026 |
| M3.2 | Goal field | Optional on deck add, pre-fills from last card, shows on card tile | M3.1 | ✅ Complete — Feb 21, 2026 |
| M3.3 | Swipe-to-defer | Swipe left moves card to bottom, deferral count tracked | M3.2 | ✅ Complete — Feb 21, 2026 |
| M3.4 | "Just One" mode | Overlay showing only top card, [Start] and [Not today] options | M3.3 | ✅ Complete — Feb 21, 2026 |
| M3.5 | Card archiving | Gentle prompt after 3 deferrals/week, Dormant Deck view, restore | M3.3 | ✅ Complete — Feb 21, 2026 |
| M3.6 | Starter templates | Static template list, browsable sheet, pre-fills add card form | M3.5 | ✅ Complete — Feb 21, 2026 |
| M3.7 | Freemium gating | 5-card free limit, paywall after first completion, Pro IAP unlock | M3.6 | ✅ Code complete — ⚠️ needs App Store Connect + Play Console product setup |
| M3.8 | Notifications | Queue architecture, per-card scheduling UI, iOS 64-limit workaround | M3.7 | ✅ Code complete — ⚠️ needs notification icon drawable + platform test |
| M3.9 | Post-completion explainer | One-time skippable explainer after first card completion | M3.8 | ✅ Complete — Feb 21, 2026 |
| M3.10 | Settings screen | Card management, archived cards view, permanent delete | M3.9 | ✅ Complete — Feb 21, 2026 |

---

## Schema Migration Plan

| DB Version | Change | Triggered By |
|---|---|---|
| v1 (MVP) | `cards` table baseline | Phase 1 |
| v2 | `isArchived` on cards + `deferrals` table | M3.3 + M3.5 |
| v3 | `schedules` table | M3.8 |

---

## Features vs PRD Out-of-Scope (Sanity Check)

These must NOT be included in Phase 3:

- ❌ Apple Watch companion
- ❌ iCloud backup / cloud sync
- ❌ Social features / sharing
- ❌ LLM / AI suggestions
- ❌ Android-specific optimizations (same codebase ships, no extra work)
- ❌ Widget support
- ❌ Siri / Shortcuts integration

---

## Definition of Done
- All 10 features implemented and working on iOS and Android
- Schema migrations run cleanly on a database started at v1
- Notifications queue correctly and degrade gracefully when denied
- Freemium gate enforces 5-card limit; Pro unlocks everything
- No PRD out-of-scope features included

---

## Dependencies
- Phase 2 complete (M2.8 — device tested)

## Blocks
- Phase 4 cannot start until M3.10 is complete

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Feb 21, 2026 | M3.1–M3.10 | All 10 features code complete. `flutter analyze` clean. M3.7 (IAP) and M3.8 (notifications) need platform setup before device test. |
| Feb 23, 2026 | Phase 3 closed | App tested and confirmed working on device. Phase 3 archived to /complete. |
