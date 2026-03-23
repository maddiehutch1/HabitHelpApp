# Phase 1 — MVP Demo
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Previous: [Phase 0 — Foundation](2026-02-19-phase-0-foundation.md)*
*Next: [Phase 2 — Polish & Stability](2026-02-19-phase-2-polish.md)*
*Status: Complete — Feb 21, 2026*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Build only what the demo loop requires. No base classes, no generics, no "we might need this later." If a widget is only used once, it lives in the screen file. Extract only when there is a real reason.

---

## Goal
A working Flutter app that demonstrates the full Micro-Deck demo loop end-to-end on a real device. The loop: **Welcome → Goal → Action → Confirm → Timer → Haptic → Deck.**

---

## Demo Loop (Reference)
```
Cold launch
    ↓
Welcome screen (first launch only)
    ↓
Onboarding 1A — Goal input
    ↓
Onboarding 1B — Action input (goal shown as context)
    ↓
Onboarding Confirm — [Start now] / [Save for later]
    ↓
Timer screen — countdown + pulsing dot + wakelock
    ↓
Haptic pulse on completion → "That's it."
    ↓
Deck screen — card visible, tap to repeat loop
```

---

## Plan

### Step 1 — Data Layer
Build before any screens. Screens depend on this.

**CardModel** (`lib/data/models/card_model.dart`)
- [x] Define `CardModel` with fields: `id`, `goalLabel` (nullable), `actionLabel`, `durationSeconds` (default 120), `sortOrder`, `createdAt` (int, millisecondsSinceEpoch)
- [x] Add `toMap()` and `fromMap()` methods
- [x] No nullable DateTime — store all timestamps as int

**Database** (`lib/data/database.dart`)
- [x] Open sqflite database at `getDatabasesPath()` + `join(path, 'microdeck.db')`
- [x] `onCreate`: create `cards` table matching `CardModel` fields
- [x] Expose singleton `Database` instance
- [x] No migration logic needed in MVP (version 1 only)

**CardRepository** (`lib/data/repositories/card_repository.dart`)
- [x] `insertCard(CardModel)` → `db.insert`
- [x] `getAllCards()` → `db.query`, ordered by `sortOrder ASC, createdAt ASC`
- [x] `deleteCard(String id)` → `db.delete`
- [x] Keep it flat — no interfaces, no abstract classes

**OnboardingFlag** (inline in routing, or a tiny helper)
- [x] Use `SharedPreferencesAsync` to read/write `hasCompletedOnboarding` (bool)
- [x] Read on app launch to determine initial route

### Step 2 — State Management
**CardsNotifier + Provider** (`lib/providers/cards_provider.dart`)
- [x] `CardsNotifier extends Notifier<List<CardModel>>`
- [x] `build()` returns empty list (load triggered separately)
- [x] `loadCards()` — calls repository, updates state
- [x] `addCard(CardModel)` — inserts, reloads
- [x] `deleteCard(String id)` — deletes, reloads
- [x] `final cardsProvider = NotifierProvider<CardsNotifier, List<CardModel>>(CardsNotifier.new)`

### Step 3 — Routing & App Shell
**main.dart**
- [x] `WidgetsFlutterBinding.ensureInitialized()`
- [x] `runApp(const ProviderScope(child: MicroDeckApp()))`

**app.dart**
- [x] Read `hasCompletedOnboarding` from shared_preferences
- [x] If false → initial route is `WelcomeScreen`
- [x] If true → initial route is `DeckScreen`
- [x] Dark theme applied at `MaterialApp` level (basic — full theming is Phase 2)
- [x] Navigator 1.0 — no named routes, no go_router

