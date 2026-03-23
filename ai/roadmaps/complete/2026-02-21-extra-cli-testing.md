# Extra — CLI-Style Testing Infrastructure: Plan

*Date: February 21, 2026*
*Status: ✅ Complete*
*Roadmap: [2026-02-21-roadmap-extra-cli-testing.md](2026-02-21-roadmap-extra-cli-testing.md)*

> **Note:** Avoid over-engineering, cruft, and legacy-compatibility features in this clean code project.
> This work is not tied to a numbered phase — it is agentic testing infrastructure that supports all phases.

---

## Goal

Build CLI-executable test entrypoints so that an AI agent (or a developer) can exercise every core feature of Micro-Deck from the command line, read structured output, and close the test-log-fix loop without any manual UI interaction.

---

## Why

The project uses an AI-augmented development workflow. For that to work reliably, tests must be:

1. **Runnable from the command line** — no human clicking through UI
2. **Exit-code driven** — `0 = pass`, `1 = fail`, readable by agents
3. **Structured in their output** — logs that explain *why* something failed, not just *that* it did
4. **Layered** — fast unit tests for logic, widget tests for UI without a device, integration tests for the full app on an emulator

---

## Scope

### In scope
- Unit tests for all data models and repository logic (no emulator)
- Widget tests for all core screens (no emulator)
- Integration tests for the full onboarding → deck → timer → settings flow (emulator required)
- CLI runner scripts (`scripts/`) for Windows (PowerShell) and Mac/Linux (bash)
- Structured logging via Dart's `logging` package — named loggers per feature area, emitting `[LEVEL] LoggerName: message` to stdout
- `TEST_README.md` — AI agent guide at the repo root
- `aiDocs/cliTestPlan.md` — feature-to-test matrix, gap analysis, quickstart, state reset strategy, CI notes

### Out of scope
- Gap integration tests (F4 "Start now" path, F7 full add-card flow, F8 persistence) — tracked in `cliTestPlan.md` Section 4 for a future pass
- CI/CD pipeline setup (GitHub Actions)
- Performance profiling or load testing

---

## Entrypoints Built

### Scripts (no emulator)
```powershell
# Windows
.\scripts\analyze.ps1          # Static analysis + format check only (~5s)
.\scripts\test.ps1             # Unit + widget tests
.\scripts\build.ps1            # Release APK compile check
```
```bash
# Mac/Linux
bash scripts/analyze.sh
bash scripts/test.sh
bash scripts/build.sh
```

### Scripts (with emulator)
```powershell
.\scripts\test.ps1 -Integration    # Full suite including integration tests
```
```bash
bash scripts/test.sh --integration
```

### Direct Flutter commands
```bash
flutter test                            # All unit + widget tests
flutter test test/unit/                 # Unit tests only
flutter test test/widgets/              # Widget tests only
flutter test integration_test/app_test.dart   # Integration tests (emulator required)
flutter test --reporter=json            # Machine-readable JSON output
flutter analyze --fatal-infos           # Static analysis
dart format --set-exit-if-changed lib/ test/ integration_test/  # Format check
```

---

## Test Coverage

| Layer | Files | Tests | Emulator? |
|---|---|---|:---:|
| Unit — models | `test/unit/card_model_test.dart`, `schedule_model_test.dart`, `templates_test.dart` | 25 | No |
| Unit — repository | `test/unit/card_repository_test.dart` | 19 | No (in-memory SQLite via `sqflite_common_ffi`) |
| Widget — screens | `test/widgets/deck_screen_test.dart`, `onboarding_test.dart`, `timer_screen_test.dart` | 20 | No |
| Integration — flows | `integration_test/app_test.dart` | 5 | Yes |

---

## Structured Logging

`lib/services/app_logger.dart` defines four named loggers and a `setupLogging()` function called in `main.dart`. Output format:

```
[INFO] App: cold launch → hasCompletedOnboarding=false
[INFO] CardRepository: insertCard id=1740000000 action="Put on shoes"
[INFO] CardRepository: deferCard id=1740000000 → moved to sortOrder=2, deferral recorded
[WARNING] NotificationService: requestPermission: no platform implementation found
```

Log calls are present in:
- `lib/app.dart` — cold-launch onboarding flag
- `lib/data/repositories/card_repository.dart` — all CRUD operations
- `lib/services/notification_service.dart` — init, permissions, reschedule

---

## Key Files

| File | Purpose |
|---|---|
| `TEST_README.md` | Full AI agent guide — commands, test structure, JSON output, troubleshooting |
| `aiDocs/cliTestPlan.md` | Feature inventory, test matrix, gap analysis, state reset strategy |
| `lib/services/app_logger.dart` | Named loggers + `setupLogging()` |
| `scripts/test.ps1` / `test.sh` | Primary CLI runner |
| `integration_test/app_test.dart` | End-to-end integration tests |
| `test/unit/card_repository_test.dart` | Repository logic against in-memory SQLite |
