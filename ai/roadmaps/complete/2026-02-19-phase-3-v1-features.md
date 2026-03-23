# Phase 3 — v1 Feature Build
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Previous: [Phase 2 — Polish & Stability](2026-02-19-phase-2-polish.md)*
*Next: [Phase 4 — App Store Submission](2026-02-19-phase-4-app-store.md)*
*Status: ✅ Complete — all code complete Feb 21, 2026; tested and confirmed Feb 23, 2026. Platform setup (IAP product ID, notification icon) required before M3.7/M3.8 submission steps.*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Each feature here is added to the existing clean codebase — not rebuilt around it. Add schema migrations only when the feature requires a new field. Don't abstract things that aren't shared. Notifications are the most complex item — build them last.

---

## Goal
Ship a complete v1 product beyond the demo scope. All features listed in the PRD for v1 are implemented, tested, and stable.

---

## Plan

### Feature 1 — Adjustable Timer Duration
- [x] Add duration slider to card creation sheet (1–10 minutes, step 1 min)
- [x] Default: 2 minutes (120 seconds)
- [x] Update `CardModel` display to show actual duration badge (not hardcoded "2 min")
- [x] Timer screen uses `card.durationSeconds` — already wired in Phase 1
- [x] No schema migration needed — `durationSeconds` already in MVP schema

### Feature 2 — Goal Field on Cards
- [x] Goal field: required during onboarding (already implemented), optional when adding from deck
- [x] Deck card tile: shows `goalLabel` as muted sub-text below action label (already in Phase 1 layout — confirm it shows when populated)
- [x] Add card sheet: goal field pre-fills from last-used goal (read from most recent card in db)
- [x] No separate goals table in v1 — goal is a plain text field on each card (per architecture doc)

### Feature 3 — Swipe-to-Defer
- [x] Swipe left on a deck card → moves card to bottom of deck (updates `sortOrder`)
- [x] No animation library — use `Dismissible` widget with `direction: DismissDirection.endToStart`
- [x] On dismiss: update `sortOrder` to `max(existing sortOrders) + 1` in database, reload
- [x] No confirmation prompt — deferral is silent and instant
- [x] Track defer count per card per week (needed for Feature 5 archiving prompt):
  - [x] Add `deferrals` table: `cardId TEXT, deferredAt INTEGER`
  - [x] Insert a row on each swipe-left
  - [x] Count rows for a card in the past 7 days

### Feature 4 — "Just One" Mode
- [x] Entry: pull-down gesture on deck, or a quiet icon button in deck header
- [x] Shows only the top card (index 0 of sorted deck), centered on screen
- [x] All other cards hidden
- [x] Two options: [Start] (push timer) or [Not today] (defer silently, show next card)
- [x] Mode persists until user dismisses (tap outside card or swipe up)
- [x] No separate route — overlay or modal on `DeckScreen`

### Feature 5 — Card Archiving / Dormant Deck
- [x] Trigger: if a card has 3+ deferrals in the past 7 days, show gentle prompt on next deck load
- [x] Prompt copy: "You've set this one aside a few times. Want to rest it for now?"
- [x] Options: [Rest it] → archive, [Keep it] → dismiss prompt for 7 days
- [x] Archive: add `isArchived INTEGER NOT NULL DEFAULT 0` to cards table (schema migration v2)
- [x] `getAllCards()` query filters `WHERE isArchived = 0`
- [x] Dormant Deck: accessible via a quiet "Resting" section — separate filtered query
- [x] Restore: un-archive sets `isArchived = 0`, card returns to deck at bottom
- [x] No archived timestamps shown — no shame data surfaced

### Feature 6 — Starter Card Templates
- [x] Define ~20 template cards as a static Dart list (not a database table)
- [x] Organized by area: movement, focus, connection, rest
- [x] Templates browsable in a bottom sheet from the [+] button
- [x] User taps a template → pre-fills add card sheet (still editable before saving)
- [x] Templates are never saved to the database — only the user-personalized version is

### Feature 7 — Freemium Gating
- [x] Free tier: 1 goal context, up to 5 cards maximum
- [x] Pro tier: unlimited cards, scheduling, Dormant Deck
- [x] Gate check: when user tries to add a 6th card → show paywall
- [x] Paywall copy: "Unlock the full deck. No subscription. No account. Yours forever."
- [x] Paywall shown after first successful card completion — never during onboarding
- [x] Implementation: In-App Purchase via `in_app_purchase` package (add to pubspec when building this feature)
- [x] Price: $4.99–$6.99 one-time (confirm in App Store Connect)
- [x] Store Pro status in `shared_preferences` after verified purchase
- [x] No receipt validation server — use StoreKit/Google Play receipt locally (sufficient for one-time IAP)

### Feature 8 — Scheduled Notifications
*Most complex feature — build last in Phase 3.*

**Schema additions (migration v3):**
- [x] Add `schedules` table: `id TEXT, cardId TEXT, weekdays TEXT (JSON int array), timeOfDayMinutes INTEGER, isRecurring INTEGER, isActive INTEGER`

**Notification queue architecture (iOS 64-limit):**
- [x] Add `flutter_local_notifications` to pubspec
- [x] Request notification permission after first card completion (not during onboarding)
- [x] Store all schedules in `schedules` table
- [x] On every app open (`AppLifecycleState.resumed`): cancel all pending, compute next 40 upcoming instances, register those
- [x] On schedule create/edit/delete: trigger immediate recompute
- [x] Graceful degradation: if notifications denied, schedule is visible on card but doesn't fire — deck fully usable

**Scheduling UI (Pro only):**
- [x] Add schedule section to card edit/create sheet
- [x] Day picker (multi-select: S M T W T F S)
- [x] Time picker (system time picker)
- [x] One schedule per card in v1 (no multiple times per card)
- [x] Notification copy: `"{actionLabel} · {duration} min"`
- [x] Tapping notification opens app directly to timer for that card

### Feature 9 — Post-Completion Onboarding Explainer
- [x] Shown once after the very first card completion — never again
- [x] Skippable (tap anywhere or [Got it] button)
- [x] One or two sentences explaining what just happened and why it works
- [x] Controlled by `hasSeenExplainer` boolean in `shared_preferences`

### Feature 10 — Settings Screen
- [x] Accessible via a quiet icon in the deck screen header
- [x] Contents: card management only (view all cards including archived, delete permanently)
- [x] No account settings, no sync settings, no notification master toggle (per-card scheduling handles that)
- [x] Minimal — this is not a feature destination, it's housekeeping

---

## Schema Migration Plan

| Version | Change | Triggered by |
|---|---|---|
| v1 (MVP) | `cards` table baseline | Phase 1 |
| v2 | Add `isArchived` to cards, add `deferrals` table | Feature 3 + 5 |
| v3 | Add `schedules` table | Feature 8 |

Each version increment uses sqflite's `onUpgrade` handler.

---

## Definition of Done
- [x] All 10 features implemented and working on iOS and Android
- [x] Schema migrations run cleanly on a database that started at v1
- [x] Notifications queue correctly and degrade gracefully when denied
- [x] Freemium gate enforces 5-card limit; Pro unlocks fully
- [x] No features from the PRD out-of-scope list are included

## Next Phase
→ [Phase 4 — App Store Submission](2026-02-19-phase-4-app-store.md)