### Step 4 — Welcome Screen (`lib/screens/welcome/welcome_screen.dart`)
- [x] Full screen, dark background
- [x] App name: "Micro-Deck" — large, centered
- [x] Tagline: "Start the thing you keep putting off."
- [x] Sub-line: "One card. Two minutes. That's it."
- [x] Single button: [Let's begin →]
- [x] On tap → push `OnboardingGoalScreen`
- [x] Only shown when `hasCompletedOnboarding == false`

### Step 5 — Onboarding 1A: Goal Screen (`lib/screens/onboarding/onboarding_goal_screen.dart`)
- [x] Full screen, dark background
- [x] Prompt: "What do you want to work toward?"
- [x] Sub-copy: "A goal, an area of life, anything you want more of."
- [x] Text field — auto-focus on load, open placeholder: "e.g. Run more often · Sleep better"
- [x] [Next →] button — disabled until field has text
- [x] On tap → push `OnboardingActionScreen`, passing goal string

### Step 6 — Onboarding 1B: Action Screen (`lib/screens/onboarding/onboarding_action_screen.dart`)
- [x] Receives goal string from 1A
- [x] Full screen, dark background
- [x] Goal shown at top — smaller, muted (context, not focus)
- [x] Prompt: "What's one tiny thing that starts it?"
- [x] Sub-copy: "Start with a verb. Make it small enough to do right now."
- [x] Text field — auto-focus, verb-first placeholder: "e.g. Put on my running shoes"
- [x] [Let's go →] button — disabled until field has text
- [x] Back arrow → returns to 1A
- [x] On tap → push `OnboardingConfirmScreen`, passing goal + action

### Step 7 — Onboarding Confirm Screen (`lib/screens/onboarding/onboarding_confirm_screen.dart`)
- [x] Receives goal + action from 1B
- [x] Full screen, dark background
- [x] Copy: "Good. Let's do two minutes of it right now."
- [x] User's action label shown back to them
- [x] [Start now] → create card, set `hasCompletedOnboarding = true`, push `TimerScreen`
- [x] [Save for later] → create card, set `hasCompletedOnboarding = true`, push `DeckScreen`
- [x] Card created with: `id = timestamp string`, `goalLabel = goal`, `actionLabel = action`, `durationSeconds = 120`, `sortOrder = 0`, `createdAt = now`

### Step 8 — Timer Screen (`lib/screens/timer/timer_screen.dart`)
- [x] Receives `CardModel` — works for both onboarding and deck taps
- [x] Full screen, dark background
- [x] User's action label shown faintly above countdown
- [x] Large centered countdown: `MM:SS`
- [x] Pulsing dot below countdown — slow opacity animation (basic for now, refined in Phase 2)
- [x] `WakelockPlus.enable()` in `initState`
- [x] `WakelockPlus.disable()` in `dispose`
- [x] `Timer.periodic` for countdown (1-second tick)
- [x] Tap anywhere to pause/resume
- [x] When paused: faint [End session] button appears
- [x] At 0:00: `HapticFeedback.mediumImpact()`, show completion word ("That's it."), wait 2 seconds, pop to `DeckScreen`
- [x] Back gesture disabled during active timer (intercepted with `PopScope`)
- [x] If [End session] tapped: stop timer, pop to `DeckScreen` — no guilt copy

### Step 9 — Deck Screen (`lib/screens/deck/deck_screen.dart`)
- [x] `ConsumerWidget` — watches `cardsProvider`
- [x] `ref.read(cardsProvider.notifier).loadCards()` in `initState`
- [x] Card list — `ListView.builder`
- [x] Each card tile: action label (large), goal label below (small, muted), "2 min" badge
- [x] Tap card → push `TimerScreen` with that card
- [x] [+] FAB → show bottom sheet for adding a card
- [x] Add card sheet: goal field (optional, pre-fills from first card's goal), action field (required), [Save] button
- [x] Empty state: "Add your first card to get started." with [+] button

### Step 10 — Integration & Device Test
- [ ] Full demo loop works cold-to-haptic without crashes
- [ ] Cards persist after app restart
- [ ] "Save for later" path works
- [ ] Adding second card from deck works
- [ ] Back navigation doesn't break any screen
- [ ] Test on Android emulator
- [ ] Test on real Android device (if available)
- [ ] Test on iOS via Codemagic build + TestFlight (or simulator if Mac available)

---

## Roadmap

→ [Roadmap — Phase 1: MVP Demo](2026-02-19-roadmap-phase-1-mvp-demo.md)

---

## Definition of Done
- User completes full loop cold-to-haptic in under 90 seconds on a real device without crashes
- Loop is repeatable (cards stay in deck, can tap again)
- Cards persist across app restarts
- "Save for later" path works
- Adding a card from the deck works
- No crashes on any step of the demo path

## Next Phase
→ [Phase 2 — Polish & Stability](2026-02-19-phase-2-polish.md)
