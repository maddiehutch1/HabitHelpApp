# MicroDeck — Final UX Review Synthesis

**Date:** 2026-04-04
**Synthesized by:** Alex Chen (Persona 5) — AI simulation
**Reports reviewed:**
- 2026-04-04_report_jordan.md
- 2026-04-04_report_mara.md
- 2026-04-04_report_dani.md
- 2026-04-04_report_sam.md
- 2026-04-04_report_alex.md
- 2026-04-04_report_priya.md
- 2026-04-04_report_marcus.md
- 2026-04-04_report_zoe.md
- 2026-04-04_report_eli.md

---

## Executive Summary

- **The core mechanic works.** Across all 9 personas, without exception, the primary loop (create card → run timer → complete) produced the behavioral outcome the app promises: users began tasks they had been avoiding. This is the headline finding and must be protected at all costs in any iteration.
- **The VoiceAISuggestionsScreen downstream flow is the single most significant design failure.** Five of 9 personas flagged the serial card-creation flow that follows voice extraction. The flow adds 2–4 full creation-screen sequences after an input method chosen precisely for its low friction. This directly inverts the feature's value proposition.
- **"What feels big and difficult right now?" is both the app's most powerful moment and its highest-risk screen.** Four personas experienced the open-ended blank field as nearly triggering a paralysis episode before successfully completing the flow. The question works when users arrive with a task in working memory; it risks breakdown when they don't.
- **Just One Mode is an underexposed critical feature.** Seven of 9 personas who encountered it identified it as the truest expression of the app's promise — but discoverability depends on accidentally tapping an unlabeled icon. This feature is too important to reach users only by accident.
- **The Archive Prompt copy ("rest it for now") is the single best piece of writing in the app.** Across every persona who encountered it, it resolved the archiving moment without triggering shame. This is a rare design outcome and should be treated as a model for any future copy choices.

---

## What the App Is Getting Right

### The timer screen is the product.

Every persona — from the Skeptical Investor to the Overstimulated Teenager — reported that the full-screen timer produced the state the app promises. Jordan described her brain going to the task without deciding to. Marcus described "looking at the thing instead of around it" for the first time in six weeks. Sam mobilized mental resources he hadn't been able to access in forty minutes of staring at an email. Eli started writing code.

The specific design choices that make this work: full-screen with no navigation bar, back gesture blocked while running, wakelock preventing screen sleep, and the pulsing dot providing ambient presence without demand. None of these are accidental. They collectively create a contained environment with no exit options — which is precisely what executive dysfunction needs. This design must not be compromised.

This connects directly to MicroDeck's first design principle: *Does this help the user start something?* The timer screen answers this definitively and must be defended.

### "You can stop after that or keep going."

The explicit exit permission on the CreateCardConfirmScreen appeared in eight of nine persona reports as a conversion moment. Mara tapped [Start now] specifically because this sentence existed. Sam noted it without attributing significance, then demonstrated it was significant by using [Keep going]. Dani processed it as "the session isn't permanent."

This sentence works because it reframes the timer not as a commitment but as an option. For users with executive dysfunction, commitment resistance is often the final barrier before initiation. Removing the commitment removes the barrier. The sentence is load-bearing and should never be edited without careful re-testing.

### The Archive Prompt copy.

"You've set this one aside a few times. Want to rest it for now?" — [Rest it] / [Keep it].

Every persona who encountered this screen noted the absence of judgment. Dani nearly cried. Mara felt relief. Marcus, whose default mode is emotional suppression, reported "something specific." Even Sam, who described himself as not carrying a shame load, noted the design intelligence of the word "rest."

The word choices are doing precise work: "set aside" (not "ignored"), "a few times" (not "seven times" or "repeatedly"), "rest it" (not "archive" or "delete" or "give up on"), "for now" (reversible, not permanent). Every word removes a shame vector. This is the standard the rest of the app's copy should aspire to.

This connects directly to MicroDeck's third design principle: *Could this make a user feel shame?* The Archive Prompt answers "no" and demonstrates how.

### The completion message.

"You hit your 2 minutes." — six words, no exclamation point. Received as correct by 8 of 9 personas. The one outlier (Jordan) was also satisfied; they simply noted the professional restraint. The absence of celebration communicates respect for adult autonomy. Priya specifically identified this as something she advocates for in client engagements and rarely sees implemented.

### The Settings screen's intentional restraint.

