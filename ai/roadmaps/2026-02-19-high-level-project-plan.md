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

## Phase 5 — Daily Refresh ✅ Complete
**Goal:** Add an optional daily refresh mode that helps users who want daily structure and guided task breakdown, while preserving the existing persistent deck as the default experience.

- [x] Daily refresh mode with Fresh Start toggle
- [x] Guided task breakdown for daily planning
- [x] Persistent deck remains the default

---

## Phase 6 — Unified "Tiny Start" Flow ✅ Complete
**Goal:** Replace fragmented card creation flows with a single, momentum-building "Tiny Start" experience. Add AI-powered suggestions to help users when stuck.

- [x] Onboarding screens reusable for all card creation
- [x] AI-powered "I'm stuck" and "Make this smaller" suggestions
- [x] Unified flow for onboarding and ongoing card creation

---

## Phase 7 — Voice & AI Suggestions ✅ Complete
**Goal:** After a user records a voice dump, intercept the transcription and pass it to the AI service. Show up to 3 suggested micro-tasks extracted from their words, let them pick and edit before adding to their deck.

- [x] Voice recording and transcription
- [x] AI-extracted task suggestions from voice input
- [x] Selectable and editable suggestion list

---

## Extra — CLI Testing ✅ Complete
**Goal:** Build CLI-executable test entrypoints so an AI agent or developer can exercise every core feature from the command line without manual UI interaction.

- [x] CLI test entrypoints for core features
- [x] Structured output for test-log-fix loop
- [x] Test scripts for Mac/Linux and Windows

---

## Phase 8 — Momentum & Dashboard ✅ Complete
**Goal:** Redesign deck view with momentum-building features and a dashboard-style layout.

- [x] Dashboard redesign
- [x] Momentum features (continue nudge, recent goal tracking)
- [x] Card detail bottom sheet

---

## Phase 9 — Sheet & AI Polish ✅ Complete
**Goal:** Reduce visual clutter in the card detail bottom sheet and make AI buttons recognizable at a glance.

- [x] Card detail sheet hierarchy (Start prominent, Edit/Complete compact)
- [x] AI accent color and sparkle icon on all AI buttons

---

## Phase 10 — UX Fixes ✅ Complete
**Goal:** Fix three usability issues from user testing: enlarge Continue nudge, skip celebration after overtime, batch-save voice suggestions.

- [x] Continue nudge tap target >= 44px, full-width tappable
- [x] Overtime "Do next task" skips celebration, goes to NextStepScreen directly
- [x] Voice "Add selected" batch-saves all checked items as cards without step-by-step flow

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
| Phase 5 — Daily Refresh ✅ | [phase-5-daily-refresh](complete/2026-03-28-phase-5-daily-refresh.md) | [roadmap-phase-5](complete/2026-03-28-roadmap-phase-5-daily-refresh.md) |
| Phase 6 — Unified Tiny Start ✅ | [phase-6-tiny-start](complete/2026-03-28-phase-6-tiny-start-unified.md) | [roadmap-phase-6](complete/2026-03-28-roadmap-phase-6-tiny-start-unified.md) |
| Phase 7 — Voice & AI Suggestions ✅ | [phase-7-voice-ai](complete/2026-03-31-phase-7-voice-ai-suggestions.md) | [roadmap-phase-7](complete/2026-03-31-roadmap-phase-7-voice-ai-suggestions.md) |
| Extra — CLI Testing ✅ | [extra-cli-testing](complete/2026-02-21-extra-cli-testing.md) | [roadmap-extra-cli](complete/2026-02-21-roadmap-extra-cli-testing.md) |
| Phase 8 — Momentum & Dashboard ✅ | [phase-8-momentum-dashboard](complete/2026-04-06-phase-8-momentum-dashboard.md) | [roadmap-phase-8](complete/2026-04-06-roadmap-phase-8-momentum-dashboard.md) |
| Phase 9 — Sheet & AI Polish ✅ | [phase-9-sheet-ai-polish](complete/2026-04-06-phase-9-sheet-and-ai-polish.md) | [roadmap-phase-9](complete/2026-04-06-roadmap-phase-9-sheet-and-ai-polish.md) |
| Phase 10 — UX Fixes ✅ | [phase-10-ux-fixes](complete/2026-04-06-phase-10-ux-fixes.md) | [roadmap-phase-10](complete/2026-04-06-roadmap-phase-10-ux-fixes.md) |
