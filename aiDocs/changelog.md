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

## Phase 7 — Voice AI Suggestions (code complete)
*Mar 31, 2026 · Plan: [ai/roadmaps/2026-03-31-phase-7-voice-ai-suggestions.md](roadmaps/2026-03-31-phase-7-voice-ai-suggestions.md)*

- `lib/services/ai_service.dart` — added `suggestTasksFromTranscription(String transcription)`: calls OpenAI `gpt-4o-mini`, extracts up to 3 task titles from a voice note, 8 s timeout, returns empty list on any error/no-consent
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` (new) — full screen; shows 1–3 checkable, inline-editable suggestion tiles; [Add selected] + "Add manually instead" fallback; `_processNextTask()` drives multi-card queue via `onCardSaved` callback
- `lib/screens/create_card/create_card_goal_screen.dart` — added optional `onCardSaved: VoidCallback?`; threaded through to `CreateCardActionScreen`
- `lib/screens/create_card/create_card_action_screen.dart` — added optional `onCardSaved`; threaded through to `CreateCardConfirmScreen`
- `lib/screens/create_card/create_card_confirm_screen.dart` — added optional `onCardSaved`; `_saveLater()` uses `popUntil('/voiceSuggestions')` + calls callback when queue is active, preserving existing `pushAndRemoveUntil(DeckScreen)` for the standard path
- `lib/screens/deck/deck_screen.dart` — `_openVoiceInput()` now checks AI consent, shows `_VoiceProcessingDialog` while parsing, routes to `VoiceAISuggestionsScreen` (route name `/voiceSuggestions`) on success, falls back to `CreateCardGoalScreen(prefilledGoal:)` on empty result or no consent; added `_VoiceProcessingDialog` widget
- `integration_test/app_test.dart` — added "Voice AI suggestions — regression" group: FAB still shows voice/type options; "Type it" still reaches goal screen
- `flutter analyze` — no issues

---

## Phase 5 — Daily Refresh (code complete, tested)
*Mar 28–31, 2026 · Plan: [ai/roadmaps/2026-03-28-phase-5-daily-refresh.md](roadmaps/2026-03-28-phase-5-daily-refresh.md)*

- `lib/screens/settings/settings_screen.dart` (new) — Fresh Start mode toggle; gear icon in deck header navigates here
- `lib/screens/past_days/past_days_screen.dart` (new) — archived cards grouped by date ("Yesterday" / `Mar 26`); long-press → "Move to today" restores card to active deck
- `lib/services/voice_service.dart` (new) — `startListening()` / `stopListening()` wrapper over `speech_to_text`; handles microphone permission request
- `lib/screens/deck/widgets/voice_input_sheet.dart` (new) — 30-second recording bottom sheet; live transcription; [Discard] / [Create cards from this]
- `lib/screens/timer/timer_screen.dart` — completion shows [Done] / [Keep going]; `_extraTimeSeconds` tracked; `_storeSession()` writes to `sessions` table
- `lib/data/database.dart` — schema v4: `archivedDate INTEGER` added to `cards`; `sessions` table created; `onUpgrade` handles v1–v4
- `lib/data/models/session_model.dart` (new) — `SessionModel` with `toMap` / `fromMap`
- `lib/screens/deck/deck_screen.dart` — `WidgetsBindingObserver` + `_checkDailyRollover()` archives active cards when date changes (Fresh Start mode only); `lastOpenDate` pref maintained
- `pubspec.yaml` — added `speech_to_text: ^7.0.0`, `intl: ^0.20.1`; microphone permissions added to `Info.plist` + `AndroidManifest.xml`

## Phase 6 — Unified Tiny Start Flow with AI (code complete, tested)
*Mar 28–31, 2026 · Plan: [ai/roadmaps/2026-03-28-phase-6-tiny-start-unified.md](roadmaps/2026-03-28-phase-6-tiny-start-unified.md)*

- `lib/screens/onboarding/` → renamed to `lib/screens/create_card/`; classes renamed `CreateCardGoalScreen`, `CreateCardActionScreen`, `CreateCardConfirmScreen`
- Language updated across all three screens (goal: "What feels big and difficult right now?"; action: "What's one tiny step you could take first?"; confirm: "Ready for your tiny start?")
- `lib/screens/deck/deck_screen.dart` — + FAB opens `_AddMethodSheet` (voice / type it); template browser + add sheets removed; `_openVoiceInput()` routes transcription to `CreateCardGoalScreen(prefilledGoal:)`; `CreateCardGoalScreen` accepts optional `prefilledGoal`
- `lib/services/ai_service.dart` (new) — OpenAI `gpt-4o-mini` integration; `generateFirstSteps()`, `makeSmaller()`, `requestConsent()` (first-time dialog + `aiSuggestionsEnabled` pref)
- `lib/screens/create_card/create_card_action_screen.dart` — "I'm stuck – show ideas" button (2–3 AI chips); "Make this smaller" button (1 smaller chip); both respect consent gate
- `lib/screens/settings/settings_screen.dart` — AI Suggestions toggle added
- `lib/data/templates.dart` — deleted (no longer referenced)
- `test/unit/templates_test.dart` — deleted (tested deleted file)
- `pubspec.yaml` — added `http: ^1.2.0`; `.env.json` stores `OPENAI_API_KEY` (gitignored)

---

## Phase 8 — Momentum Capture & Dashboard Redesign (code complete)
*Apr 6, 2026 · Plan: [ai/roadmaps/2026-04-06-phase-8-momentum-dashboard.md](../ai/roadmaps/2026-04-06-phase-8-momentum-dashboard.md)*

- `lib/data/database.dart` — bumped to version 5; `onUpgrade` handles v4→v5 (`completedAt INTEGER` added to `cards`)
- `lib/data/models/card_model.dart` — added `completedAt` nullable int field; updated `toMap`/`fromMap`
- `lib/data/repositories/card_repository.dart` — added `completeCard()`, `getCompletedCards()`, `updateCard()`, `getGoalLabelsWithRecentSessions()`; removed `getCardsNeedingArchivePrompt()`
- `lib/providers/cards_provider.dart` — wired new repo methods; removed `getCardsNeedingArchivePrompt()`
- `lib/screens/deck/widgets/card_detail_sheet.dart` (new) — bottom sheet with Start / What's next / Edit / Complete actions
- `lib/screens/deck/completion_screen.dart` (new) — full-screen celebration with animated checkmark, warm copy, delayed "Back to deck" button
- `lib/screens/create_card/next_step_screen.dart` (new) — goal context + action input + AI assistance + Start button; creates card and starts timer
- `lib/screens/deck/deck_screen.dart` — tap card now opens detail bottom sheet instead of timer; added `_openCardDetail()`, `_showEditSheet()`, `_CardAction` enum; wired completion flow and continue-next; added `_recentGoalLabels` state + "Continue →" nudge on card tiles; removed `_ArchivePromptSheet` and `_checkArchivePrompts()`
- `lib/screens/timer/timer_screen.dart` — after "Done", shows continuation prompt ("Ready for the next tiny step?") leading to NextStepScreen; prompt only shown for cards with goalLabel
- `lib/screens/past_days/past_days_screen.dart` — added "Completed" section above date-grouped archives with `_CompletedCardTile`
- `test/unit/card_repository_test.dart` — removed obsolete archive prompt tests
- `flutter analyze` — no issues

---

## Phase 9 — Card Detail Sheet Cleanup & AI Button Polish
*Apr 6, 2026 · Plan: [ai/roadmaps/2026-04-06-phase-9-sheet-and-ai-polish.md](../ai/roadmaps/2026-04-06-phase-9-sheet-and-ai-polish.md)*

- `lib/theme.dart` — added `AppColors.aiAccent` (muted gold `#D4A855`) for AI button styling
- `lib/screens/deck/widgets/card_detail_sheet.dart` — restructured layout: Start + What's next stacked as primary/secondary; Edit + Complete collapsed into compact horizontal icon row with `textFaint` styling
- `lib/screens/create_card/next_step_screen.dart` — "Help me think of one" and "Make this smaller" buttons changed to `TextButton.icon` with sparkle icon (`Icons.auto_awesome`) and `aiAccent` color
- `lib/screens/create_card/create_card_action_screen.dart` — "I'm stuck – show ideas" and "Make this smaller" buttons changed to `TextButton.icon` with sparkle icon and `aiAccent` color
- `flutter analyze` — no issues

