# Roadmap — Phase 5: Daily Refresh
*Created: March 28, 2026 · Retrospectively documented: March 31, 2026*
*Detailed plan: [Phase 5 Plan](2026-03-28-phase-5-daily-refresh.md)*
*Previous: [Phase 4 — Future Planning](2026-02-19-roadmap-phase-4-future-planning.md)*
*Next: [Roadmap — Phase 6](2026-03-28-roadmap-phase-6-tiny-start-unified.md)*
*Status: ✅ Complete — all features built and manually tested*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Add an optional daily refresh mode (Fresh Start) that helps users with daily structure and guided task breakdown, while preserving the existing persistent deck as the default experience. Add voice input for daily planning, a Past Days archive view, and a "Keep going" timer enhancement.

---

## Milestones

| # | Milestone | Outcome | Status |
|---|---|---|---|
| M5.1 | Settings screen | Fresh Start toggle implemented; accessible via gear icon in deck header | ✅ Complete |
| M5.2 | Daily rollover logic | App detects new day on resume; archives active cards when Fresh Start ON; `lastOpenDate` tracked in prefs | ✅ Complete |
| M5.3 | Past Days screen | Archived cards grouped by date; "Move to today" restore; accessible from deck in Fresh Start mode | ✅ Complete |
| M5.4 | Voice input | `VoiceService` + `VoiceInputSheet`; 30s recording; live transcription; permission handling on iOS + Android | ✅ Complete |
| M5.5 | Timer "Keep going" | Completion shows [Done] / [Keep going]; extra time tracked; `sessions` table stores completion data | ✅ Complete |
| M5.6 | Database schema v4 | `archivedDate` field on cards; `sessions` table; `session_model.dart`; migration in `database.dart` | ✅ Complete |
| M5.7 | New dependencies | `speech_to_text: ^7.0.0`; `intl` for date formatting; permissions added to `Info.plist` + `AndroidManifest.xml` | ✅ Complete |
| M5.8 | Manual testing checklist | All items below pass on real device | ✅ Complete |

---

## Manual Testing Checklist

**Fresh Start Mode Toggle:**
- [x] Default is OFF on first install
- [x] Toggling ON shows voice button and "Past days" link
- [x] Toggling OFF hides voice button and "Past days" link
- [x] Toggling OFF does not delete archived cards (they remain in DB)

**Daily Rollover:**
- [x] Open app on Day 1, create 3 cards, close app
- [x] Change device date to Day 2, open app
- [x] All 3 cards moved to Past Days, main deck is empty
- [x] Create 1 new card on Day 2
- [x] Change date to Day 3, open app
- [x] Day 2 card moved to Past Days; Day 1 cards remain (grouped separately)

**Voice Input:**
- [x] Microphone permission requested on first use only
- [x] Recording starts, countdown shows, stops at 30s automatically
- [x] User can stop early with [Stop] button
- [x] Transcription appears in editable text box
- [x] [Discard] dismisses sheet, no card created
- [x] [Create cards from this] routes to card creation flow

**Timer Keep Going:**
- [x] Timer completes 2:00, shows [Done] [Keep going]
- [x] [Done] returns to deck (existing behavior)
- [x] [Keep going] restarts timer at 2:00
- [x] Can tap [Keep going] multiple times
- [x] Final completion shows "2 minutes + [extra time]"
- [x] Session stored in database with correct extraTimeSeconds

**Past Days Screen:**
- [x] Shows cards grouped by date
- [x] "Yesterday" shows for previous day
- [x] Older dates show as "Mar 26", "Mar 25", etc.
- [x] Tapping card opens timer
- [x] Long press → "Move to today" removes from Past Days, adds to main deck
- [x] Empty state shows when no archived cards

**Regression:**
- [x] Persistent deck mode (Fresh Start OFF) works identically to pre-Phase 5
- [x] All existing features unaffected: timer, onboarding, card creation, persistence

**Edge Cases:**
- [x] App opened after 7 days — cards archived with original dates, not compounded
- [x] Microphone permission denied — clear error, [Open Settings] link works

---

## Schema Changes

| DB Version | Change | Status |
|---|---|---|
| v4 | `archivedDate INTEGER` added to `cards` table | ✅ |
| v4 | `sessions` table created | ✅ |

---

## Definition of Done

- [x] Settings screen with Fresh Start toggle implemented
- [x] Daily rollover logic works correctly
- [x] Past Days screen shows archived cards grouped by date
- [x] Voice input with local transcription works on iOS and Android
- [x] Timer "Keep going" enhancement implemented
- [x] Database schema v4 migration complete
- [x] All manual testing checklist items pass on real device

---

## Progress Log

| Date | Milestone | Notes |
|---|---|---|
| Mar 28, 2026 | M5.1–M5.7 | All features built (Evan's branch). Merged to origin/main Mar 30, 2026 via PR #1. |
| Mar 31, 2026 | Roadmap doc created | Retrospectively documented. M5.8 manual testing checklist not yet formally run. |
| Mar 31, 2026 | Code verification | M5.1–M5.7 all confirmed present in codebase: settings screen, past days screen, voice service, voice input sheet, timer keep going, DB schema v4, session model, speech_to_text + intl deps, daily rollover lifecycle logic. |
| Mar 31, 2026 | M5.8 — Manual testing | All checklist items passed on real device. Phase 5 complete. |
