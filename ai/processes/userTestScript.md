# MicroDeck — Agent UX Review Process

*Read this document fully before taking any action. Then follow the steps in order.*

---

## What This Document Is

This is an executable process for AI agents. It produces a simulated UX review of the MicroDeck app across 9 personas. You will run persona simulations serially, producing a structured review report per persona. After all 9 are complete, the UX designer persona synthesizes a professional recommendation document.

**Personas live in:** `aiDocs/userResearch/persona1.md` through `persona9.md`
**Falsification tests live in:** `aiDocs/userResearch/userTestScript.md`
**All reports save to:** `ai/processes/uxReview/personaReports/` (create this directory if it does not exist)

---

## Before You Begin

1. Read all 9 persona files in `aiDocs/userResearch/`
2. Read the falsification tests section of `aiDocs/userResearch/userTestScript.md`
3. Note today's date in `YYYY-MM-DD` format — use it as the `<date>` prefix in all output filenames
4. Create `ai/processes/uxReview/personaReports/` if it does not exist

---

## Execution Order

Run simulations one at a time, in this exact order. Save each report before beginning the next.

| Step | Persona | Output filename |
|---|---|---|
| 1 | Jordan — High-Functioning Avoider (persona1) | `<date>_report_jordan.md` |
| 2 | Mara — Overwhelmed Starter (persona2) | `<date>_report_mara.md` |
| 3 | Dani — Crisis Mode User (persona3) | `<date>_report_dani.md` |
| 4 | Sam — Burnout Professional (persona4) | `<date>_report_sam.md` |
| 5 | Alex — UX Designer (persona5) | `<date>_report_alex.md` |
| 6 | Priya — Product Manager (persona6) | `<date>_report_priya.md` |
| 7 | Marcus — Investor (persona7) | `<date>_report_marcus.md` |
| 8 | Zoe — Teenager (persona8) | `<date>_report_zoe.md` |
| 9 | Eli — College Student (persona9) | `<date>_report_eli.md` |
| 10 | Final synthesis by Alex | `<date>_finalUxReviewReport.md` |

---

## Instructions for Each Persona Sub-Agent

### Step 1 — Load and Embody the Persona

Read the relevant `aiDocs/userResearch/persona[N].md` file. You are now that person. Your commentary must be written from inside their experience — their vocabulary, their emotional register, their relationship to productivity and digital tools. Do not produce generic UX feedback. Produce the reaction this specific person would have.

Stay in character throughout. When something delights them, let it show. When something frustrates them, name the frustration specifically. When they would give up, say so.

### Step 2 — Simulate the Pre-Session Context Questions

Before walking through the app, answer these three questions as the persona. Write the answers in the report. They ground the session in a real situation for this person.

1. What is a recent task you wanted to start but did not?
2. What made it hard to begin?
3. What do you usually do in that situation?

Transition note (write this in the report): *"Okay — keep that in mind. Now you open MicroDeck."*

### Step 3 — Walk Through Each Screen

Using the **App Screen Reference** below, walk through the screens in first-encounter order:

**Primary path (all personas):**
Welcome → CreateCardGoalScreen → CreateCardActionScreen → CreateCardConfirmScreen → Timer (Running) → Timer (Complete + Explainer) → Deck View

**Secondary paths (simulate based on what this persona would plausibly do):**
- Add Method Sheet — all personas encounter this when returning to add a second card
- VoiceAISuggestionsScreen — simulate for Dani (persona3), Zoe (persona8), Eli (persona9), and any other persona who would plausibly use voice
- Settings — simulate for all personas at some point during the session
- Just One Mode — simulate for Jordan (persona1), Sam (persona4), Priya (persona6), Marcus (persona7)
- Archive Prompt — simulate for any persona who has deferred a card multiple times

For each screen, produce commentary across the **Review Dimensions** listed below. Write as if the persona is thinking out loud. Not every dimension will have something to say for every screen — skip dimensions where the reaction is neutral and unremarkable. Do not skip a dimension simply because the reaction would be positive.

### Step 4 — Answer Post-Session Questions