---

## Phase 10 — UX Fixes
*Apr 6, 2026 · Plan: [ai/roadmaps/2026-04-06-phase-10-ux-fixes.md](../ai/roadmaps/2026-04-06-phase-10-ux-fixes.md)*

- `lib/screens/deck/deck_screen.dart` — Continue nudge enlarged: `GestureDetector` spans full tile width with `HitTestBehavior.opaque`, text bumped from 12px to 14px, 12px vertical padding for ~44px tap target
- `lib/screens/timer/timer_screen.dart` — Overtime "Do next task" now skips `CelebrationScreen`; navigates directly to `NextStepScreen` (if card has goal) or `DeckScreen` (if not)
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — Converted to `ConsumerStatefulWidget`; "Add selected" now batch-creates cards via `cardsProvider.notifier.addCard()` instead of stepping through `CreateCardGoalScreen` per task; removed `_queue` and `_processNextTask()`
- `lib/screens/deck/deck_screen.dart` — Swipe-to-defer replaced with swipe-to-complete; triggers `CompletionScreen` flow via `confirmDismiss`
- `lib/app.dart` & `lib/screens/` — Implemented global intuitive keyboard dismissal (tapping outside TextFields properly unfocuses them) across goal screens, action screens, UI sheets, and AI forms.
- `lib/screens/create_card/next_step_screen.dart` & `lib/screens/create_card/create_card_action_screen.dart` — Improved AI suggestion interactivity clarity by wrapping `_SuggestionTile` in `Material` and `InkWell`, adding an upward arrow icon, and a subtle border stroke (`AppColors.aiAccent`) to distinguish AI suggestions as interactive elements.
- `ai/notes/possible-future-feature-swipe-timer.md` (new) — Documented out-of-scope swipe-to-set timer UX proposal.
- `lib/screens/deck/widgets/card_detail_sheet.dart` & `lib/screens/deck/deck_screen.dart` — Added dynamic `safePadding` to bottom sheets to gracefully handle global bottom padding and OS navigation zones without clipping content.
- `flutter analyze` — no issues