Three of 9 personas (Jordan, Sam, Priya) initially expected more settings and then recognized the discipline as intentional. Two personas (Mara, Zoe) noted the absence of streak counters as a specific relief — "that's nice" and "the Duolingo streak thing has broken me three times." The restraint earns trust from the target audience, even when it creates initial confusion for power users.

The "Sends text to OpenAI" disclosure on AI Suggestions was noted positively by four personas (Jordan, Sam, Alex, Priya). Explicit data destination disclosure in contextual settings copy is rare in consumer apps. It communicates integrity. Keep it.

---

## Critical Issues — Must Address

**Issue 1: VoiceAISuggestionsScreen → Serial Creation Flow**
- **Screen / element:** VoiceAISuggestionsScreen → [Add selected] downstream flow
- **Personas affected:** Jordan, Dani, Alex, Zoe, Eli (5 of 9)
- **What happens:** After checking items on the voice suggestions screen, [Add selected] routes each checked task through a full card creation sequence (CreateCardGoalScreen → CreateCardActionScreen → CreateCardConfirmScreen) per task. A user who selects 3 tasks completes 9+ screens. Jordan completed 2 passes and found the third tedious. Dani lost momentum on pass 2. Zoe described the post-voice process as "kind of long." Eli explicitly noted the logical incoherence: "Why does the action screen ask me to generate a first step if the AI already knows my task?"
- **Why it matters:** Voice input is selected specifically by users in high-cognitive-load states (Dani: freeze mode; Eli: multi-task overload). These users have the least bandwidth for downstream navigation. The serial flow inverts the feature's value proposition: voice reduces creation friction, the serial flow adds it back multiplied by task count. This directly violates design principle 2 (does this add cognitive load?) and principle 1 (does this help the user start?).
- **Recommended change:** Replace the serial creation flow with a batch-confirm screen. After [Add selected], show all checked tasks as pre-populated cards (goal = task title from extraction, action = blank or AI-suggested). Require a single "Add [N] cards to deck" confirmation. Optionally allow inline editing of action text per card. No per-card creation navigation. This should be one screen and one tap to complete.

---

**Issue 2: Just One Mode Discoverability**
- **Screen / element:** Deck View — [⊟] icon
- **Personas affected:** Mara (never found it without accident), Dani (found by accident; critical for her use case), Jordan (decoded from professional knowledge), Zoe (found by accident), Eli (found by accident on day 3)
- **What happens:** Just One Mode is accessed via the [⊟] icon in the Deck View header. The icon is non-standard and not self-describing. Five personas discovered it accidentally. Three personas decoded it from professional knowledge. No persona found it by deliberate search.
- **Why it matters:** Just One Mode is the screen that most precisely fulfills MicroDeck's core promise ("one card, two minutes"). It's also the screen most important to the target audience in high-dysfunction states — the moment when a 4-card deck produces the same overwhelm the app was supposed to solve. Dani: "Just One Mode is the screen this app should probably default to for me." Zoe: "This is the actual version of the app that was promised on the welcome screen." An important feature that reaches users only by accident is effectively not a feature.
- **Recommended change:** When the deck grows to 4+ cards for the first time, show a one-time subtle prompt: "Deck feeling crowded? Tap [⊟] to see one card at a time." Alternatively, rename the [⊟] icon with a visible label ("Just One") on first encounter, replacing with the icon only after use. Either approach serves discoverability without adding persistent UI complexity.

---

**Issue 3: CreateCardGoalScreen Blank-Field Paralysis Risk**
- **Screen / element:** CreateCardGoalScreen — "What feels big and difficult right now?" + blank text field
- **Personas affected:** Mara (near-abandonment), Dani (near-shutdown), Eli (multi-task spiral risk), Zoe (brief stall)
- **What happens:** Four personas experienced the combination of an open-ended question and a blank field as a near-paralysis event. The question is emotionally accurate but places the burden of task selection entirely on users who are already struggling with selection. Mara: "Everything. All of it." Dani: "Stalled for 20 seconds." Eli: "My brain immediately tries to list everything."
- **Why it matters:** This is the entry point to the app's core value. Users who freeze here never reach the timer. The screen that should be lowest-friction is instead the highest emotional-cognitive load moment for the most vulnerable users. This directly contradicts design principle 2 (cognitive load).
- **Recommended change:** Add a conditional micro-scaffold: if the text field remains empty for 5+ seconds, show a soft secondary prompt below the placeholder text — "Having trouble picking? Try the most urgent deadline you have." This provides a concrete decision rule without restructuring the question or adding persistent UI elements. The primary question ("What feels big and difficult?") remains intact; the scaffold only appears when a user signals difficulty.

