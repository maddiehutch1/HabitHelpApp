This is meant to be a CONCISE list of changes to track as we develop this project. When adding to this file, keep comments short and summarized. Always add references back to the source plan docs for each set of changes. 

---

## Extra — Structured Logging
*Feb 21, 2026 · Not connected to a roadmap phase — agentic testing infrastructure*

- Added `logging: ^1.2.0` to `dependencies`
- Created `lib/services/app_logger.dart` — named loggers (`App`, `CardRepository`, `ScheduleRepository`, `NotificationService`) with a `setupLogging()` listener that prints `[LEVEL] LoggerName: message` to stdout for CLI/agent readability
- `lib/main.dart` calls `setupLogging()` before `runApp()`
- `lib/app.dart` logs cold-launch onboarding state (`hasCompletedOnboarding`) and any prefs read failure
- `lib/data/repositories/card_repository.dart` logs every CRUD operation: `insertCard`, `deleteCard`, `archiveCard`, `restoreCard`, `deferCard`, and `getCardsNeedingArchivePrompt` candidate detection
- `lib/services/notification_service.dart` logs init, permission request results, and `rescheduleAll` outcome
- All 64 unit + widget tests pass after changes; `flutter analyze` clean

---

## Extra — CLI Test Harnesses
*Feb 21, 2026 · Not connected to a roadmap phase — agentic testing infrastructure*

- Added `sqflite_common_ffi` dev dependency for in-memory SQLite in unit tests
- Added `integration_test` (Flutter SDK) dev dependency
- Added test reset helpers to `lib/data/database.dart` (`setDatabasePathForTesting`, `resetDatabaseForTesting`) — production code unaffected
- Created `test/unit/card_model_test.dart` — 8 tests covering serialisation, round-trip, and `durationLabel`
- Created `test/unit/schedule_model_test.dart` — 9 tests covering serialisation, round-trip, and time getters
- Created `test/unit/templates_test.dart` — 8 tests covering template count, content integrity, and area categorisation
- Created `test/unit/card_repository_test.dart` — 19 tests covering full CRUD, archive/restore, defer, deferral counting, and archive-prompt logic via in-memory SQLite
- Created `test/widgets/onboarding_test.dart` — field validation and button enable logic for Goal and Action screens
- Created `test/widgets/deck_screen_test.dart` — empty state, card rendering, FAB, and header icons via fake Riverpod provider
- Created `test/widgets/timer_screen_test.dart` — countdown format, action label, and accessibility label
- Created `integration_test/app_test.dart` — full onboarding → deck → FAB → settings → timer flows (requires running emulator)
- Created `scripts/test.sh` and `scripts/test.ps1` — full test runner (unit + widget; optional `--integration` / `-Integration` flag)
- Created `scripts/analyze.sh` and `scripts/analyze.ps1` — fast analysis-only check (no tests)
- Created `scripts/build.sh` and `scripts/build.ps1` — release APK compile check
- Created `TEST_README.md` — full AI agent guide covering commands, test structure, in-memory DB setup, and JSON output parsing

---

## Phase 0 — Foundation
*Feb 20, 2026 · Plan: [ai/roadmaps/complete/2026-02-19-phase-0-foundation.md](roadmaps/complete/2026-02-19-phase-0-foundation.md)*

- Flutter 3.41.2 (stable) verified; `flutter doctor` clean on Flutter/Chrome/network
- `flutter create --org com.microdeck --platforms ios,android --project-name micro_deck .` — project scaffolded at repo root
- Boilerplate counter app removed; `lib/main.dart` replaced with minimal `ProviderScope` + `runApp` entry point
- `lib/app.dart` created — bare `MaterialApp` shell, no routes yet
- 5 MVP packages added: `shared_preferences 2.5.4`, `sqflite 2.4.2`, `path 1.9.1`, `wakelock_plus 1.4.0`, `flutter_riverpod 3.2.1`
- `lib/` folder structure scaffolded per architecture doc (`data/`, `providers/`, `screens/` subtree); empty dirs tracked with `.gitkeep`
- `.gitignore` updated to include `.metadata`
- `flutter analyze` returns no issues
- **Feb 21, 2026:** `flutter run` confirmed working on Android emulator — blank app launches without crashes (M0.5 complete)
- **Deferred to Phase 4:** Codemagic iOS pipeline setup (M0.6)