---

## Phase 11 — UI Polish & Voice Fix
*Apr 7, 2026 · Plan: [ai/roadmaps/2026-04-07-phase-11-ui-polish-voice-fix.md](../ai/roadmaps/2026-04-07-phase-11-ui-polish-voice-fix.md)*

- `lib/screens/deck/widgets/voice_input_sheet.dart` — Shortened "Create cards from this" button to "Create cards" to prevent text wrapping
- `lib/screens/deck/completion_screen.dart` — Added confetti + haptic feedback to match CelebrationScreen; body wrapped in Stack with ConfettiWidget overlay
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — Voice-created tasks now set `goalLabel` to AI-extracted title and `actionLabel` to "Get started", enabling continuation flow ("What's next?", "Do next task")
- `lib/screens/deck/widgets/card_detail_sheet.dart` — Reduced spacing (`lg→md`, `xs→4`) to fix bottom overflow hiding Edit/Complete row on cards with goalLabel
- `lib/data/repositories/card_repository.dart` — Added `restoreCompletedCard()` method that clears `completedAt` + `isArchived` and assigns new sort order
- `lib/screens/past_days/past_days_screen.dart` — Completed cards now support long-press → "Restore to deck?" bottom sheet; added `_showRestoreSheet`, `_restoreCompletedCard`, and `onLongPress` on `_CompletedCardTile`
- `flutter analyze` — no issues

---

## Phase 12 — UI Polish
*Apr 7, 2026 · Plan: [ai/roadmaps/2026-04-07-phase-12-ui-polish.md](../ai/roadmaps/2026-04-07-phase-12-ui-polish.md)*

- `lib/screens/deck/completion_screen.dart` — Main text now shows `actionLabel` (the tiny step) instead of `goalLabel`; primary button renamed to "Go Back to Home"; added optional `onNextStep` callback + "Plan my next step →" `OutlinedButton` (shown only when card has a goal)
- `lib/screens/deck/deck_screen.dart` — Both `CompletionScreen` usages updated to pass `onNextStep` that completes the card then opens `NextStepScreen`; removed `_recentGoalLabels` state and `getGoalLabelsWithRecentSessions()` call; removed `showContinueNudge`/`onContinue` from `_CardTile`
- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — Edit/confirm icon size bumped from 18 → 22; confirm (checkmark) icon uses `textPrimary` color when editing so "tap to save" is visually distinct from the pencil
- `lib/screens/deck/widgets/card_detail_sheet.dart` — "What's next?" and Edit/Complete secondary actions changed from `TextButton` to `OutlinedButton` for consistent visual weight without competing with the primary Start button
- Removed legacy "Just One mode" dead code from `deck_screen.dart`
- `lib/screens/deck/deck_screen.dart` — Fixed `TextEditingController` used-after-disposed crash in edit sheet; extracted `_EditCardSheet` `StatefulWidget` so controllers are tied to widget lifecycle
- `lib/screens/timer/timer_screen.dart` — Confetti moved from overtime entry to "I'm finished" tap; overtime "Do next task" button removed; "I'm finished" now routes to `CelebrationScreen`; removed redundant `ConfettiController` from timer
- Completion screens unified: both show small muted task label → randomized headline → focus time (where available) → `FilledButton` primary action → `OutlinedButton` "Go back to home"
- `lib/screens/timer/celebration_screen.dart` + `lib/screens/deck/completion_screen.dart` — Shared `celebrationPhrases` const list (10 phrases); headline randomized per session so completion never feels repetitive; button order swapped so "Do next task" / "Plan my next step →" is the filled primary
- `flutter analyze` — no issues