After the screen walk-through, answer all 9 post-session questions in character.

### Step 5 — Score Falsification Tests

For each of the 10 falsification tests (F1–F10), mark the result as:
- **PASS** — no evidence this failure mode was triggered for this persona
- **FLAG** — this persona's experience suggests the failure mode is real; briefly state the evidence
- **N/A** — not applicable to this persona; explain why

### Step 6 — Save the Report

Write the completed report to `ai/processes/uxReview/personaReports/<date>_report_<personaFirstName>.md` using the **Persona Report Template** at the end of this document.

---

## App Screen Reference

These are structured text representations of every screen in the app, derived directly from the Flutter source code. Use these as the ground truth for what the app looks like, what copy it contains, and how interactions work. Do not invent features or copy that are not shown here.

---

### SCREEN 1 — Welcome Screen
*Shown on first launch only. Not shown on subsequent opens.*

```
┌───────────────────────────────────────┐
│                                       │
│   (spacer — top third of screen)      │
│                                       │
│   Micro-Deck                          │  ← App name, large
│                                       │
│   Start the thing you keep            │
│   putting off.                        │  ← Body text
│                                       │
│   One card. Two minutes. That's it.   │  ← Muted body text
│                                       │
│   (spacer — fills remaining space)    │
│                                       │
│   ┌───────────────────────────────┐  │
│   │        Let's begin →          │  │  ← Full-width filled button
│   └───────────────────────────────┘  │
│                                       │
└───────────────────────────────────────┘
```

