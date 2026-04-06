# Micro-Deck — Project Plan
*Created: February 19, 2026*
*Status: Active*

---

## Engineering Philosophy

**Avoid over-engineering, cruft, and legacy-compatibility features.**

This is a clean-start project with no existing users, no existing data, and no migration debt. Every layer of abstraction must earn its place. If a simpler approach works, use it. Delete code freely. Build for what's needed now, not for hypothetical future requirements.

Specific things to resist:
- Abstractions created before they're needed twice
- Generic base classes, factories, or registries "just in case"
- Over-layered architecture (repository → service → use case → provider) for simple CRUD
- Compatibility shims for old Flutter/Dart patterns
- Dead code, commented-out blocks, or "we might need this later" stubs

---

## Phase 0 — Foundation ✅ Complete
**Goal:** Project is set up and ready to write Flutter code.

- [x] Product defined (PRD, MVP, market research)
- [x] Architecture decisions documented (packages verified, data models drafted)
- [x] Project folder structure established (`aiDocs/`, `ai/`, `.gitignore`)
- [x] Flutter installed and verified on dev machine
- [x] Flutter project scaffolded inside repo
- [x] Dependencies added (`sqflite`, `shared_preferences`, `wakelock_plus`, `flutter_riverpod`, `path`)
- [x] App runs on Android emulator (cold start, no crashes)
- [x] Codemagic pipeline set up for iOS builds — deferred to Phase 4

---

## Phase 1 — MVP Demo ✅ Complete
**Goal:** A working demo that proves the core loop feels right on a real device.

The full demo loop: Welcome → Goal → Action → Confirm → Timer → Haptic → Deck

**Screens to build (in order):**
1. Welcome screen — first launch only
2. Onboarding: Goal screen (1A)
3. Onboarding: Action screen (1B)
4. Onboarding: Confirm screen
5. Timer screen — full-screen countdown, wakelock, haptic on completion
6. Deck screen — card list, tap-to-start, add card

**Infrastructure to build alongside screens:**
- sqflite database init and card CRUD
- shared_preferences onboarding flag
- Riverpod card provider
- Navigator routing (including launch routing based on onboarding flag)

**Definition of done:** User completes full loop cold-to-haptic in under 90 seconds on a real device without crashes. Loop is repeatable. Cards persist across restarts.

---

## Phase 2 — Polish & Stability ✅ Complete
**Goal:** The demo feels like a real product, not a prototype.

- Theming — dark palette, typography, spacing system locked in
- Animations — pulsing dot on timer, screen transitions (subtle, not flashy)
- Edge cases — empty deck state, keyboard handling, back navigation behavior
- Error handling — database failures, unexpected states
- Accessibility — minimum contrast ratios, tap target sizes
- Performance — cold launch under 1.5s, card tap to timer under 200ms
- Real device testing — iOS and Android

---

## Phase 3 — v1 Feature Build ✅ Complete
**Goal:** Ship a complete v1 product beyond the demo scope.

Features to add (from PRD, in rough priority order):
1. Adjustable timer duration per card (1–10 min slider)
2. Goal field on cards — optional on add, required in onboarding
3. Swipe-to-defer (move card to bottom of deck)
4. "Just One" mode — show only top card
5. Card archiving — gentle prompt after repeated deferrals, Dormant Deck
6. Starter card templates library
7. Freemium gating — free tier (1 goal, 5 cards), Pro unlock
8. Scheduled notifications — per-card day/time, queue architecture (iOS 64-limit workaround)
9. Onboarding explainer — post-first-completion, skippable
10. Settings screen — minimal, card management only

---

## Phase 4 — Future Planning (Deferred)
**Goal:** Evaluate what to build next based on real usage and feedback.

All items are hypotheses — nothing gets built without evidence from real users:
- Monetization / Pro tier (freemium + one-time IAP)
- App Store submission (iOS and/or Android)
- Apple Watch companion
- Home screen widget
- Siri / Shortcuts integration
- LLM-assisted habit suggestion (opt-in, cloud API)
- iCloud backup (optional, user-initiated)

Nothing in Phase 4 gets built without evidence from real user behavior.

---

## Phase Plan & Roadmap Docs

Each phase has a detailed plan (implementation steps) and a roadmap (milestone tracking):

| Phase | Plan | Roadmap |
|---|---|---|
| Phase 0 — Foundation ✅ | [phase-0-foundation](complete/2026-02-19-phase-0-foundation.md) | [roadmap-phase-0](complete/2026-02-19-roadmap-phase-0-foundation.md) |
| Phase 1 — MVP Demo ✅ | [phase-1-mvp-demo](complete/2026-02-19-phase-1-mvp-demo.md) | [roadmap-phase-1](complete/2026-02-19-roadmap-phase-1-mvp-demo.md) |
| Phase 2 — Polish & Stability ✅ | [phase-2-polish](complete/2026-02-19-phase-2-polish.md) | [roadmap-phase-2](complete/2026-02-19-roadmap-phase-2-polish.md) |
| Phase 3 — v1 Feature Build ✅ | [phase-3-v1-features](complete/2026-02-19-phase-3-v1-features.md) | [roadmap-phase-3](complete/2026-02-19-roadmap-phase-3-v1-features.md) |
| Phase 4 — Future Planning | [phase-4-future-planning](2026-02-19-phase-4-future-planning.md) | [roadmap-phase-4](2026-02-19-roadmap-phase-4-future-planning.md) |
| Phase 8 — Momentum & Dashboard ✅ | [phase-8-momentum-dashboard](complete/2026-04-06-phase-8-momentum-dashboard.md) | [roadmap-phase-8](complete/2026-04-06-roadmap-phase-8-momentum-dashboard.md) |