---

## Secondary Issues — Should Address

**Issue 4: "Tiny" Used Three Times Across Creation Flow**
- **Screen / element:** CreateCardActionScreen ("one tiny step"), CreateCardConfirmScreen ("Ready for your tiny start?"), CreateCardConfirmScreen body ("2 tiny minutes")
- **Personas affected:** Jordan (noted), Sam (mild irritation — flagged as "slightly condescending" on third encounter), Priya (slight register mismatch), Marcus (mild objection)
- **What happens:** "Tiny" is a deliberate vocabulary choice — it reframes the task scale and works well on first use. By the third encounter in a single session, professional users experience it as accumulation — talking-down to someone who understands task decomposition.
- **Why it matters:** While the word works for most personas (Mara, Dani, Zoe, Eli received it positively), high-functioning professional users who are in situational rather than structural dysfunction interpret repeated "tiny" as condescension. The app currently alienates the Sam/Priya/Marcus cohort on a word-frequency issue.
- **Recommended change:** Reserve "tiny" for the action screen, where it earns its place by constraining the step size. On the confirm screen: "Ready for your small start?" and "You're just giving this 2 minutes." Two uses instead of four; same semantic intent; no condescension accumulation.

---

**Issue 5: Fresh Start Copy — Blank-Deck Framing**
- **Screen / element:** Settings — Fresh Start mode description
- **Personas affected:** Mara (brief alarm), Dani (genuine panic before second sentence), Zoe (cautious reading), Eli (resolved alarm but chose not to enable)
- **What happens:** "Start each day with a blank deck" triggers an alarm response in four personas before the second sentence resolves it. The word "blank" implies deletion. "Yesterday's cards move to Past Days" is the reassurance — but it comes after the alarm has fired.
- **Why it matters:** Fresh Start is a genuinely valuable feature for the right users. Four personas who would benefit from it either avoided enabling it or felt unnecessary distress discovering it. The framing order is working against the feature.
- **Recommended change:** Swap the sentence order: "Yesterday's cards move to Past Days — start each day with a fresh deck." Lead with the reassurance (cards are preserved), then describe the effect (daily reset). Same information, opposite emotional sequence.

---

