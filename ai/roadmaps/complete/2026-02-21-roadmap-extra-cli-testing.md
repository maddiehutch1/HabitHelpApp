# Extra — CLI-Style Testing Infrastructure: Roadmap

*Date: February 21, 2026*
*Status: ✅ Complete*
*Plan: [2026-02-21-extra-cli-testing.md](2026-02-21-extra-cli-testing.md)*

> **Note:** Avoid over-engineering, cruft, and legacy-compatibility features in this clean code project.

---

## Milestones

### M1 — Unit + Widget Test Suite ✅
Fast, no-emulator tests that an AI agent can run after every code change.

- [x] `sqflite_common_ffi` added as dev dependency for in-memory SQLite
- [x] `integration_test` (Flutter SDK) added as dev dependency
- [x] `test/unit/card_model_test.dart` — 8 tests (toMap/fromMap, durationLabel)
- [x] `test/unit/schedule_model_test.dart` — 9 tests (serialisation, hour/minute getters)
- [x] `test/unit/templates_test.dart` — 8 tests (count, areas, content integrity, uniqueness)
- [x] `test/unit/card_repository_test.dart` — 19 tests (full CRUD, archive, restore, defer, deferral counting, archive-prompt query) via in-memory SQLite
- [x] `test/widgets/onboarding_test.dart` — field validation and button enable logic
- [x] `test/widgets/deck_screen_test.dart` — empty state, card rendering, FAB, icons (via fake Riverpod provider)
- [x] `test/widgets/timer_screen_test.dart` — countdown format, action label, accessibility label
- [x] `lib/data/database.dart` — `setDatabasePathForTesting` / `resetDatabaseForTesting` helpers added (production path unchanged)

### M2 — Integration Tests ✅
Full app on a live emulator, zero human interaction.

- [x] `integration_test/app_test.dart` — 5 test groups:
  - [x] Full onboarding flow → deck (Welcome → Goal → Action → Confirm → Deck)
  - [x] FAB opens template browser sheet
  - [x] Swipe to defer (conditional on deck having cards)
  - [x] Settings screen opens from header icon
  - [x] Timer screen opens on card tap
- [x] State reset strategy implemented: `_clearState()` / `_setOnboardingComplete()` using `SharedPreferencesAsync` (real device storage, not mocks)

### M3 — CLI Runner Scripts ✅
Single commands that chain all checks with correct exit codes.

- [x] `scripts/test.ps1` — Windows PowerShell: analysis → format → unit/widget → optional `-Integration`
- [x] `scripts/test.sh` — bash: same, with `--integration` flag
- [x] `scripts/analyze.ps1` / `analyze.sh` — fast analysis-only pass
- [x] `scripts/build.ps1` / `build.sh` — release APK compile check

### M4 — Structured Logging ✅
Named loggers per feature area so CLI/agent output explains *why* things fail.

- [x] `logging: ^1.2.0` added to `dependencies`
- [x] `lib/services/app_logger.dart` — `appLog`, `cardRepoLog`, `scheduleRepoLog`, `notificationLog` + `setupLogging()` listener
- [x] `lib/main.dart` — `setupLogging()` called before `runApp()`
- [x] `lib/app.dart` — cold-launch onboarding flag logged
- [x] `lib/data/repositories/card_repository.dart` — all CRUD operations logged with card id and context
- [x] `lib/services/notification_service.dart` — init, permission request results, reschedule outcome logged

### M5 — Documentation ✅

- [x] `TEST_README.md` — AI agent guide: commands, test structure, in-memory DB setup, JSON output parsing, troubleshooting table
- [x] `aiDocs/cliTestPlan.md` — feature-to-test matrix (F1–F9), test matrix with commands, gap analysis (F4/F7/F8 not yet covered), quickstart, emulator setup, state reset strategy, CI notes
- [x] `aiDocs/changelog.md` updated with "Extra — CLI Test Harnesses" and "Extra — Structured Logging" entries
- [x] `aiDocs/context.md` updated to reference CLI testing infrastructure

---

## Progress Log

| Date | Event |
|---|---|
| Feb 21, 2026 | M1: All 64 unit + widget tests written and passing |
| Feb 21, 2026 | M2: Integration tests written; SharedPreferences bug found and fixed during first run (test-log-fix loop demonstrated) |
| Feb 21, 2026 | M3: All CLI scripts written and verified with `.\scripts\test.ps1 -Integration` on Android API 36 emulator |
| Feb 21, 2026 | M4: Structured logging added; `flutter analyze` clean; all tests still passing |
| Feb 21, 2026 | M5: TEST_README.md and cliTestPlan.md written; roadmap/plan docs created and archived |

---

## Known Gaps (Not in Scope Here)

See `aiDocs/cliTestPlan.md` Section 4 for proposed follow-up integration tests:

| Gap | File to create |
|---|---|
| F4 "Start now" → timer flow | `integration_test/timer_completion_test.dart` |
| F7 Full add-card flow (select template, save, verify in deck) | `integration_test/add_card_test.dart` |
| F8 Persistence (add card, restart app, verify card survives) | `integration_test/persistence_test.dart` |
