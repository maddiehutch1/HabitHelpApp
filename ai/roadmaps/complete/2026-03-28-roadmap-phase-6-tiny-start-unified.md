# Roadmap — Phase 6: Tiny Start Unified
*Created: March 28, 2026 · Retrospectively documented: March 31, 2026*
*Detailed plan: [Phase 6 Plan](2026-03-28-phase-6-tiny-start-unified.md)*
*Previous: [Roadmap — Phase 5](2026-03-28-roadmap-phase-5-daily-refresh.md)*
*Next: [Roadmap — Phase 7](2026-03-31-roadmap-phase-7-voice-ai-suggestions.md)*
*Status: ✅ Complete — all features built and manually tested*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Replace fragmented card creation flows with a single, momentum-building "Tiny Start" experience. Unify onboarding and ongoing card creation into one consistent flow. Add AI-powered suggestions ("I'm stuck", "Make this smaller") to help users when they blank out during task creation.

---

## Milestones

| # | Milestone | Outcome | Status |
|---|---|---|---|
| M6.1 | Rename onboarding → create_card screens | `create_card_goal_screen.dart`, `create_card_action_screen.dart`, `create_card_confirm_screen.dart` exist and used throughout | ✅ Complete |
| M6.2 | Language updates | Goal/action prompts updated to "What feels big and difficult right now?" and "What's one tiny step you could take first?" | ✅ Complete |
| M6.3 | Simplify add flows | Old template browser + add sheets removed; replaced with minimal `_showAddMethodSheet` (voice / type it) → routes to `CreateCardGoalScreen` | ✅ Complete |
| M6.4 | Voice input prefills goal screen | `_openVoiceInput()` routes transcription to `CreateCardGoalScreen(prefilledGoal:)` | ✅ Complete |
| M6.5 | `ai_service.dart` | OpenAI API integration; `generateFirstSteps()`, `makeSmaller()`, `requestConsent()` implemented | ✅ Complete |
| M6.6 | "I'm stuck – show ideas" | Button on `CreateCardActionScreen`; loads 2–3 AI suggestions as tappable chips | ✅ Complete |
| M6.7 | "Make this smaller" | Button appears after typing in action field; returns one smaller suggestion as chip | ✅ Complete |
| M6.8 | AI consent dialog | First-time consent prompt before any AI call fires; saved to `aiSuggestionsEnabled` pref | ✅ Complete |
| M6.9 | Settings AI toggle | AI Suggestions toggle in `settings_screen.dart`; disabling hides AI buttons | ✅ Complete |
| M6.10 | Delete `templates.dart` | `lib/data/templates.dart` deleted | ✅ Complete |
| M6.11 | `flutter analyze` clean | No issues | ✅ Complete |
| M6.12 | Manual testing checklist | All items below pass on real device | ✅ Complete |

---

## Manual Testing Checklist

### Phase 6.1 — Unified Flow

**First-Time User:**
- [x] Welcome screen → "Let's begin" → goal screen shows
- [x] Goal screen: prompt reads "What feels big and difficult right now?"
- [x] Action screen: prompt reads "What's one tiny step you could take first?"
- [x] Confirm screen: updated language shown
- [x] Timer starts correctly with 2-minute countdown
- [x] Card saved after completion

**Returning User:**
- [x] Tap + button on deck → voice/type sheet appears (no template browser)
- [x] Tap "Type it" → goal screen shows; full flow: goal → action → confirm → timer/save
- [x] Tap "Use voice" → records → prefills goal screen
- [x] Prefilled text is editable before advancing

**Regression:**
- [x] Fresh Start mode still works (daily rollover, Past Days)
- [x] Timer "Keep going" still works
- [x] Settings screen still accessible
- [x] No template-related code or UI visible anywhere

### Phase 6.2 — AI Suggestions

**AI Consent:**
- [x] First tap on "I'm stuck" → consent dialog appears
- [x] "Don't allow" → button becomes disabled, tooltip shown
- [x] "Allow" → API call fires, suggestions appear
- [x] Consent saved; dialog does not reappear
- [x] Settings AI toggle reflects consent state

**"I'm stuck – show ideas":**
- [x] Button visible on action screen
- [x] Tap → loading indicator appears
- [x] 2–3 suggestions appear as tappable chips
- [x] Tapping chip fills text input
- [x] Error snackbar shown if API call fails

**"Make this smaller":**
- [x] Button only appears after typing in action field
- [x] Tap → loading indicator appears
- [x] Single smaller suggestion appears as chip
- [x] Tapping chip replaces text input
- [x] Error handling if API fails

**Settings / Privacy:**
- [x] Settings shows AI Suggestions toggle
- [x] Disabling toggle → AI buttons become disabled
- [x] Re-enabling → AI buttons work again
- [x] API key loaded correctly via `--dart-define` or `.env.json`

---

## Definition of Done

- [x] Onboarding screens renamed to `create_card/`
- [x] Language updated in goal, action, confirm screens
- [x] + button opens voice/type sheet → routes to `CreateCardGoalScreen`
- [x] Voice input prefills goal screen
- [x] Template browser and add sheets removed from `deck_screen.dart`
- [x] `templates.dart` deleted
- [x] `ai_service.dart` implemented
- [x] "I'm stuck – show ideas" works on action screen
- [x] "Make this smaller" works on action screen
- [x] Consent dialog on first AI tap
- [x] Settings AI Suggestions toggle works
- [x] `flutter analyze` clean
- [x] All manual testing checklist items pass on real device

---

## Progress Log

| Date | Milestone | Notes |
|---|---|---|
| Mar 28, 2026 | M6.1–M6.9, M6.11 | All major features built (Evan's branch). Merged to origin/main Mar 30, 2026 via PR #1. |
| Mar 31, 2026 | Roadmap doc created | Retrospectively documented. M6.12 manual testing still pending. |
| Mar 31, 2026 | M6.10 | `templates.dart` deleted. |
| Mar 31, 2026 | Code verification | M6.1–M6.11 all confirmed present in codebase. One nuance: FAB opens a minimal voice/type sheet (`_showAddMethodSheet`), not a direct push to `CreateCardGoalScreen` — old template browser is gone, new sheet is intentional. |
| Mar 31, 2026 | M6.12 — Manual testing | All checklist items passed on real device. Phase 6 complete. |
