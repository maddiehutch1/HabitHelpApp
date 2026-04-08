# Product Requirements Document — Micro-Deck
**Version:** 1.2
**Status:** Active
**Last Updated:** April 2026
**Platform:** Flutter (iOS + Android)
**Scope:** v1 MVP

---

## 1. Product Overview

### 1.1 What Micro-Deck Is

Micro-Deck is a minimalist mobile **initiation tool** — not a habit tracker, not a planner, not a focus timer. It helps users bridge the intention-behavior gap by removing the friction of *starting* a habit, not by measuring, scheduling, or gamifying behavior after the fact.

The core loop:
1. User builds a personal deck of cards, each representing one tiny action tied to a self-defined goal
2. User optionally schedules cards for specific days/times
3. A contextual notification surfaces the card at the right moment
4. User taps the card → full-screen minimal timer begins
5. A haptic pulse signals completion — no animations, no streak counter, no reward screen

### 1.2 The Problem Being Solved

Most people who struggle with habits don't fail because they lack motivation or information. They fail at the **moment of initiation** — the gap between intending to do something and physically starting it. This gap is especially pronounced for people with ADHD, executive dysfunction, or digital burnout.

Existing tools address adjacent problems:
- **Habit trackers** measure behavior after the fact, creating guilt when history shows inconsistency
- **App blockers** restrict access but offer no replacement behavior
- **Focus timers** require already being in motion — they don't help you start
- **Routine planners** add cognitive overhead that defeats the purpose for executive dysfunction users

No widely-used app owns the "initiation" moment. Micro-Deck does.

### 1.3 Product Positioning

> *"We don't police you. We give you a better next move."*

Micro-Deck is the only habit tool built explicitly to help users **start** — not track, not plan, not restrict. Everything that doesn't serve initiation is excluded by design.

**What the app deliberately excludes:**
- Streaks or completion history
- Progress charts or stats
- Social features or sharing
- Gamification (points, badges, rewards)
- Cloud sync or user accounts
- Prescribed habits or coaching content

---

## 2. Target Users

### 2.1 Primary Audience

**People with ADHD or executive dysfunction**
- Struggle with task initiation despite knowing what they want to do
- Often harmed by streak-based guilt mechanics in existing apps
- Need external triggers (notifications) but are burned by notification overload
- 15.5M diagnosed U.S. adults (CDC); hundreds of millions globally including undiagnosed

**People experiencing digital burnout**
- Recognize their phone as a distraction trap
- Actively looking for alternatives to doomscrolling
- Skeptical of apps that use the same engagement mechanics as social media
- Growing segment driven by attention-economy backlash

### 2.2 Secondary Audience

**Productivity minimalists**
- Have tried complex systems (Notion, full routine apps, gamified trackers)
- Found the maintenance overhead defeats the purpose
- Want a tool that does one thing and does it well

### 2.3 Who This Is Not For

- Users who want to track history or measure consistency
- Users who are motivated by streaks and competitive mechanics
- Users seeking a comprehensive daily planner or routine manager
- Android-only users in v1 (iOS first; Android follows same codebase)

### 2.4 User Personas

**Persona 1 — "The Avoider"**
Diagnosed with ADHD. Has downloaded and abandoned 6 habit apps. Knows exactly what they want to do but can't start. Hates seeing red broken streaks. Needs the smallest possible on-ramp.

**Persona 2 — "The Burned Out Professional"**
No clinical diagnosis. Works in a demanding job. Phone is both their tool and their enemy. Has tried blockers (too restrictive) and timers (starts before they can use them). Wants to feel in control of one small thing.

**Persona 3 — "The Returning Beginner"**
Has tried to build habits many times. Motivated in bursts. Needs something forgiving enough to come back to after a week away without feeling ashamed.

---

## 3. Behavioral Science Foundation

The design of Micro-Deck is grounded in established behavior change research. This is embedded in the experience — not marketed as a feature claim.

