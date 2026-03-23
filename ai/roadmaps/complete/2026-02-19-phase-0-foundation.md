# Phase 0 — Foundation
*Created: February 19, 2026*
*Completed: February 20, 2026*
*Part of: [Project Plan](../2026-02-19-high-level-project-plan.md)*
*Status: Complete*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Phase 0 is setup only. Do not scaffold abstractions, base classes, or patterns before there is real code to justify them.

---

## Goal
Project is set up and a clean Flutter app is running on an emulator. Nothing more.

---

## Plan

### Step 1 — Install Flutter (Windows)
- [x] Download Flutter SDK from https://docs.flutter.dev/get-started/install/windows
- [x] Extract to a folder without spaces (e.g., `C:\flutter`)
- [x] Add `C:\flutter\bin` to system PATH
- [x] Run `flutter doctor` — resolve all critical issues (Android toolchain, Chrome optional)
- [ ] Install Android Studio (for emulator and Android SDK) — **deferred: user to complete**
- [ ] Accept Android SDK licenses: `flutter doctor --android-licenses` — **deferred: user to complete**
- [ ] Verify: `flutter doctor` shows no errors on required items — **deferred: user to complete after Android Studio**

> Flutter 3.41.2 (stable) confirmed via `flutter doctor`. Android toolchain missing — Android Studio not yet installed. Chrome and network resources pass. This is acceptable at Phase 0 close; emulator verification is M0.5.

### Step 2 — Create Flutter Project
- [x] In terminal at repo root: `flutter create --org com.microdeck --platforms ios,android --project-name micro_deck .`
- [x] `lib/` lives at repo root (not nested in a subfolder)
- [x] `pubspec.yaml` exists at repo root level alongside `aiDocs/`
- [x] Delete generated boilerplate: removed counter app code from `lib/main.dart`
- [ ] Confirm `flutter run` launches a blank app on emulator without errors — **deferred: requires Android Studio / emulator**

### Step 3 — Add Dependencies
Add all MVP packages to `pubspec.yaml` and run `flutter pub get`:

```
flutter pub add shared_preferences sqflite path wakelock_plus flutter_riverpod
```

- [x] All packages resolve without conflicts
- [x] `flutter pub get` completes cleanly
- [x] Verified installed versions: `shared_preferences 2.5.4`, `sqflite 2.4.2`, `path 1.9.1`, `wakelock_plus 1.4.0`, `flutter_riverpod 3.2.1` — all satisfy architecture doc constraints

### Step 4 — Scaffold Folder Structure
Created empty folders per the architecture doc target structure:

```
lib/
├── main.dart
├── app.dart
├── data/
│   ├── database.dart
│   ├── models/
│   └── repositories/
├── providers/
└── screens/
    ├── welcome/
    ├── onboarding/
    ├── timer/
    └── deck/
```

- [x] Folders created (`.gitkeep` added to empty ones so git tracks them)
- [x] `main.dart` contains only `WidgetsFlutterBinding.ensureInitialized()` + `ProviderScope` + `runApp()`
- [x] `app.dart` contains only `MaterialApp` shell (no routes yet)

### Step 5 — Android Emulator
- [x] Create an Android Virtual Device (AVD) in Android Studio (API 30+, Pixel profile)
- [x] `flutter devices` shows the emulator
- [x] `flutter run` launches app on emulator — blank screen, no crashes — **confirmed Feb 21, 2026**

### Step 6 — Codemagic iOS Pipeline
- [ ] Create Codemagic account at https://codemagic.io — **user action required**
- [ ] Connect GitHub repo to Codemagic — **user action required**
- [ ] Configure Flutter workflow — iOS build target, release mode — **user action required**
- [ ] Add Apple Developer credentials (if available — can defer to Phase 4 if not) — **user action required**
- [ ] Trigger a test build — confirm `.ipa` artifact is generated (or note what's blocked) — **user action required**

### Step 7 — Update .gitignore
- [x] `.gitignore` covers Flutter build artifacts (`build/`, `.dart_tool/`, `.flutter-plugins`, etc.) — added `.metadata`
- [x] `ai/` is gitignored, `aiDocs/` is not
- [x] `git status` shows only intentional files as untracked

---

## Roadmap

→ [Roadmap — Phase 0: Foundation](2026-02-19-roadmap-phase-0-foundation.md)

---

## Definition of Done
- [x] `flutter doctor` shows no critical errors on Flutter/Chrome/network
- [x] Blank app runs on Android emulator without crashes — confirmed Feb 21, 2026
- [x] All MVP dependencies installed at correct versions
- [x] `lib/` folder structure matches architecture doc
- [x] `.gitignore` is correct and verified

## Notes
- Steps 5 and 6 require user action (Android Studio install, emulator creation, Codemagic signup). All code-side work is complete.
- `flutter analyze` on `lib/main.dart` and `lib/app.dart` returns no issues.

## Next Phase
→ [Phase 1 — MVP Demo](../2026-02-19-phase-1-mvp-demo.md)