## Phase 1 — MVP Demo (code complete)
*Feb 21, 2026 · Plan: [ai/roadmaps/complete/2026-02-19-phase-1-mvp-demo.md](roadmaps/complete/2026-02-19-phase-1-mvp-demo.md)*

- `lib/data/models/card_model.dart` — `CardModel` with `toMap`/`fromMap`; timestamps as int
- `lib/data/database.dart` — sqflite singleton; `microdeck.db`; v1 `cards` table
- `lib/data/repositories/card_repository.dart` — `insertCard`, `getAllCards`, `deleteCard`
- `lib/providers/cards_provider.dart` — `CardsNotifier` + `cardsProvider` (Riverpod `NotifierProvider`, no codegen)
- `lib/app.dart` — reads `hasCompletedOnboarding` via `SharedPreferencesAsync`; routes to `WelcomeScreen` or `DeckScreen`; dark `ThemeData` applied
- `lib/screens/welcome/welcome_screen.dart` — first-launch screen; [Let's begin →] → Goal screen
- `lib/screens/onboarding/onboarding_goal_screen.dart` — goal input; [Next →] disabled until text entered
- `lib/screens/onboarding/onboarding_action_screen.dart` — action input; goal shown as muted context; [Let's go →] disabled until text entered
- `lib/screens/onboarding/onboarding_confirm_screen.dart` — confirms action; [Start now] → Timer; [Save for later] → Deck; sets `hasCompletedOnboarding = true`
- `lib/screens/timer/timer_screen.dart` — countdown `MM:SS`; pulsing dot; wakelock; `AppLifecycleState` pause; `PopScope` back-block while running; haptic + "That's it." on completion
- `lib/screens/deck/deck_screen.dart` — card list; tap → Timer; [+] FAB → add-card bottom sheet; empty state; persists on restart
- `flutter analyze` — no issues
- **Feb 21, 2026:** M1.7 — full demo loop confirmed on Android emulator. Phase 1 complete.

## Phase 2 — Polish & Stability (code complete)
*Feb 21, 2026 · Plan: [ai/roadmaps/complete/2026-02-19-phase-2-polish.md](roadmaps/complete/2026-02-19-phase-2-polish.md)*

- `lib/theme.dart` (new) — `AppColors`, `AppSpacing`, `AppTextStyles`, `AppTheme`; warm near-black `#0F0E0D` background; `NoSplash`; `InputDecorationTheme`; button/FAB themes
- `lib/routes.dart` (new) — `fadeRoute<T>()` helper for calm fade transitions
- `lib/app.dart` — switched to `AppTheme.themeData`; `SharedPreferencesAsync` read wrapped in try/catch (defaults to onboarding on failure)
- All screens — replaced every hardcoded color and text style with `AppColors`/`AppTextStyles`/`AppSpacing` constants
- Timer screen — pulse period increased to 3s; completion word fades in via `AnimationController`; pulse stops cleanly on pause and timer end; fade route to deck on completion
- Onboarding confirm — converted to `ConsumerStatefulWidget`; `_submitting` guard prevents double-tap; loading spinner during save; try/catch with SnackBar on failure; fade routes to timer and deck
- Deck screen — `_navigating` guard on card tap prevents double-push; `_saving` guard in add sheet; try/catch with SnackBar on DB failures; fade route to timer; `FocusNode` for goal→action field tab in sheet; `textInputAction` on all fields
- All screens — `Semantics` labels on buttons, back arrows, FAB, card tiles; `IconButton` constrained to 44×44pt minimum
- `flutter analyze` — no issues
- **Feb 21, 2026:** M2.7–M2.8 — performance and device test confirmed. Phase 2 complete.

## Phase 3 — v1 Feature Build (code complete)
*Feb 21, 2026 · Plan: [ai/roadmaps/complete/2026-02-19-phase-3-v1-features.md](roadmaps/complete/2026-02-19-phase-3-v1-features.md)*

- `pubspec.yaml` — added `in_app_purchase 3.2.3`, `flutter_local_notifications 21.0.0-dev.1`, `timezone 0.11.0`
- `lib/data/models/card_model.dart` — added `isArchived` bool field; added `durationLabel` getter
- `lib/data/models/schedule_model.dart` (new) — `ScheduleModel` with `toMap`/`fromMap`; weekdays as JSON array
- `lib/data/database.dart` — bumped to version 3; `onUpgrade` handles v1→v2 (isArchived + deferrals table) and v2→v3 (schedules table); `onCreate` creates all three tables fresh
- `lib/data/repositories/card_repository.dart` — added `getAllArchivedCards`, `archiveCard`, `restoreCard`, `deferCard`, `getDeferralCount`, `getCardsNeedingArchivePrompt`, `getActiveCardCount`; `getAllCards` now filters `isArchived = 0`
- `lib/data/repositories/schedule_repository.dart` (new) — CRUD for schedules
- `lib/data/templates.dart` (new) — 20 starter templates across 4 areas (Movement, Focus, Connection, Rest)
- `lib/providers/cards_provider.dart` — added `deferCard`, `archiveCard`, `restoreCard`, `getCardsNeedingArchivePrompt`, `getActiveCardCount`
- `lib/services/notification_service.dart` (new) — singleton; `init`, `requestPermission`, `rescheduleAll`; iOS 64-slot queue; computes next 40 instances from active schedules
- `lib/services/purchase_service.dart` (new) — singleton; `init`, `buyPro`, `restorePurchases`; purchase stream listener; Pro status in SharedPreferences
- `lib/main.dart` — initialises `NotificationService` and `PurchaseService` before `runApp`
- `lib/theme.dart` — added `AppTextStyles.label`
- `lib/screens/deck/deck_screen.dart` — swipe-to-defer (Dismissible); Just One mode overlay; archive prompt check on load; actual duration badge; duration slider (1–10 min) in add sheet; template browser sheet with 20 templates; freemium gate (5-card limit); paywall sheet with IAP + restore; Settings nav icon in header
- `lib/screens/timer/timer_screen.dart` — one-time notification permission request after first completion; one-time post-completion explainer ("That's how it works.") via `hasSeenExplainer` flag
- `lib/screens/settings/settings_screen.dart` (new) — resting (archived) cards list; restore; permanent delete with confirmation dialog
- `flutter analyze` — no issues
- ⚠️ **Platform setup required before M3.7/M3.8 device test:** (1) Create `com.microdeck.pro` one-time purchase product in App Store Connect + Google Play Console; (2) Add a white-on-transparent notification icon to `android/app/src/main/res/drawable/`

## Extra — Scope Adjustment & IAP Removal
*Feb 23, 2026*

- Freemium / IAP layer removed from v1 — monetization deferred to Phase 4 (evidence-first)
- `lib/services/purchase_service.dart` deleted
- `pubspec.yaml` — removed `in_app_purchase 3.2.3`
- `lib/main.dart` — removed `PurchaseService.instance.init()`
- `lib/screens/deck/deck_screen.dart` — removed 5-card free limit gate, `_PaywallSheet`, all `isPro` checks; all features now fully accessible
- Phase 4 (App Store Submission) removed — App Store submission added as hypothesis H2 in new Phase 4
- Phase 5 (v2 Planning) renamed to Phase 4 (Future Planning); monetization added as hypothesis H1
- High-level project plan and `context.md` updated to reflect new phase structure

## Extra — App Icon (not tied to a roadmap phase)
*Feb 23, 2026*

- `assets/app_icon.png` (new) — custom 1024×1024 app icon (black background, white cards/checkmark graphic)
- `pubspec.yaml` — added `flutter_launcher_icons 0.14.4` dev dependency; registered `assets/` folder; configured `adaptive_icon_background: #000000` so Android never shows a white ring behind the icon
- Ran `flutter pub run flutter_launcher_icons` — generated all Android (legacy + adaptive) and iOS icon sizes
