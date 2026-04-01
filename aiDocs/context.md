# Micro-Deck — Project Context
*Last updated: March 2026*

---

## What This Project Is

**Micro-Deck** is a minimalist mobile habit *initiation* tool — not a tracker, planner, or blocker. It helps users bridge the intention-behavior gap by reducing the friction of *starting* a habit. Built for people with ADHD, executive dysfunction, or digital burnout.

Core philosophy: **one card, two minutes, no judgment.**

---

## Key Documents

| Doc | Path | Purpose |
|---|---|---|
| PRD | `aiDocs/prd.md` | Full product requirements — features, data models, metrics, out-of-scope |
| MVP | `aiDocs/mvp.md` | Demo scope — core loop definition of done |
| Architecture | `aiDocs/architecture.md` | Tech stack, verified packages, data models, folder structure, hard constraints |
| Market Research | `ai/guides/habit-help-market-research.md` | Competitive landscape, risks, positioning |
| Changelog | `ai/changelog.md` | Changelog with brief notes about each change to the codebase |
| CLI Test Plan | `aiDocs/cliTestPlan.md` | Feature-to-test matrix, CLI commands, gap analysis, emulator setup, state reset strategy |

---

## Current App Screens

- **Welcome** — first launch only; [Let's begin] → card creation flow
- **CreateCardGoalScreen** — "What feels big and difficult right now?"
- **CreateCardActionScreen** — "What's one tiny step you could take first?"; AI suggestions ("I'm stuck", "Make this smaller")
- **CreateCardConfirmScreen** — "Ready for your tiny start?"; [Start now] / [Save for later]
- **Timer** — full-screen countdown, pulsing dot, haptic on completion; [Done] / [Keep going]
- **Deck View** — card list, tap to start timer; FAB opens voice/type sheet; Fresh Start mode support
- **VoiceAISuggestionsScreen** — AI-extracted tasks from voice recording; checkable, editable, multi-card queue
- **Settings** — Fresh Start toggle, AI Suggestions toggle, archived (resting) cards
- **Past Days** — cards archived by daily rollover, grouped by date, restorable

---

## Behavior

- Whenever creating plan docs and roadmap docs, always save them in ai/roadmaps. Prefix the name with the date. Add a note that we need to avoid over-engineering, cruft, and legacy-compatibility features in this clean code project. Make sure they reference each other.
- Whenever finishing with implementing a plan / roadmap doc pair, make sure the roadmap is up to date (tasks checked off, etc). Then save the docs to ai/roadmaps/complete. Then update ai/changelog.md accordingly.

---

## Current Focus

Phases 0–7 are complete. Phase roadmaps are archived in `ai/roadmaps/complete/`. The high-level project plan (`ai/roadmaps/2026-02-19-high-level-project-plan.md`) stays at the roadmaps root as a persistent reference.

**CLI Testing Infrastructure** is complete. Run `.\\scripts\\test.ps1` (Windows) or `bash scripts/test.sh` (Mac/Linux). See `TEST_README.md` and `ai/roadmaps/complete/2026-02-21-extra-cli-testing.md`.

---

## What's Explicitly Out of Scope

- Multiple independent goals (goal is stored as a label on each card, not a separate entity)
- Habit history / analytics views shown to the user
- Apple Watch, widgets, Siri integration
- Cloud sync, backend, user accounts, social features
- App Store / Play Store submission (deferred)