---

## Extra — App Icon (not tied to a roadmap phase)
*Feb 23, 2026*

- `assets/app_icon.png` (new) — custom 1024×1024 app icon (black background, white cards/checkmark graphic)
- `pubspec.yaml` — added `flutter_launcher_icons 0.14.4` dev dependency; registered `assets/` folder; configured `adaptive_icon_background: #000000` so Android never shows a white ring behind the icon
- Ran `flutter pub run flutter_launcher_icons` — generated all Android (legacy + adaptive) and iOS icon sizes

---

## Extra — Final UI Polish & Bug Squashing
*Apr 7, 2026*

- `lib/screens/create_card/voice_ai_suggestions_screen.dart` — Wrapped the screen in a `ListView` to resolve pixel overflow crashes when the keyboard appears during inline editing.
- `lib/screens/timer/timer_screen.dart` & `lib/screens/timer/celebration_screen.dart` — Fixed aggressive navigation stack clearing (`pushAndRemoveUntil` with `route.isFirst` instead of `false`) to prevent the app from routing to a blank, black screen when pressing Back.
- `lib/screens/timer/celebration_screen.dart` — Fixed the "Do next task" button routing bug introduced in a recent merge; it now correctly routes to `NextStepScreen` (if there's a goal label) instead of redundantly dumping to `DeckScreen`.
- `lib/screens/timer/celebration_screen.dart` & `lib/screens/deck/completion_screen.dart` — Substantially reduced Confetti blast particles (30 -> 10) and blast force to restore a clean, minimalist pop instead of an intense shower.
- `lib/screens/deck/deck_screen.dart` — Restored `showContinueNudge` logic and `_recentGoalLabels` tracking to successfully surface "Next Step" shortcuts for active projects, overruling the Phase 12 decision to remove it after determining Evans' Phase 8 implementation intent.

---

## Extra — Demo Polish
*Apr 7, 2026*

- `lib/screens/timer/celebration_screen.dart` — Removed post-completion explainer sheet ("That's how it works.") and continuation prompt ("Ready for the next tiny step?"); both added modal friction after task completion. "Do next task" and "Go back to home" now both navigate directly to `DeckScreen`. Removed unused imports (`shared_preferences`, `notification_service`, `next_step_screen`).
- `lib/screens/deck/deck_screen.dart` — Permanently removed "Next Step →" nudge button from `_CardTile`; removed `showContinueNudge` and `onContinue` props, `_recentGoalLabels` state, and `getGoalLabelsWithRecentSessions()` call from `_onLoad`. Nudge was redundant — deck screen already surfaces all available cards.
- `lib/screens/deck/completion_screen.dart` — Removed `onNextStep` prop and `hasNextStep` logic; primary button changed from "Plan my next step →" to "Do next task" (FilledButton); both "Do next task" and "Go back to home" now call `onComplete` and navigate to `DeckScreen`. Completion screen UI now matches `CelebrationScreen` exactly.
- `lib/screens/deck/deck_screen.dart` — Removed `onNextStep` callback from both `CompletionScreen` call sites (card detail "Complete" action + swipe-to-complete); no longer navigates to `NextStepScreen` from completion flow.
- `lib/screens/create_card/next_step_screen.dart` — Added "Save for later" `TextButton` below "Start"; extracted shared `_buildAndSaveCard()` helper; added `_submitting` guard; `_saveLater()` saves card to deck and navigates to `DeckScreen` without starting timer — matches `CreateCardConfirmScreen` pattern.
- `lib/screens/welcome/welcome_screen.dart` — App name updated from "Micro-Deck" to "MicroDeck"; "Deck" bolded via `RichText`/`TextSpan` (`Micro` at `w300`, `Deck` at `w700`) while keeping both words visually joined.