| Principle | Research Basis | How Micro-Deck Applies It |
|---|---|---|
| **Implementation Intentions** | Gollwitzer (1999) — "if-then" planning significantly improves follow-through | Card scheduling ("When it's 7am Monday, I will put on running shoes") |
| **Minimum Viable Behavior** | BJ Fogg's Tiny Habits — anchor to the smallest possible version of a habit | 2-minute default timer; short enough the brain can't argue |
| **Autonomy Support** | Self-Determination Theory — user-authored goals reduce psychological reactance | User creates all cards; app never assigns tasks |
| **Contextual Cueing** | Habit loop research (Clear, Wood) — environmental cues drive initiation | Scheduled notifications tied to specific cards and times |
| **Completion Signaling** | Operant conditioning — clear, immediate feedback reinforces behavior | Haptic pulse on timer completion |

---

## 4. Core Features — v1 MVP

### 4.1 Onboarding (The First Card)

The onboarding experience IS the first use of the product. The goal: get the user to a completion haptic before they see a settings screen, pricing prompt, or feature explanation.

**Flow:**
```
Screen 0 — Welcome (first launch only)
App name + tagline: "Start the thing you keep putting off."
Sub-line: "One card. Two minutes. That's it."
[Let's begin →]

Screen 1A — Goal
"What feels big and difficult right now?"
[text field — open placeholder: "e.g. Run more often · Sleep better · Write regularly"]
[Next →]

Screen 1B — Action (goal shown faintly above as context)
"What's one tiny step you could take first?"
[text field — verb-first placeholder: "e.g. Put on my running shoes"]
AI affordances: "I'm stuck – show ideas" / "Make this smaller"
[Let's go →]

Screen 2 — Confirmation
"Ready for your tiny start?"
User's typed action label shown back to them
[Start now]   [Save for later]

Screen 3 — Timer
Full screen, dark background, pulsing dot, countdown
No UI chrome. No back button during active session.

Completion — Haptic + one line
"That's it. You started."
[soft explainer: what just happened and why it works — skippable, post-MVP]
```

**Why two onboarding questions (not one):**
Separating goal from action mirrors implementation intention research (Gollwitzer 1999) — the goal→action link is made explicit and visible. The user sees their goal faintly above the action field on Screen 1B, reinforcing that the tiny action *serves* something they care about. This is more effective than a single "what do you want to do?" prompt.

**Onboarding rules:**
- No account creation
- No notification permission prompt during onboarding (ask after first win)
- No feature tour or walkthrough
- If user taps "Save for later," card is created and they land on the deck view

### 4.2 The Deck

The primary view of the app. A vertical stack of user-created cards.

**Card anatomy:**
- Action label (verb-first, e.g., "Put on running shoes")
- Optional goal context shown faintly below (e.g., "Run 3x/week") — private, never tracked
- Duration badge (default: 2 min, adjustable 1–10 min per card)
- Optional schedule indicator (e.g., "Mon · Wed · Fri")

