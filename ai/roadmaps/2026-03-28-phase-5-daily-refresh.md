# Phase 5 — Daily Refresh Feature (Optional Mode)
*Created: March 28, 2026*
*Part of: Micro-Deck v2 Feature Expansion*
*Previous: [Phase 4 — Future Planning](2026-02-19-phase-4-future-planning.md)*
*Status: ✅ Complete — Mar 31, 2026*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> This is a feature addition to an existing clean codebase. No backwards-compatibility hacks. No unused abstractions. No premature optimization. Keep it simple, keep it clean, delete fearlessly.

---

## Goal

Add an **optional daily refresh mode** that helps users who want daily structure and guided task breakdown, while preserving the existing persistent deck as the default experience.

**Core Principle:** This is an *opt-in enhancement*, not a replacement. Users who love the current persistent deck behavior should never feel this feature exists unless they choose to enable it.

---

## What This Adds

### Primary Features

1. **Daily Refresh Mode (Optional)**
   - Users can toggle between "Persistent Deck" (current, default) and "Fresh Start" mode
   - In Fresh Start mode: main deck shows only today's cards; previous days archived automatically
   - Setting lives in a new minimal Settings screen

2. **Voice Input for Daily Planning**
   - Optional voice-to-text button on deck screen (Fresh Start mode only)
   - Transcribes 30-second voice dump into text
   - Uses local device speech recognition (no network required)
   - AI-powered task breakdown from transcription (using OpenAI API)

3. **AI Task Breakdown Assistance**
   - "I'm stuck — show ideas" button during card creation
   - Shows 2–3 AI-generated tiny first step suggestions
   - "Make this smaller" button to break down tasks further
   - Works from voice transcription OR manual text input
   - User opt-in required, clear privacy disclosure

4. **Archive Page ("Past Days")**
   - Accessible from deck screen via subtle "Past days" link
   - Shows previous days' cards grouped by date
   - Cards can be restored to current deck
   - Language: "past," "previous," never "failed" or "missed"

5. **Timer Enhancement: "Keep Going" Option**
   - After 2-minute timer completes, show two buttons:
     - "Done" (current behavior — return to deck)
     - "Keep going" (restart timer, track extended time)
   - Extended time shows on completion: "2 minutes + 3:21 extra"
   - No separate tracking — just a UX enhancement

6. **Minimal Settings Screen**
   - Single toggle: "Fresh Start mode" (on/off, default: off)
   - Future-proof for additional settings but keep minimal
   - Accessible via gear icon in deck screen header

### Privacy & Network Requirements

**This phase adds network dependency:**
- OpenAI API integration for AI task breakdown
- Requires user opt-in before any data sent
- Clear disclosure: "AI suggestions will send your text to OpenAI"
- Settings toggle: "Enable AI suggestions" (default: ON, but requires first-time consent)
- Privacy policy update required: no longer "no data collected"
- API key management (secure storage, rate limiting)

---

## Design Principles for This Feature

1. **Default to current behavior** — Fresh Start mode is opt-in, not the default
2. **No visible history unless user wants it** — Past Days page is hidden unless Fresh Start is enabled
3. **No guilt language** — archived cards are "from yesterday," not "incomplete" or "missed"
4. **Local-first** — voice transcription uses device APIs, no network needed for core feature
5. **Additive, not disruptive** — existing users see zero change unless they enable Fresh Start

---

## User Flows

### Flow 1: Enabling Fresh Start Mode

```
User opens app → Deck Screen
  ↓
Taps gear icon → Settings Screen
  ↓
Sees toggle: "Fresh Start mode" (off by default)
Sub-text: "Start each day with a blank deck. Yesterday's cards move to Past Days."
  ↓
Enables toggle → returns to Deck Screen
  ↓
Deck now shows "Today" header
Voice input button appears at bottom
"Past days" link appears faintly at bottom
```

### Flow 2: Voice Input Daily Planning (Fresh Start Mode Only)

```
User in Fresh Start mode → Deck Screen
  ↓
Taps microphone button → Voice Input Sheet opens
  ↓
Prompt: "What's on your mind today? (30 seconds)"
Timer shows countdown: 30s → 0s
  ↓
Recording stops automatically at 30s (or user taps Stop early)
  ↓
Transcription appears in editable text box
  ↓
User reviews/edits text
  ↓
User taps "Create cards from this"
  ↓
User manually selects text segments to turn into cards
(Future: AI suggests breakdown; Phase 5.1 = manual only)
  ↓
Cards appear in Today deck
```

### Flow 3: Timer "Keep Going" Enhancement (All Modes)