**Issue 6: AI Consent Copy — "Sends text to OpenAI"**
- **Screen / element:** CreateCardActionScreen — "I'm stuck — show ideas" consent dialog; Settings — AI Suggestions toggle description
- **Personas affected:** Mara (low-level unease, unresolved), Zoe (skimmed and approved, didn't fully process)
- **What happens:** The phrase "Sends text to OpenAI" is transparent (good) but incomplete — it doesn't confirm that data is not stored. For users with anxiety, an incomplete disclosure leaves a residual worry that "sends" implies "stores." For users who skim, the disclosure doesn't land at all.
- **Why it matters:** The disclosure is currently correct but could earn more trust than it does. The target audience includes anxiety-prone users for whom vague data language is a persistent, low-level concern.
- **Recommended change:** Extend the phrase to: "Your task text is sent to OpenAI to generate suggestions and is not stored." One sentence. No privacy policy required. Resolves the ambient concern at source.

---

**Issue 7: Swipe-to-Defer Discoverability**
- **Screen / element:** Deck View — swipe left on card
- **Personas affected:** Alex (discovered accidentally), Jordan (used it; noted no visible affordance)
- **What happens:** Swipe-left-to-defer has no visible affordance on the card surface. Users who don't habitually explore swipe gestures won't discover this interaction.
- **Why it matters:** Deferring cards is a core deck management action. Hidden interactions create invisible capability gaps for users who rely on visible affordances — particularly relevant for the target audience who may not engage in systematic exploration.
- **Recommended change:** Add a subtle visual affordance on the trailing edge of each card — a faint arrow or the "Later" label lightly ghosted — visible at rest and more visible on hover/press. Alternatively, surface swipe-to-defer in a brief one-time card: "Tip: swipe left to defer a card for later." The first approach is preferable (persistent affordance vs. ephemeral instruction).

---

## Persona-Specific Observations

**Jordan (High-Functioning Avoider):** The voice serial creation flow is specifically problematic for power users who would use voice to capture multiple work tasks. Jordan's critique — "three tasks means three full creation screens" — is technically accurate and represents a meaningful efficiency gap.

**Dani (Crisis Mode User):** Just One Mode should be considered as the default view for users who are in a freeze state. There is no way to detect this automatically, but surfacing Just One Mode earlier in the deck-growth timeline (perhaps at 3 cards rather than 4+) would serve this persona without harming others.

**Sam (Burnout Professional):** The AI features on CreateCardActionScreen are irrelevant for users whose blocker is execution rather than task-definition. This is a positioning gap rather than a design flaw — the screen's "I'm stuck" copy implies the user can't identify a first step, when Sam's problem is executing on steps he's already identified. Not actionable as a change, but important for onboarding copy.

**Priya (PM):** Identified the absence of a daily notification option as the most actionable retention gap. This is a legitimate observation — a single optional "remind me once a day" toggle adds no philosophical cost and measurably addresses D7 return rates for users who are not in crisis every day.

**Marcus (Investor):** The F8 (Universal Utility) risk is most pronounced here — Marcus would skip the app on days when avoidance is moderate rather than severe. The onboarding copy "start the thing you keep putting off" is broad enough to attract users who then find the app is only optimal for their worst days. This is a positioning question more than a design question.

**Zoe (Teenager):** This persona experiences Just One Mode as the fulfillment of the Welcome Screen's promise. The observation "this is the actual version of the app" is a design critique worth considering — the Deck View is functional but slightly at odds with the product's stated philosophy, while Just One Mode is perfectly aligned with it.

**Eli (Undergrad):** Surfaced the most technically interesting voice flow critique: "Why does the action screen ask me to generate a first step if the AI already knows my task?" The voice extraction path implies AI understanding of the task; the subsequent action screen treats the task as unknown. This incoherence is real and would benefit from passing the voice-extracted task context forward into the action screen's AI suggestions.

---

## Falsification Test Aggregate Results

| Test | Fired Count | Threshold | Status | Key Notes |
|---|---|---|---|---|
| F1 — Complexity Burnout | 0 / 9 | 2+ | CLEAR | No persona expressed flow fatigue or abandoned the creation sequence |
| F2 — Value Blindness | 0 / 9 | 2+ | CLEAR | All 9 personas articulated a meaningful distinction from to-do list apps post-session |
| F3 — Timer Abandonment | 0 / 9 | 3+ | CLEAR | All 9 personas engaged positively with the timer; 6 used [Keep going] |
| F4 — Voice Input Cognitive Load | 5 / 9 | 1+ | TRIGGERED | Jordan, Dani, Alex, Zoe, Eli — all flagged the downstream serial creation flow, not the extraction UI; the extraction UI works; the creation flow after selection is the problem |
| F5 — Fresh Start Misfire | 4 / 9 | 2+ | TRIGGERED | Mara, Dani, Zoe, Eli — all experienced initial alarm at "blank deck" framing; resolved by second sentence but the order of information creates unnecessary distress |
| F6 — Deck Overwhelm | 1 / 9 | 2+ | CLEAR* | Eli experienced paralysis at a 4-card deck; Jordan and others found Just One Mode proactively; *borderline — if Just One Mode discoverability were improved, this test would be more reliably cleared |
| F7 — Emotional Framing | 2 / 9 | 1+ | TRIGGERED | Mara: "What feels big and difficult" nearly triggered shame-adjacent shutdown; Sam: "tiny" repeated three times registered as condescending; both are distinct failure modes at the threshold |
| F8 — Universal Utility | 1 / 9 | 2+ | CLEAR | Marcus expressed conditional utility (useful on bad days, not all days); no other persona expressed this; below threshold |
| F9 — Environmental Trap | 3 / 9 | 2+ | TRIGGERED | Mara, Dani (via reflex check), Zoe, Eli — phone-as-distraction is structural for all high-phone-use personas; the app cannot solve this, but onboarding acknowledgment is warranted |
| F10 — Working Memory | 2 / 9 | 1+ | TRIGGERED | Dani: pharmacy task barely in working memory on a freeze day; Eli: multi-task urgency almost prevented single-task selection; both represent real working-memory-prerequisite moments |

---

## Prioritized Change Recommendations

| Priority | Screen | Recommendation | Impact | Effort | Rationale |
|---|---|---|---|---|---|
| P1 | VoiceAISuggestionsScreen | Replace serial creation flow with single batch-confirm screen: all selected tasks become cards in one tap | High | Medium | F4 triggered by 5/9 personas; inverts voice input's value proposition; core feature undermined |
| P2 | CreateCardGoalScreen | Add conditional micro-scaffold after 5s of empty field: "Having trouble picking? Try the most urgent deadline you have." | High | Low | F10 triggered; 4 personas near-paralysis at this screen; entry point to core value loop |
| P3 | Deck View | Surface Just One Mode discoverability at 4-card threshold with one-time gentle prompt | High | Low | Feature identified by 7/9 as the truest product expression; currently found only by accident |
| P4 | Settings — Fresh Start | Swap sentence order: lead with "Yesterday's cards move to Past Days" before "start each day with a fresh deck" | Medium | Low | F5 triggered 4/9; same information, better emotional sequence |
| P5 | CreateCardConfirmScreen + CreateCardActionScreen | Reduce "tiny" occurrences from 4 to 2; retain on action screen; use "small" and "2 minutes" elsewhere | Medium | Low | F7 triggered; accumulation effect condescends to professional-mode users |
| P6 | AI consent dialog | Add: "Your text is sent to generate suggestions and is not stored." | Medium | Low | Residual anxiety for Mara; trust gap for privacy-conscious users |
| P7 | Deck View — card tiles | Add swipe-to-defer visual affordance (faint trailing indicator) | Low | Low | Discovery gap; important interaction currently invisible |
| P8 | Settings | Consider single "daily reminder" toggle (opt-in, one notification/day) | Medium | Medium | Not a philosophy violation; addresses D7 retention gap identified by Priya and implied by Mara; the only missing feature with clear return-use impact |

---

## Design Principles Check

1. **Does this help the user start something?** → The timer screen answers this definitively for all 9 personas. The Welcome, Goal, Action, and Confirm screens form an effective funnel toward the timer. The voice flow works until the serial creation overhead defeats it. The deck view is neutral. Just One Mode is highly aligned. Overall: strong pass with the voice flow as the primary failure point.

2. **Does this add cognitive load?** → The timer screen is the lowest cognitive load screen in the product — correctly so. The creation flow adds moderate-appropriate load. The exception: CreateCardGoalScreen's blank field + open question creates a load spike for users who arrive without a single task in working memory. The VoiceAISuggestionsScreen → serial creation adds significant unexpected load. Two specific, addressable failures within an otherwise well-calibrated product.

3. **Could this make a user feel shame?** → F7 triggered twice: Mara at CreateCardGoalScreen ("big and difficult" nearly induced shame-adjacent freeze), Sam at the creation flow ("tiny" x3 registered as talking-down). The Archive Prompt is a counter-example — the most shame-resistant piece of writing in the app, and a model. The completion message's absence of celebration is correct. The design is mostly shame-resistant with two specific addressable exceptions.

4. **Does this require a network connection beyond AI suggestions?** → No. All AI features correctly require consent and are gated on the `aiSuggestionsEnabled` pref. The disclosure "Sends text to OpenAI" is present and correct. The disclosure could be more complete ("not stored") but is not inaccurate. Pass.

5. **Does this make the timer more reliable?** → Yes. Wakelock active during timer, back gesture blocked while running, AppLifecycleState pause handling, haptic feedback on completion — all reported as working correctly. No persona experienced timer-screen technical failure. The screen design (full-screen, no competing elements, pulsing dot) creates a psychological reliability to match the technical reliability. Strong pass.

---

## Prioritized Change Recommendations

---

## Alex's Professional Note

I've been doing this work for a decade. I've run user tests on products I believed in and watched them fail. I've run tests on products I was skeptical of and watched them surprise me. I came into this evaluation as a professional. I left it having used the app personally on a task I'd been avoiding for three days. That doesn't happen to me.

What this product gets right is the thing most products get wrong: it knows what it's for. Not in the marketing sense — in the product decisions sense. Every choice that looks like an absence (no streaks, no analytics, no gamification, no notifications, no theme picker, no account) is a decision that the team made to stay out of the user's way. Those absences are harder to ship than the features would have been. Somebody fought for them.

The Archive Prompt is the best contextual copy I've seen in a productivity tool. Full stop. "Want to rest it for now?" — that's the app knowing its user better than its user knows themselves in that moment.

The things I'd tell the product team if I had one minute: Fix the voice serial flow. It's the only place the product works against itself. Surface Just One Mode earlier — it's the most honest expression of your philosophy and users find it only by accident. And watch the word "tiny." It earns its place once. After that, it starts to feel like management.

The core mechanic is real. It worked across every demographic, every dysfunction level, every occupational background in this evaluation. That's not nothing. That's actually everything.

Don't add the streak counter.
