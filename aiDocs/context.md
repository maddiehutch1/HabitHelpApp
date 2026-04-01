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


# MicroDeck — Cursor AI Behavioral Guidelines

## What This Project Is
MicroDeck is a minimalist Flutter habit initiation app. Core philosophy: one card, two minutes, no judgment.
Built for people with ADHD, executive dysfunction, or digital burnout.

Always read `aiDocs/context.md` first to understand the current project state. For full product requirements see `aiDocs/prd.md`. For architecture decisions see `aiDocs/architecture.md`. For what has changed see `ai/changelog.md`.

---

## Hard Constraints — Never Violate Without Asking

- **No network requests** except OpenAI API calls via `lib/services/ai_service.dart` — and only when the user has granted consent (`aiSuggestionsEnabled` pref). No http, no dio, no firebase anywhere else.
- **No user accounts** — no auth, no login, no registration.
- **No analytics or crash reporting SDKs** that send data off-device.
- **No gamification** — no streaks, points, badges, or leaderboards. Ever.
- **No Riverpod codegen** — use `NotifierProvider` directly. Do not add `build_runner` or use `@riverpod` annotations.
- **Prefer `SharedPreferencesAsync`** over the legacy `SharedPreferences.getInstance()` for new code.
- **Store `DateTime` as `int`** (millisecondsSinceEpoch) in SQLite. Never as String or native DateTime.
- **Store `bool` as `int`** (0 or 1) in SQLite. Never as native bool.
- **WakelockPlus**: `enable()` in timer `initState`, `disable()` in `dispose`. Never globally.
- **Back gesture blocked during active timer** — use `PopScope(canPop: false)` while running. Allow pop only when paused or completed.
- **Timer pauses on background** — listen to `AppLifecycleState` in `TimerScreen`; call `_pause()` on `AppLifecycleState.paused`.

---

## Code Style

Refer to aiDocs/coding-style.md for coding style.

---

## Architecture

- **State management:** `flutter_riverpod` — `ConsumerWidget` for read-only, `ConsumerStatefulWidget` when local state is needed.
- **Local storage:** `sqflite` via `lib/data/database.dart` singleton. Migrations in `onUpgrade`.
- **Folder layout:**
  - `lib/screens/` — one subfolder per screen group
  - `lib/data/models/` — data models with `toMap`/`fromMap`
  - `lib/data/repositories/` — all DB access; never call sqflite from screens directly
  - `lib/services/` — `app_logger.dart`, `ai_service.dart`, `notification_service.dart`, `voice_service.dart`
  - `lib/providers/` — Riverpod providers and notifiers
- **AI calls:** always check `aiSuggestionsEnabled` pref and call `requestConsent()` before the first call. All AI logic lives in `lib/services/ai_service.dart`.

---

## Design Principles (decision filters from PRD)

1. Does this help the user **start** something? If no, cut it.
2. Does this add **cognitive load**? If yes, simplify or cut it.
3. Could this make a user feel **shame**? If yes, rewrite the copy or remove the mechanic.
4. Does this require a **network connection** beyond AI suggestions? If yes, find a local-only solution or cut it.
5. Does this make the **timer more reliable**? Prioritize above feature additions.

---

## Development Process

- New plan docs go in `ai/roadmaps/` with a date prefix (e.g. `2026-04-01-phase-8-foo.md`). Plans and roadmaps come in pairs. Both must reference each other.
- When a phase is complete: check off tasks in the roadmap, move both files to `ai/roadmaps/complete/`, update `ai/changelog.md`.
- Keep `aiDocs/context.md` current — update it whenever the project state changes.
- Keep documents as living artifacts. Stale docs are worse than no docs.