**Deck interactions:**
- **Tap card** → opens card detail bottom sheet (Start / What's next / Edit / Complete)
- **Swipe right** → complete card (triggers completion celebration flow)
- **"Continue →" nudge** — cards with recent goal activity show a tap target to jump straight to the next-step flow

**Deck rules:**
- No card limit — freemium/IAP layer removed (deferred to a future evidence-first phase)
- Cards are ordered by creation time
- Fresh Start mode: optional daily rollover archives active cards each new day

### 4.3 Card Creation

**Entry points:**
- FAB on deck opens a method sheet: **Voice** or **Type it**
- Voice path: records up to 30s → AI extracts up to 3 task titles → `VoiceAISuggestionsScreen` → each selected task routes through the creation flow
- Type it path: goes directly to `CreateCardGoalScreen`

**Creation flow (unified for onboarding and ongoing use):**
```
1. "What feels big and difficult right now?" (goal — required)
   Optional: prefilled from voice transcription or AI suggestion

2. "What's one tiny step you could take first?" (action — required)
   AI buttons: "I'm stuck – show ideas" (2–3 AI chips) / "Make this smaller" (1 chip)
   Both require prior AI consent and respect the Settings toggle

3. "Ready for your tiny start?"
   [Start now] → Timer   [Save for later] → Deck
```

**Starter templates:** removed in Phase 6. AI suggestions ("I'm stuck") serve the blank-page friction problem instead.

### 4.4 The Timer (Silent Pulse)

The core ritual experience.

**Timer screen:**
- Full-screen dark background
- Large, clean countdown (MM:SS)
- Subtle pulsing ambient dot — calm, not urgent
- No other UI elements during session
- Screen stays on (idle timer disabled for duration)
- No back gesture during active session (prevents accidental exits)
- Pause is allowed — tap anywhere to pause, tap again to resume

**Completion:**
- Haptic pulse fires at zero (medium impact, single beat — not a buzz)
- Full-screen celebration with subtle confetti (10 particles, minimalist pop), randomized warm headline from a rotating phrase list, and focus-time summary
- Primary action: "Do next task" / "Plan my next step →" (if card has a goal) routes to `NextStepScreen` for continuation
- Secondary action: "Go back to home" returns to deck
- No streak update, no score — intentional

**Continuation flow (momentum capture):**
- After completing a timer, user is prompted to define the next tiny step for the same goal
- `NextStepScreen` shows goal context, action input with AI assistance, and a Start button that creates a new card and immediately starts a timer
- This creates a natural loop: complete → celebrate → next step → timer → complete

**Abandoned session:**
- If user exits early (via back button after pause), card returns to deck without judgment
- No "you quit" language anywhere

### 4.5 Card Scheduling & Notifications (Pro)

**Scheduling:**
- Per-card, optional: specific days of the week + time
- One-time or recurring
- Multiple schedules per card not supported in v1

**Notification behavior:**
- Notification copy: card action label + duration (e.g., "Put on running shoes · 2 min")
- Tapping notification opens app directly to that card's timer screen
- One notification per scheduled card instance — no follow-up nags
- Notification permission is requested after first card completion, not during onboarding

**iOS 64-notification limit — queue architecture:**
- All schedules stored locally in the database
- On each app open: flush expired scheduled notifications, compute next N upcoming, register only those
- Graceful degradation: if user has denied notifications, deck still functions fully — scheduling is visible on cards but doesn't fire

### 4.6 Card Archiving & Completion

**Completion:** User completes a card via swipe-to-complete on the deck or the Complete action in the card detail sheet. Completed cards move to the "Completed" section in Past Days and can be restored via long-press.

**Daily archiving (Fresh Start mode):** When enabled, active cards are automatically archived at the start of each new day. Archived cards are grouped by date in the Past Days screen and can be restored to the active deck via long-press → "Move to today."

**Past Days screen:**
- "Completed" section at top for finished goals
- Date-grouped archived cards below ("Yesterday", "Mar 26", etc.)
- Both completed and archived cards are fully restorable at any time
- No shame data — no failure language anywhere

### 4.7 Monetization — Deferred

Freemium / IAP layer was removed in February 2026 (before sufficient user evidence existed to validate pricing and Pro feature value). All features are freely accessible in the current build. Monetization is a hypothesis to revisit post-launch with real retention and engagement data.

---

## 5. Technical Requirements

### 5.1 Platform & Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Target platforms | iOS (primary), Android (same codebase) |
| Minimum iOS version | iOS 16+ |
| Minimum Android version | Android 8.0 (API 26)+ |
| Local storage | `sqflite` (direct SQLite; migrations via `onUpgrade`) |
| Notifications | `flutter_local_notifications` |
| Haptics | Flutter SDK built-in (`HapticFeedback.mediumImpact()`) |
| State management | Riverpod |
| Build pipeline (iOS) | Codemagic CI/CD |

### 5.2 Data Architecture

All data is stored locally on-device. No backend. No user account. No telemetry.

**Core data models:**

```
Goal
  id: UUID
  label: String
  createdAt: DateTime

Card
  id: UUID
  goalId: UUID (nullable — card can exist without a goal)
  actionLabel: String
  durationSeconds: Int (default: 120)
  sortOrder: Int
  isArchived: Bool
  createdAt: DateTime

Schedule (Pro)
  id: UUID
  cardId: UUID
  weekdays: [Int] (0=Sun ... 6=Sat)
  timeOfDay: TimeOfDay
  isRecurring: Bool
  isActive: Bool

Session
  id: UUID
  cardId: UUID
  startedAt: DateTime
  completedAt: DateTime (nullable — null = abandoned)
  durationSeconds: Int
```

**Note on sessions:** session data is stored for local notification rescheduling logic and for the archiving prompt trigger (counting recent deferrals). It is never surfaced to the user as history or performance data.

### 5.3 Notification Queue Architecture

To work within the iOS 64-notification limit:

1. All schedules stored in `Schedule` table
2. On every app open (and `AppLifecycleState.resumed`): cancel all pending notifications, compute next 40 upcoming instances across all active schedules, register those
3. On schedule create/edit/delete: trigger immediate recompute
4. If notifications denied: schedules remain stored, cards show schedule indicator, no notifications fire — app remains fully functional

### 5.4 Offline & Privacy Requirements

- Network requests limited to OpenAI API calls from `ai_service.dart` — only when the user has explicitly granted AI consent (`aiSuggestionsEnabled` pref). All other data is local-only.
- No analytics SDK
- No crash reporting SDK that phones home (use Flutter's built-in error handling with local logging only)
- No third-party SDKs beyond package dependencies
- API key loaded via `--dart-define` / `.env.json` (gitignored); never committed to the repo

### 5.5 Performance Requirements

- App cold launch to deck visible: < 1.5 seconds
- Card tap to timer screen: < 200ms (no loading state)
- Timer accuracy: ± 1 second over a 10-minute session
- Haptic fires within 100ms of timer reaching zero

---

## 6. Design Principles

These are not aesthetic guidelines — they are decision filters. When a design or feature choice is uncertain, run it through these.

1. **Does this help the user start something?** If no, it doesn't belong in the app.
2. **Does this add cognitive load?** If yes, simplify or cut it.
3. **Could this make a user feel shame?** If yes, rewrite the copy or remove the mechanic.
4. **Does this require a network connection?** If yes, find a local-only solution or cut it.
5. **Does this make the timer experience more reliable?** Prioritize this above feature additions.

**Visual language:**
- Dark, calm palette — not sterile, not playful
- Large, readable typography — accessibility is a baseline, not a feature
- Minimal chrome: no tab bars during active sessions, no persistent navigation during timer
- Motion: purposeful and slow — no snappy animations, no bounces; subtle confetti on goal completion (minimalist, 10 particles)

---

## 7. Success Metrics

These metrics exist for internal product validation, not user-facing tracking.

### 7.1 Quantitative Metrics

| Metric | Target | Why It Matters |
|---|---|---|
| **Activation rate** | ≥ 60% of installs complete 1 card in session 1 | Core validation gate — product wins or loses here |
| **Time-to-first-completion** | Cold launch → haptic in < 90 seconds | Validates onboarding friction is low enough to not lose users before the first win |
| **Day 7 retention** | ≥ 25% of activated users return on day 7 | Validates retention without streaks — the hardest metric to hit without conventional retention levers |
| **Session abandon rate** | ≤ 20% of started timers | High abandon = timer UX or duration issue |
| **Weekly initiation frequency** | Users report app helped them start a difficult task on ≥ 3 days/week | Measures whether the app generalizes beyond novelty into regular stuck moments |
| **Repeated card use quality** | ≥ 40% of returning users create a second card within 7 days | New card creation signals the habit of breaking down tasks is generalizing; single-card reuse and churn are tracked separately as distinct outcomes |
| **Notification opt-in rate** | ≥ 40% (asked post-first-win) | Timing of ask matters — this validates placement |
| **Pro conversion rate** | ≥ 8% of activated users | Validates freemium model and paywall placement |
| **Archiving prompt acceptance** | ≥ 30% choose "Rest it" | Validates compassionate archiving language |

### 7.2 Qualitative & Behavioral Metrics

*Measured via pre/post survey in user research sessions. All items use a 1–7 Likert scale unless noted.*

| Metric | Measurement Method | Why It Matters |
|---|---|---|
| **Task initiation success** | Pre-session: user rates target task difficulty (1–7). Post-session: did they start it? | Core validation — confirms the app helps with genuinely hard-to-start tasks, not easy ones |
| **Overwhelm reduction** | Pre/post: "How overwhelmed do you feel when trying to start a task you've been putting off?" | Primary pain point for the target audience; reduction validates the product is addressing the real problem |
| **Guilt and shame reduction** | Pre/post: "When you don't start a goal, how much shame do you feel?" | Directly tests whether the no-judgment design philosophy is felt by users; one of the strongest differentiators from competitor tools |
| **Perceived initiation self-efficacy** | Pre/post: "How much control do you feel over your ability to start tasks you want to do?" | More sensitive than broad locus of control; tracks whether the product shifts felt agency around initiation |
| **Emotional response at haptic completion** | Post-session open prompt: "How did you feel when the timer ended?" | The haptic moment is the product's core ritual — relief, calm, or surprise at simplicity are the target responses; absence of these is a product signal |
| **Differentiation perception** | Post-session: "How different does this feel from other habit or productivity apps you've tried? (1–7)" | Existential signal — if users score below 5, the product is not landing its positioning regardless of other metrics |

---

## 7.3 Failure Indicators

*These signal that the product is not achieving its purpose. Each has a defined measurement approach.*

| Indicator | How to Detect | What It Means |
|---|---|---|
| **"Feels like any other tool"** | Differentiation perception score < 5/7 in post-session survey | Product is not landing its core positioning; a design or framing problem, not a marketing one |
| **No reduction in overwhelm** | Pre/post overwhelm scores unchanged or worsened after using the app | The initiation mechanic is not reducing the friction it is designed to address |
| **Default back to other tools** | Follow-up question: "When you were stuck this week, what did you reach for first?" — answer is not Micro-Deck | App is not becoming the reflexive response to stuck moments; may indicate insufficient habit formation or weak notification hook |
| **Download but inactive** | Users install, open once, and do not return within 7 days without re-engagement | App is not producing felt relief strong enough to create a return reason; activation experience needs investigation |
| **"Too simple to pay for"** | Post-session: "What would you expect to pay for something like this?" returns $0 or "nothing" | Perceived value ceiling is below the Pro price point; free tier may be too complete or Pro features not meaningful enough |

---

## 8. Competitive Landscape Summary

*Informed by market research — see `ai/guides/habit-help-market-research.md`*

| Competitor | Category | Why Users Leave | Micro-Deck's Contrast |
|---|---|---|---|
| Opal ($19.99/mo) | App blocker | Unreliable blocking, cluttered UI | Replaces the moment vs. policing it |
| Freedom ($99.50 lifetime) | App blocker | Bypass workarounds, support friction | Alternative behavior vs. restriction |
| one sec ($2.99/mo) | Friction tool | Setup friction, annoying by design | Increases good starts vs. reducing bad opens |
| Forest (paid) | Focus timer | Gamification fatigue, feature bloat | 2-min initiation vs. 25-min sessions |
| Tiimo / Routinery | Routine planner | "Too much system upkeep" | Initiation-only vs. full day management |
| Streaks / Habitify | Habit tracker | Streak guilt, shame on bad days | No history vs. performance measurement |

**The white space Micro-Deck owns:**
No major app currently positions itself as an *initiation ritual* — calm, autonomous, guilt-free, and built specifically for the stuck moment. This is the position to hold and defend.

---

## 9. Out of Scope for v1

The following are explicitly excluded from v1 to maintain product focus:

| Feature | Rationale |
|---|---|
| Apple Watch companion | Requires Swift/Xcode; deferred to v2 |
| Android-specific optimizations | Same codebase ships; no platform-specific work |
| Cloud sync / iCloud backup | Undermines no-account value prop; deferred |
| Social sharing | Contradicts privacy-first philosophy |
| Habit history / analytics views | Core philosophy: no history shown to user |
| Multiple notification times per card | Adds scheduling complexity; one time per card in v1 |
| Widget support | Deferred to v2 |
| Siri / Shortcuts integration | Deferred to v2 |
| Freemium / IAP | Removed — insufficient evidence to validate pricing; revisit post-launch |
| App Store / Play Store submission | Deferred until post-demo feedback gathered |

---

## 10. Open Questions

These require user research or early testing to resolve before implementation:

1. **Default timer duration:** Is 2 minutes the right default for onboarding, or should the first card use a 1-minute default to lower the bar further?
2. **Notification copy:** Does using the card's action label verbatim in the notification feel personal or robotic? Needs copy testing.
3. **Continuation flow adoption:** Do users naturally engage with the "Plan my next step" prompt after completion, or does it feel like pressure? Early user testing suggests positive reception but needs broader validation.

**Resolved since v1.1:**
- Deferral-based archive prompt removed (Phase 8) — replaced by explicit user-initiated completion and Fresh Start daily rollover
- "Just One" mode removed (Phase 12) — low discoverability confirmed; card detail sheet provides sufficient focus
- Free tier card limit and Pro paywall removed (Feb 2026) — monetization deferred to evidence-first phase