```
User taps card → Timer Screen starts (2:00)
  ↓
Timer counts down → 0:00
  ↓
Haptic fires → Completion screen shows
  ↓
New UI:
  "You hit your 2 minutes."
  [Done]  [Keep going]
  ↓
If "Done": return to deck (current behavior)
  ↓
If "Keep going": timer restarts at 2:00, but tracks "extra time"
  ↓
User can keep hitting "Keep going" indefinitely
  ↓
Final completion shows: "2 minutes + 5:43 extra"
Then [Done] returns to deck
```

### Flow 4: Viewing Past Days (Fresh Start Mode Only)

```
User in Fresh Start mode → Deck Screen
  ↓
Taps "Past days" link at bottom
  ↓
Past Days Screen opens
  ↓
Shows cards grouped by date:
  "Yesterday (March 27)"
    - Card 1
    - Card 2
  "March 26"
    - Card 3
  ↓
User can:
  - Tap card → opens timer (works normally)
  - Long press → "Move to today" option
  ↓
"Move to today" removes from archive, adds to current deck
```

### Flow 5: Daily Rollover (Fresh Start Mode, Automatic)

```
Midnight passes (date changes)
  ↓
App detects new day on next open (via AppLifecycleState.resumed)
  ↓
All cards in "today" deck:
  - Update `archivedDate` to yesterday's date
  - Remain in database, no longer show in main deck
  ↓
User opens app → sees empty deck (or cards from today if they've created any)
  ↓
"Past days" link shows badge: "3" (number of cards from yesterday)
```

---

## Technical Approach

### Data Model Changes

**New fields in `cards` table (schema v4):**

| Field | Type | Notes |
|---|---|---|
| `archivedDate` | INTEGER | millisecondsSinceEpoch; null = active card, non-null = archived on this date |
| `createdDate` | INTEGER | millisecondsSinceEpoch; already exists as `createdAt`, rename for clarity |

**New table: `sessions` (schema v4):**

| Field | Type | Notes |
|---|---|---|
| `id` | TEXT PRIMARY KEY | millisecondsSinceEpoch string |
| `cardId` | TEXT NOT NULL | FK → cards.id |
| `startedAt` | INTEGER NOT NULL | millisecondsSinceEpoch |
| `completedAt` | INTEGER | millisecondsSinceEpoch; null = abandoned |
| `baseDurationSeconds` | INTEGER NOT NULL | Always 120 for Phase 5 |
| `extraTimeSeconds` | INTEGER | Default: 0; tracks "keep going" time |

**Note:** We're NOT storing full voice transcriptions or AI prompts. Voice input is ephemeral — transcription is shown to user, then discarded after card creation.

**New shared_preferences keys:**

| Key | Type | Purpose |
|---|---|---|
| `isFreshStartMode` | bool | Default: false; toggles daily refresh behavior |
| `lastOpenDate` | int | millisecondsSinceEpoch; tracks date rollover for auto-archive |

### Speech-to-Text (Local, No Network)

Use Flutter's `speech_to_text` package (verified on pub.dev):
- On-device transcription (uses iOS Speech Framework / Android SpeechRecognizer)
- No network required
- Requires microphone permission (request on first use only)
- 30-second time limit enforced in UI

**Implementation:**
```
lib/services/voice_service.dart
  - startListening(maxDuration: 30s, onResult: callback)
  - stopListening()
  - Handles permission request
  - Returns transcription as String
```

**Permission handling:**
- iOS: Add `NSSpeechRecognitionUsageDescription` and `NSMicrophoneUsageDescription` to `Info.plist`
- Android: Add `<uses-permission android:name="android.permission.RECORD_AUDIO"/>` to `AndroidManifest.xml`
- Request permission on first voice button tap, not during app launch

### Daily Rollover Logic

**Trigger:** `AppLifecycleState.resumed` in `deck_screen.dart`

**Check:**
```dart
1. Read `lastOpenDate` from shared_preferences
2. Get current date (DateTime.now())
3. If dates differ (new day detected):
   a. If `isFreshStartMode == true`:
      - Query all cards where `archivedDate == null`
      - Update each: set `archivedDate` to yesterday's date
   b. Update `lastOpenDate` to today
   c. Refresh deck view
```

**Edge cases:**
- If user hasn't opened app in 3 days, cards from "3 days ago" get archived with that date (no compounding)
- If user toggles Fresh Start mode OFF, archived cards remain archived but deck shows all active cards again
- If user toggles Fresh Start mode ON, existing active cards do NOT auto-archive — only new day rollovers trigger archiving

### Settings Screen (New)

**File:** `lib/screens/settings/settings_screen.dart`