**Interactions:** [Let's begin →] navigates to CreateCardGoalScreen.
**No back button. No navigation bar. No other elements.**
**Visual character:** White/light background, minimal whitespace-heavy layout.

---

### SCREEN 2 — CreateCardGoalScreen
*"What feels big and difficult right now?"*

```
┌───────────────────────────────────────┐
│  ←  (back icon, muted)                │  ← Back button, top-left
│                                       │
│   What feels big and difficult        │
│   right now?                          │  ← Headline
│                                       │
│   ┌───────────────────────────────┐  │
│   │  e.g. Write my 15-page        │  │  ← Text field, autofocus on arrive
│   │  research paper               │  │    18px text, placeholder shown until typed
│   └───────────────────────────────┘  │
│                                       │
│   (keyboard fills bottom of screen)   │
│                                       │
│   ┌───────────────────────────────┐  │
│   │            Next →             │  │  ← Full-width filled button
│   └───────────────────────────────┘  │    Disabled (greyed) until text is entered
└───────────────────────────────────────┘
```

**Interactions:** Typing activates [Next →]. Keyboard submit or [Next →] advances to Screen 3.
**No other actions on this screen.**

---

### SCREEN 3 — CreateCardActionScreen
*"What's one tiny step you could take first?"*

```
┌───────────────────────────────────────┐
│  ←  (back icon, muted)                │
│                                       │
│   [goal text the user just typed]     │  ← Context label: small, muted, max 2 lines
│                                       │
│   What's one tiny step you could      │
│   take first?                         │  ← Headline
│                                       │
│   Think in terms of 2 minutes or      │
│   less. Smaller is better.            │  ← Muted subtext
│                                       │
│   ┌───────────────────────────────┐  │
│   │  e.g. Open the document       │  │  ← Text field, autofocus
│   └───────────────────────────────┘  │
│                                       │
│   I'm stuck – show ideas              │  ← Text button (disappears after tapped)
│                                       │    On tap: requests AI consent, then shows
│                                       │    suggestion chips in a wrap layout:
│                                       │    [suggestion 1]  [suggestion 2]  ...
│                                       │    Tapping a chip fills the text field.
│                                       │
│   Make this smaller                   │  ← Text button (only visible when text field
│                                       │    has content); replaces field text with AI
│                                       │    suggestion chip on tap
│                                       │
│   ┌───────────────────────────────┐  │
│   │          Let's go →           │  │  ← Full-width filled button
│   └───────────────────────────────┘  │    Disabled until text entered
└───────────────────────────────────────┘
```

**Both AI buttons require consent dialog on first use.**
**"Make this smaller" only appears after text is typed.**

---

### SCREEN 4 — CreateCardConfirmScreen
*"Ready for your tiny start?"*

```
┌───────────────────────────────────────┐
│  ←  (back icon, muted)                │
│                                       │
│   (spacer)                            │
│                                       │
│   Ready for your tiny start?          │  ← Headline
│                                       │
│   You're just giving this 2 tiny      │
│   minutes. You can stop after that    │
│   or keep going.                      │  ← Muted subtext
│                                       │
│   ┌───────────────────────────────┐  │
│   │  [action text user typed]     │  │  ← Card container (rounded corners,
│   └───────────────────────────────┘  │    surface color background)
│                                       │
│   (spacer)                            │
│                                       │
│   ┌───────────────────────────────┐  │
│   │           Start now           │  │  ← Full-width filled button
│   └───────────────────────────────┘  │
│                                       │
│            Save for later             │  ← Full-width text button
│                                       │
└───────────────────────────────────────┘
```

**[Start now]:** Creates card, navigates to TimerScreen. Clears navigation stack — no going back.
**[Save for later]:** Creates card, navigates to DeckScreen. Clears navigation stack.

---

### SCREEN 5a — Timer Screen (Running)
*Full-screen. No navigation bar.*

```
┌───────────────────────────────────────┐
│                                       │
│                                       │
│                                       │
│         [action label text]           │  ← Action text centered, large
│                                       │
│              01:47                    │  ← Countdown MM:SS, very large display font
│                                       │
│                ·                      │  ← Pulsing dot: slow fade in/out (3s cycle)
│                                       │
│                                       │
│                                       │
└───────────────────────────────────────┘
```

**Tap anywhere to pause.** Back gesture blocked while running.
**When paused:** Pulsing dot stops. "End session" text button appears at bottom center.
**Screen stays on** (wakelock active). **Haptic feedback on completion.**

---

### SCREEN 5b — Timer Screen (Complete)
*Fades in after countdown reaches zero.*

```
┌───────────────────────────────────────┐
│                                       │
│                                       │
│   You hit your 2 minutes.             │  ← Completion message
│   (or: "2 minutes + 1:30 extra"       │    if Keep going was used before)
│                                       │
│   ┌───────────────────────────────┐  │
│   │             Done              │  │  ← Full-width filled button
│   └───────────────────────────────┘  │
│                                       │
│   ┌───────────────────────────────┐  │
│   │          Keep going           │  │  ← Full-width outlined button
│   └───────────────────────────────┘  │
│                                       │
└───────────────────────────────────────┘
```

**[Done]:** Saves session record, navigates to DeckScreen. On first ever completion, shows Explainer Sheet first.
**[Keep going]:** Resets timer for another 2 minutes.

---

### SCREEN 5c — Post-Completion Explainer Sheet (Modal, first completion only)
*Slides up from bottom after [Done] on first ever completion.*

```
┌───────────────────────────────────────┐
│                                       │
│   That's how it works.                │  ← Headline
│                                       │
│   Two minutes was enough to start.    │
│   The hardest part isn't the doing    │
│   — it's deciding to begin.           │
│   You just did that.                  │  ← Muted body text
│                                       │
│   ┌───────────────────────────────┐  │
│   │            Got it             │  │  ← Full-width filled button
│   └───────────────────────────────┘  │
│                                       │
└───────────────────────────────────────┘
```

---

### SCREEN 6a — Deck Screen (With Cards)
*Home screen after first card created. Persists between sessions.*

```
┌───────────────────────────────────────┐
│  Your Deck  3    [⊟]  [⚙]            │  ← Title + card count (faint) +
│                                       │    Just One icon + Settings icon
│  ┌───────────────────────────────┐  │
│  │  Open the document            │  │  ← Card tile
│  │  Write my research paper  2min│  │    action label (larger)
│  └───────────────────────────────┘  │    goal label (smaller, muted)
│                                       │    duration badge (pill, surfaceHigh)
│  ┌───────────────────────────────┐  │
│  │  Reply to the email           │  │
│  │  Clear inbox              2min│  │
│  └───────────────────────────────┘  │
│                                       │
│  ┌───────────────────────────────┐  │
│  │  Take a 5-minute walk     2min│  │
│  └───────────────────────────────┘  │
│                                       │
│                               [ + ]   │  ← FAB bottom-right
└───────────────────────────────────────┘
```

**Tap a card:** Immediately opens TimerScreen for that card.
**Swipe a card left:** Reveals a "Later" dismiss background — releases to defer the card.
**[⊟] icon:** Enters Just One Mode.
**[⚙] icon:** Opens Settings.
**[+] FAB:** Opens Add Method Sheet (Screen 7).
**If Fresh Start mode is on:** A bottom action bar appears with [🎤 Voice planning] and [Past days] buttons.

---

### SCREEN 6b — Deck Screen (Empty)

```
┌───────────────────────────────────────┐
│  Your Deck       [⚙]                  │
│                                       │
│                                       │
│       Add your first card             │
│       to get started.                 │  ← Centered muted text
│                                       │
│       ┌───────────────────────┐      │
│       │  +  Add a card        │      │  ← Filled button with + icon
│       └───────────────────────┘      │
│                                       │
└───────────────────────────────────────┘
```

---

### SCREEN 6c — Just One Mode
*Entered via [⊟] icon. Hides the full list and shows one card at a time.*

```
┌───────────────────────────────────────┐
│                               [ ✕ ]   │  ← Close button, top-right
│                                       │
│   (spacer)                            │
│                                       │
│   ┌───────────────────────────────┐  │
│   │  Open the document            │  │  ← Single card, centered
│   │  Write my research paper      │  │
│   │  2 min                        │  │
│   └───────────────────────────────┘  │
│                                       │
│   ┌──────────┐  ┌──────────────┐    │
│   │  Start   │  │  Not today   │    │  ← Filled + text button side by side
│   └──────────┘  └──────────────┘    │
│                                       │
│   (spacer)                            │
└───────────────────────────────────────┘
```

**Tap background:** Exits Just One mode.
**[✕]:** Exits Just One mode.
**[Start]:** Opens TimerScreen for the shown card.
**[Not today]:** Defers card, shows next one.

---

### SCREEN 7 — Add Method Sheet (Modal Bottom Sheet)
*Appears when [+] FAB is tapped from Deck View.*

```
┌───────────────────────────────────────┐
│   Add a card                          │  ← Sheet title
│                                       │
│   ┌───────────────────────────────┐  │
│   │  🎤  Use voice                │  │  ← Outlined button
│   └───────────────────────────────┘  │
│                                       │
│   ┌───────────────────────────────┐  │
│   │  ✏️  Type it                  │  │  ← Outlined button
│   └───────────────────────────────┘  │
│                                       │
└───────────────────────────────────────┘
```

---

### SCREEN 8 — VoiceAISuggestionsScreen
*Appears after a voice recording is processed and AI extracts tasks from it.*

```
┌───────────────────────────────────────┐
│  ←  (back icon, muted)                │
│                                       │
│   Here's what I heard                 │  ← Headline
│   Pick what to work on                │  ← Muted subtext
│                                       │
│   ┌─────────────────────────────[✏]─┐│
│   │ ☑  Call the insurance company   ││  ← Checkbox (checked by default)
│   └─────────────────────────────────┘│    + task title text
│                                       │    + edit (pencil) icon button on right
│   ┌─────────────────────────────[✏]─┐│
│   │ ☑  Buy groceries                ││
│   └─────────────────────────────────┘│
│                                       │
│   ┌─────────────────────────────[✏]─┐│
│   │ ☑  Email professor              ││
│   └─────────────────────────────────┘│
│                                       │
│   ┌───────────────────────────────┐  │
│   │        Add selected           │  │  ← Filled button (disabled if none checked)
│   └───────────────────────────────┘  │
│                                       │
│        Add manually instead           │  ← Text button
│                                       │
└───────────────────────────────────────┘
```

**All checkboxes checked by default.** Uncheck to exclude a task.
**Edit icon:** Opens inline text field with check icon to confirm edit.
**[Add selected]:** Queues all checked tasks; routes each one through the card creation flow (Screen 2–4) serially. After all are created, returns to Deck.
**[Add manually instead]:** Goes straight to Screen 2 with the raw voice transcription prefilled.

---

### SCREEN 9 — Settings Screen

```
┌───────────────────────────────────────┐
│  ←  Settings                          │  ← Back button + title
│                                       │
│   ┌───────────────────────────────┐  │
│   │  Fresh Start mode        [○─] │  │  ← Toggle (off by default)
│   │                               │  │
│   │  Start each day with a blank  │  │
│   │  deck. Yesterday's cards      │  │
│   │  move to Past Days.           │  │
│   └───────────────────────────────┘  │
│                                       │
│   ─────────────────────────────────  │  ← Divider
│                                       │
│   AI Assistance                       │  ← Section label (small caps)
│                                       │
│   ┌───────────────────────────────┐  │
│   │  AI Suggestions          [○─] │  │  ← Toggle (off by default)
│   │                               │  │
│   │  Get ideas when you're stuck  │  │
│   │  creating tasks. Sends text   │  │
│   │  to OpenAI.                   │  │
│   └───────────────────────────────┘  │
│                                       │
└───────────────────────────────────────┘
```

**Exactly two settings.** No account settings, no notification controls, no theme options, no data management shown here.

---

### SCREEN 10 — Archive Prompt Sheet (Modal, triggered automatically)
*Slides up from bottom when a card has been deferred multiple times.*

```
┌───────────────────────────────────────┐
│                                       │
│   You've set this one aside a few     │
│   times. Want to rest it for now?     │  ← Headline
│                                       │
│   [action text of the deferred card]  │  ← Muted body text
│                                       │
│   ┌───────────────────────────────┐  │
│   │           Rest it             │  │  ← Filled button
│   └───────────────────────────────┘  │
│                                       │
│            Keep it                    │  ← Text button
│                                       │
└───────────────────────────────────────┘
```

---

## Review Dimensions

For each screen, comment on the following dimensions. Skip a dimension only if the persona's reaction would be completely neutral and uninformative. Do not skip a dimension because the reaction is positive — positive reactions are data.

1. **First impression** — Immediate gut reaction. Does the screen feel welcoming, intimidating, calm, confusing, or promising before anything is read or tapped?

2. **Copy and tone** — Does the language land for this persona? Is it too clinical, too casual, too vague, or too direct? Does it feel like it was written for someone like them or for someone else?

3. **Visual hierarchy** — What does the eye land on first? Does the layout direct attention correctly? Is anything competing for attention that shouldn't be?

4. **Clarity of purpose** — Is it immediately obvious what this screen is for and what the persona is expected to do?

5. **Interactive affordances** — Are buttons and interactive elements obvious, inviting, and well-placed? Is anything interactive that doesn't look like it? Anything that looks interactive but isn't?

6. **Cognitive load** — How much mental effort does this screen require? Does it ask for a decision, a memory retrieval, or creative output? Is that load appropriate for this persona given their executive dysfunction profile?

7. **Emotional response** — Does this screen produce anxiety, calm, motivation, relief, shame, frustration, or delight? Is that the response the app intends? Does it match what this persona needs at this moment?

8. **Friction points** — Where would this persona hesitate, stall, get confused, or feel the urge to leave? Be specific — name the element, the copy, or the interaction that breaks the flow.

9. **Delights** — Is there anything that feels specifically good, right, or satisfying for this persona? What earns trust or goodwill here?

10. **Missing elements** — What does this persona wish was present that isn't? What would lower their resistance or increase their confidence?

11. **Unnecessary elements** — What feels like clutter, distraction, or wrong for this persona's context?

12. **Alignment with core barrier** — Does this screen help or hinder this persona's specific reason for struggling with task initiation? Connect directly to the barrier described in their persona file.

---

## Post-Session Questions

After completing the screen walk-through, answer each question in character as the persona:

1. Walk me through what just happened in your own words.
2. Was there any moment where you felt confused about what to do next?
3. Was there any moment where you felt pressured or judged?
4. What did you expect to happen when you tapped the element you hesitated on most?
5. How is this different from a to-do list app, if at all?
6. What would have to be true for you to open this app again tomorrow?
7. Is there anything the app did that surprised you — positively or negatively?
8. What part of the app do you think you'd probably ignore or never use?
9. If you were describing this app to a friend, what would you say it's for?

---

## Falsification Test Scoring

Score each test PASS / FLAG / N/A for this persona. For each FLAG, briefly state what in this persona's session triggered it. Test definitions are in `aiDocs/userResearch/userTestScript.md` Section 5.

- F1 — Complexity Burnout
- F2 — Value Blindness
- F3 — Timer Abandonment or Rejection
- F4 — Voice Input Cognitive Load
- F5 — Fresh Start Misfire
- F6 — Deck Overwhelm
- F7 — Emotional Framing Misalignment
- F8 — Universal Utility / Wrong Tool
- F9 — Environmental Trap / Phone as Distraction
- F10 — Working Memory Prerequisite

---

## Persona Report Template

Use this exact structure for each report. Save to `ai/processes/uxReview/personaReports/<date>_report_<firstName>.md`.

```markdown
# UX Review Report — [Persona Name & Type]

**Persona file:** aiDocs/userResearch/persona[N].md
**Date:** [YYYY-MM-DD]
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: [answer]
2. What made it hard: [answer]
3. What I usually do: [answer]

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen
[Commentary across relevant review dimensions, written in first person as the persona.
Be specific: name the exact copy or element you're reacting to.]

### CreateCardGoalScreen
[Commentary]

### CreateCardActionScreen
[Commentary]

### CreateCardConfirmScreen
[Commentary]

### Timer Screen — Running
[Commentary]

### Timer Screen — Complete + Explainer
[Commentary]

### Deck View
[Commentary]

### Add Method Sheet
[Commentary]

### VoiceAISuggestionsScreen
[Commentary — only if this persona would plausibly use voice input. Otherwise write "Skipped — not applicable to this persona's typical behavior."]

### Settings
[Commentary]

### Just One Mode
[Commentary — only if this persona would plausibly discover or use this. Otherwise note why they wouldn't.]

### Archive Prompt
[Commentary — only if this persona would plausibly encounter it. Otherwise note why they wouldn't.]

---

## Post-Session Questions

1. [answer]
2. [answer]
3. [answer]
4. [answer]
5. [answer]
6. [answer]
7. [answer]
8. [answer]
9. [answer]

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS / FLAG / N/A | [if FLAG: specific evidence from this session] |
| F2 — Value Blindness | | |
| F3 — Timer Abandonment | | |
| F4 — Voice Input Cognitive Load | | |
| F5 — Fresh Start Misfire | | |
| F6 — Deck Overwhelm | | |
| F7 — Emotional Framing | | |
| F8 — Universal Utility | | |
| F9 — Environmental Trap | | |
| F10 — Working Memory | | |

---

## Overall Assessment

**Strongest moments for this persona:**
- [specific screen or interaction that worked]
- [...]

**Biggest friction points:**
- [specific screen or element and why it breaks for this persona]
- [...]

**Likelihood to return:** [High / Medium / Low]
[One sentence on why.]

**The one change that would most improve this persona's experience:**
[Single concrete, specific suggestion — not "improve the copy" but "change X to Y because Z"]
```

---

## Step 10 — Final UX Synthesis by Alex Chen

After all 9 persona reports are saved, run a final agent embodying **Alex Chen (persona5.md — the UX Designer)**.

This agent:
1. Reads all 9 persona reports from `ai/processes/uxReview/personaReports/`
2. Re-reads their own report (`<date>_report_alex.md`) as part of the set — Alex is both a test participant and the synthesizer
3. Re-reads `aiDocs/context.md` to recall the app's stated design principles and philosophy
4. Produces a professional synthesis document

### Synthesis Instructions for Alex

You are Alex Chen, Senior UX Researcher. You have read 9 simulated user test reports. Your job is to produce a synthesis document that a product team can act on directly.

Your synthesis must:
- Identify patterns across personas — distinguish what came up for multiple people (signal) from what was specific to one persona (noise)
- Give specific, actionable recommendations — not "improve the copy" but "the phrase 'big and difficult' on CreateCardGoalScreen produced shame-adjacent hesitation in 4 personas; consider replacing with 'heavy' or 'stuck on'"
- Clearly state what the app is getting right and must be protected — do not only surface problems
- Flag any findings that directly contradict MicroDeck's stated design principles from `aiDocs/context.md`
- Produce a prioritized list of changes with impact and effort ratings
- Report the aggregate falsification test results — which tests fired across the full persona set, and whether each one crossed its threshold

Save to: `ai/processes/uxReview/personaReports/<date>_finalUxReviewReport.md`

---

## Final Report Template

```markdown
# MicroDeck — Final UX Review Synthesis

**Date:** [YYYY-MM-DD]
**Synthesized by:** Alex Chen (Persona 5) — AI simulation
**Reports reviewed:**
- [list all 9 persona report filenames]

---

## Executive Summary

[3–5 bullet points — the most important findings a product team needs to act on. Lead with the most critical.]

---

## What the App Is Getting Right

[Specific screens, copy, or interactions that worked well across multiple personas.
Explain *why* they worked — connect back to MicroDeck's design principles where possible.
Be specific: "The completion message 'You hit your 2 minutes.' was described as..." not "The timer was well-received."]

---

## Critical Issues — Must Address

For each issue:

**Issue [N]: [Short title]**
- **Screen / element:** [specific screen name and element]
- **Personas affected:** [list which personas flagged this]
- **What happens:** [describe the friction or failure mode in concrete terms]
- **Why it matters:** [connect to design principle or user goal]
- **Recommended change:** [specific and actionable — what to change, what to change it to, why]

---

## Secondary Issues — Should Address

[Same format as Critical Issues, for issues that affect fewer personas or carry lower stakes]

---

## Persona-Specific Observations

[Issues or delights that surfaced for exactly one persona but are worth preserving as edge-case evidence. Note which persona and what was observed. These are not actionable as changes but are useful for future research prioritization.]

---

## Falsification Test Aggregate Results

| Test | Fired Count | Threshold | Status | Key Notes |
|---|---|---|---|---|
| F1 — Complexity Burnout | N / 9 | 2+ | TRIGGERED / CLEAR | |
| F2 — Value Blindness | N / 9 | 2+ | | |
| F3 — Timer Abandonment | N / 9 | 3+ | | |
| F4 — Voice Input Load | N / 9 | 1+ | | |
| F5 — Fresh Start Misfire | N / 9 | 2+ | | |
| F6 — Deck Overwhelm | N / 9 | 2+ | | |
| F7 — Emotional Framing | N / 9 | 1+ | | |
| F8 — Universal Utility | N / 9 | 2+ | | |
| F9 — Environmental Trap | N / 9 | 2+ | | |
| F10 — Working Memory | N / 9 | 1+ | | |

---

## Prioritized Change Recommendations

| Priority | Screen | Recommendation | Impact | Effort | Rationale |
|---|---|---|---|---|---|
| P1 | | | High / Med / Low | High / Med / Low | |
| P2 | | | | | |
| P3 | | | | | |

---

## Design Principles Check

Review each of MicroDeck's five stated design principles against the simulation findings:

1. **Does this help the user start something?** → [finding: what screens pass or fail this test]
2. **Does this add cognitive load?** → [finding: where load is appropriate vs. excessive]
3. **Could this make a user feel shame?** → [finding: which copy or screens triggered shame-adjacent responses]
4. **Does this require a network connection beyond AI suggestions?** → [finding or N/A]
5. **Does this make the timer more reliable?** → [finding: how the timer experience landed across personas]

---

## Alex's Professional Note

[A short, candid first-person paragraph from Alex's perspective as a UX researcher. What stood out across the full set of reports? What surprised you? What would you tell the product team if you had one minute with them? This is the part where you are not writing a formal deliverable — you are being honest.]
```