**Contents:**
- Full-screen, dark background (matches deck aesthetic)
- Header: "Settings"
- One toggle (for now): "Fresh Start mode"
  - Sub-text: "Start each day with a blank deck. Yesterday's cards move to Past Days."
  - Default: OFF
  - Saves to `shared_preferences.isFreshStartMode`
- Back arrow returns to deck
- Future items can be added here (notifications, timer duration, etc.)

**Navigation:**
- Accessible via gear icon in deck screen header (top-right)
- No tab bar — keep it a single-purpose screen

### Past Days Screen (New)

**File:** `lib/screens/past_days/past_days_screen.dart`

**Behavior:**
- Only accessible when `isFreshStartMode == true` (link hidden otherwise)
- Query: `SELECT * FROM cards WHERE archivedDate IS NOT NULL ORDER BY archivedDate DESC`
- Group by `archivedDate` using `DateFormat.MMMd()` for display (e.g., "Mar 27")
- Show "Yesterday" for previous day, actual date for older
- Card tap → opens timer (works identically to deck)
- Long press → show bottom sheet with "Move to today" option
  - Sets `archivedDate` back to `null`, card reappears in main deck

**Empty state:**
- "No past days yet. Cards will appear here each day when you enable Fresh Start mode."

### Voice Input UI (Deck Screen Enhancement)

**Only shows when `isFreshStartMode == true`**

**Button location:** Bottom of deck screen, below card list, above "Past days" link

**Button:** Microphone icon + "Voice planning" label

**Tapped behavior:**
1. Opens bottom sheet modal
2. Shows: "What's on your mind today? (30 seconds)"
3. Large pulsing microphone icon (indicates recording active)
4. Countdown timer: "30s remaining"
5. [Stop] button (user can stop early)
6. On stop or timeout:
   - Show transcription in editable text area
   - Buttons: [Discard] [Create cards from this]
7. "Create cards from this":
   - For Phase 5.1: user manually highlights text, taps "New card," fills in card form (goal + action)
   - For Phase 5.2 (deferred): AI suggests breakdown

**Permissions:**
- On first tap: request microphone + speech recognition permissions
- If denied: show alert "Voice input requires microphone access" with [Open Settings] button
- If granted: proceed with recording

### Timer "Keep Going" Enhancement (All Modes)

**Changes to `timer_screen.dart`:**

**New state variables:**
```dart
int _extraTimeSeconds = 0;
bool _isExtraTime = false;
```

**Completion behavior (at 0:00):**
1. Haptic fires (current behavior)
2. Instead of immediate return to deck, show:
   - "You hit your 2 minutes."
   - [Done] button (primary)
   - [Keep going] button (secondary)
3. If "Done": navigate back to deck (current behavior)
4. If "Keep going":
   - Set `_isExtraTime = true`
   - Reset timer to 2:00
   - Start counting again
   - On each subsequent completion, increment `_extraTimeSeconds += 120`
   - Show same [Done] [Keep going] choice
5. Final completion (when user taps Done):
   - If `_extraTimeSeconds > 0`, show: "2 minutes + [formatted extra time]"
   - Store session in database with `extraTimeSeconds`
   - Navigate back to deck

**Session storage:**
- Create row in `sessions` table on timer start
- Update `completedAt` and `extraTimeSeconds` on final "Done"
- If user exits early (back button during pause), set `completedAt = null` (abandoned)

**Display formatting:**
```dart
String formatExtraTime(int seconds) {
  final minutes = seconds ~/ 60;
  final secs = seconds % 60;
  return '$minutes:${secs.toString().padLeft(2, '0')}';
}
```

---

## Implementation Phases

### Phase 5.1 — Core Daily Refresh (No AI)

**Scope:**
- Settings screen with Fresh Start toggle
- Daily rollover logic
- Past Days screen
- Voice input with local transcription (manual card creation)
- Timer "Keep going" enhancement
- Database schema v4 migration

**Explicitly excluded:**
- AI task breakdown
- "I'm stuck — show ideas" button
- "Make this smaller" re-suggestion
- Any OpenAI API calls

**Definition of Done:**
- User can toggle Fresh Start mode on/off
- In Fresh Start mode, deck resets daily and old cards move to Past Days
- Voice input works, transcription appears, user can manually create cards
- Timer "Keep going" works and tracks extra time
- Past Days screen shows archived cards grouped by date
- No regressions to existing persistent deck behavior
- All changes tested on real device

### Phase 5.2 — AI Task Breakdown (Deferred)

**Only start if Phase 5.1 validates user demand.**

**Scope:**
- OpenAI API integration (requires API key, network, privacy policy update)
- "I'm stuck — show ideas" button during card creation
- "Make this smaller" button for breaking down tasks further
- AI-powered suggestions from voice transcription

**Privacy requirements:**
- User opt-in required before any data sent to OpenAI
- Privacy policy update (no longer "no data collected")
- Clear disclosure: "Voice input will be sent to OpenAI for suggestions"
- Settings toggle: "Enable AI suggestions" (default: OFF)

**Deferred rationale:**
- Adds network dependency (breaks offline-first principle)
- Adds recurring cost (OpenAI API usage)
- Increases complexity without validating user need
- Phase 5.1 tests the daily refresh concept independently

---

## Files Changed / Added

### New Files

```
lib/screens/settings/
  └── settings_screen.dart          # Settings screen with Fresh Start toggle

lib/screens/past_days/
  └── past_days_screen.dart          # Archive view for previous days' cards

lib/services/
  └── voice_service.dart             # Speech-to-text wrapper

lib/screens/deck/widgets/
  └── voice_input_sheet.dart         # Bottom sheet for voice planning
```

### Modified Files

```
lib/screens/deck/deck_screen.dart
  - Add gear icon → Settings
  - Add voice button (if Fresh Start enabled)
  - Add "Past days" link (if Fresh Start enabled)
  - Add daily rollover check in lifecycle handler

lib/screens/timer/timer_screen.dart
  - Add "Keep going" button on completion
  - Track extra time
  - Store session data on completion

lib/data/database.dart
  - Schema migration v4 (add archivedDate, sessions table)
  - onUpgrade logic

lib/data/models/
  └── session_model.dart             # New model for sessions table

lib/data/repositories/
  └── session_repository.dart        # CRUD for sessions (if needed; might be overkill for Phase 5.1)

lib/app.dart
  - No changes (navigation stays imperative for now)
```

### New Dependencies

```yaml
dependencies:
  speech_to_text: ^7.0.0           # Local speech recognition (verified pub.dev)
  intl: ^0.20.1                     # Date formatting for Past Days grouping
```

**Note:** Both packages have no platform restrictions and work on iOS + Android.

---

## Migration Strategy

### Database Schema v3 → v4

**Current schema (v3):** Has `cards` table, `schedules` table (from Phase 3)

**New in v4:**
- Add `archivedDate INTEGER` to `cards` table (nullable)
- Create `sessions` table

**Migration SQL:**
```sql
-- Add archivedDate column to existing cards
ALTER TABLE cards ADD COLUMN archivedDate INTEGER;

-- Create sessions table
CREATE TABLE sessions (
  id TEXT PRIMARY KEY,
  cardId TEXT NOT NULL,
  startedAt INTEGER NOT NULL,
  completedAt INTEGER,
  baseDurationSeconds INTEGER NOT NULL,
  extraTimeSeconds INTEGER DEFAULT 0,
  FOREIGN KEY (cardId) REFERENCES cards (id) ON DELETE CASCADE
);

-- Update database version to 4
PRAGMA user_version = 4;
```

**Rollback plan:**
If user toggles Fresh Start OFF and wants to "restore" all archived cards:
- Settings screen: add hidden "Restore all past days" button (developer option)
- Query: `UPDATE cards SET archivedDate = NULL WHERE archivedDate IS NOT NULL`
- Do NOT ship this as user-facing — only for testing/debugging

---

## Open Questions

1. **Voice transcription accuracy:** Does local device transcription work well enough for ADHD users (often fast, scattered speech)? May need fallback to typing.

2. **Sessions table necessity:** Do we actually need to persist sessions in Phase 5.1, or is "keep going" purely a UX enhancement with no data storage? Could defer sessions table to Phase 5.2 if we want to show AI-driven insights later.

3. **Past Days depth limit:** Should we cap Past Days to last 30 days, or keep indefinitely? If indefinite, database could grow large over time.

4. **Fresh Start mode discoverability:** Will users find the Settings screen? Consider one-time tooltip after first week of use: "Want to try Fresh Start mode?" (non-intrusive).

5. **Voice button placement:** Bottom of deck screen vs. floating action button? Test both for accessibility and discoverability.

---

## Success Metrics

**Phase 5.1 adoption:**
- % of users who enable Fresh Start mode within first 7 days
- % of Fresh Start users who use voice input at least once
- % of Fresh Start users who return to Past Days screen
- Average daily cards created (Fresh Start vs. Persistent)

**Engagement:**
- Average "extra time" tracked per session (are users using "Keep going"?)
- Day 7 retention comparison: Fresh Start users vs. Persistent users

**Qualitative:**
- User feedback: does Fresh Start reduce overwhelm?
- Do users report feeling guilt from seeing Past Days? (If yes, revise language/visibility)

---

## Roadmap

→ [Roadmap — Phase 5: Daily Refresh](2026-03-28-roadmap-phase-5-daily-refresh.md)
