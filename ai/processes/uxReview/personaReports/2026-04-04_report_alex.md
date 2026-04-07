# UX Review Report — Alex Chen, The Professional Evaluator

**Persona file:** aiDocs/userResearch/persona5.md
**Date:** 2026-04-04
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: Writing the recommendation section of a research report for a client. I have all the data. I've written the analysis. The recommendations are the part that requires a point of view — a commitment — and I've been sitting with them for three days in a state of professional paralysis that I find genuinely surprising.
2. What made it hard: The recommendations need to be defensible. And my work requires me to have a defensible opinion. And the irony of a UX researcher who can't start the section that requires judgment is not lost on me. There's something circular about being too aware of your own process to execute it.
3. What I usually do: I open my paper notebook and write the word "RECOMMENDATIONS" at the top of a fresh page. Then I close the notebook and make tea. Then I open it again. The word is still there.

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen

**First impression:** The app name is not in the headline — it's in the ambient position at the top. The headline is the copy: "Start the thing you keep putting off." That's an unusual structural choice. Most apps put their name in the most prominent position; this one puts the value proposition there instead. I note that as intentional.

**Copy and tone:** "Start the thing you keep putting off." — clean, direct. "One card. Two minutes. That's it." — the period after "That's it" is doing persuasive work. It closes the loop. I notice this as a copywriting decision and then notice that I'm noticing it, and try to just respond to it.

**Visual hierarchy:** The spacer at the top is large — the content is pushed toward the bottom third of the screen. This creates significant breathing room. On smaller phones this might compress uncomfortably, but on standard size it reads as composed and unhurried.

**Interactive affordances:** The button is full-width, which is correct — tap target is generous. The arrow icon on [Let's begin →] is a micro-choice that adds directional energy without adding complexity. I check the tap target mentally: probably 52-56dp tall. Acceptable.

**Delights:** No navigation bar. No status icons beyond the system UI. No secondary action. The intentionality is legible from this screen alone.

---

### CreateCardGoalScreen

**First impression:** Headline appears, field autofocuses, keyboard appears. No friction in the transition. The back button at top-left is muted — secondary in visual weight, accessible when needed. This is right.

**Copy and tone:** "What feels big and difficult right now?" — I have professional concerns about this phrasing that I want to hold while also allowing my authentic reaction. Professionally: "feels" centers emotional experience over task identification; for a clinical ADHD-focused tool, this may be intentional and well-calibrated. Personally: the question landed harder than I expected. The recommendations section. That's what's big and difficult right now.

I type "Write the recommendations section of the Harmony report."

**Visual hierarchy:** The heading is the dominant element. The placeholder text is appropriately muted. The [Next →] button disabled-state rendering correctly communicates that it requires input. No ambiguity.

**Cognitive load:** Low to moderate. The question requires a real answer, not just a form completion. That's by design and I respect it.

**Friction points:** None mechanical. The emotional weight of the question is the only "friction" and it's productive friction.

---

### CreateCardActionScreen

**First impression:** My goal text at top. I check the truncation behavior — 2-line max, muted, small. Correct. If the goal text is longer than two lines it clips. I note this as a potential edge case for verbose users.

**Copy and tone:** "What's one tiny step you could take first?" — "tiny" is the brand voice. It's consistent. I note it as a vocabulary commitment that could alienate users who read it as diminishing.

"Think in terms of 2 minutes or less. Smaller is better." — This supplemental text is useful as a constraint frame. It tells me what scale to operate at, which actually helps even for someone who understands task decomposition.

**I'm stuck — show ideas:** I tap this, professionally. The consent dialog: "Sends text to OpenAI." I approve. The chips appear: "Write one recommendation as a draft," "State the most important finding in one sentence," "List three possible recommendations without editing." These are good. I didn't expect them to be good. They're contextually appropriate, domain-appropriate, and correctly small.

**"Make this smaller":** I type "Write one recommendation without editing it" and then tap "Make this smaller." The result: "Write the first word of a recommendation." I pause. That is smaller. That is also, objectively, the correct first step for someone in the kind of paralysis I described. The AI understood something real about the task.

**Emotional response:** I'm going to be honest: I felt something when the AI produced "Write the first word of a recommendation." That's not a sentence I would have produced myself. My professional filter wouldn't have let me write something that small because it would have felt foolish. The AI doesn't have that filter. It gave me the actual first step.

**Delights:** The AI feature worked. Not just correctly — meaningfully. This is not the usual evaluation outcome for AI productivity features.

---

### CreateCardConfirmScreen

**First impression:** My card: "Write the first word of a recommendation." The rendering as a physical card tile — rounded corners, surface color — creates a gestalt shift. This is a thing. It has edges. It exists.

**Copy and tone:** "Ready for your tiny start?" — I note "tiny" for the third time. I'm tracking it. "You're just giving this 2 tiny minutes. You can stop after that or keep going." The exit permission is precisely the right reassurance for a user with commitment anxiety.

**Interactive affordances:** [Start now] is filled and primary. [Save for later] is text and secondary. Correct hierarchy. The card creation stack being cleared on both actions is a good UX decision — no going back to re-question the decision.

---

### Timer Screen — Running

**First impression:** I do a professional inventory of the screen immediately: task text centered, large type, countdown MM:SS with a display font, pulsing dot. Wakelock active. Back gesture blocked. I note all of these in about five seconds. Then I try to stop noting things and just be in the timer.

**The pulsing dot:** I want to give a clinical analysis of why it works — respiratory pacing, ambient feedback, something. But what I notice is that I've stopped analyzing about a minute in. The screen has fewer things to comment on than any other screen in the app. That's the point.

**Cognitive load:** Essentially zero, which is the design intent. Nothing to read. Nothing to configure. I write the first word of the recommendation in my notebook while the timer runs (the word is "First"). Then I keep writing. By 2:00, I have three sentences.

**Emotional response:** I will note this with professional detachment: I didn't expect to do work during the timer. I expected to sit with the discomfort of the blank task. Instead, the constraint produced output. I'm aware this is exactly what the product claims to do. The claim is valid.

---

### Timer Screen — Complete + Explainer

**First impression:** "You hit your 2 minutes." — I observe the absence of praise, the absence of a checkmark animation, the absence of a score. The absence is the design. A completion screen that doesn't celebrate does something subtle: it treats the user as someone who doesn't need external validation to understand that they did something. I respect this deeply.

**The Explainer Sheet:** "The hardest part isn't the doing — it's deciding to begin. You just did that." — This is true and I know it's true and I've cited this research in client decks. But hearing it immediately after a session in which it became true is a different experience. I've been talking about this effect for years. The app demonstrated it in four screens and two minutes.

**[Keep going]:** I tap it. I'm not done.

---

### Deck View

**First impression:** "Your Deck 1" — my card, rendered in the list. The card count badge is small and muted — correctly communicates quantity without making it a metric to optimize.

**Visual hierarchy:** The [⊟] and [⚙] icons are at the same level as the title. The [⚙] is the expected position for settings; [⊟] is less conventional and less immediately legible.

**Interactive affordances:** The FAB at bottom-right is standard and correctly positioned. Swipe-left-to-defer is a discovered interaction — no affordance visible, which is a minor discoverability issue for new users.

**Friction points:** The swipe-to-defer gesture has no visible affordance on the card surface. A user unfamiliar with this pattern would not know it exists. For the target audience (ADHD users who may not explore systematically), this is a real discoverability gap. A subtle "swipe to defer" hint on first view, or a long-press menu, would close this.

---

### Add Method Sheet

**First impression:** Two options, clean icons, appropriate sheet title. I note the sheet is a bottom modal — correct for this action.

**Cognitive load:** Very low.

**Interactive affordances:** Both buttons are outlined (equal visual weight). For users who have a clear preference, the parity is slightly frustrating — why not make the more common choice primary? The answer is probably that the app doesn't know which is common for a given user, and defaulting neither is safer than defaulting wrong. Acceptable.

---

### VoiceAISuggestionsScreen

I use voice on a subsequent session, speaking three things I need to do today.

**First impression:** "Here's what I heard / Pick what to work on." — good header hierarchy. Checkbox list, all checked by default. Edit icon on each item.

**Visual affordances:** The [✏] edit icon is small but detectable. The inline editing interaction (tap → text field + check to confirm) is clean. No wasted motion.

**Copy and tone:** "Add manually instead" as the escape hatch is correctly named and positioned.

**Cognitive load:** Moderate. Reviewing a list requires more cognitive work than looking at a single card. The value exchange is: voice input reduces creation friction, checklist review adds evaluation friction. Whether the net is positive depends on how many items were extracted. For 2–3 items, it's positive. For 4+, I'd start to question it.

**Friction points:** The downstream serial creation flow is the critical issue. Three checked items means three complete goal/action/confirm screen sequences. By item two, I'm not adding creative input — I'm pressing [Let's go] and [Start now] on autopilot because the AI already did the work. The per-card flow assumes the user is generating the content, not approving it. These are different cognitive tasks requiring different interface patterns.

---

### Settings

**First impression:** Two toggles. My professional reaction is: this is either a very early-stage product or a very disciplined one. Given the quality of the rest of the app, I believe it's disciplined.

**Copy and tone:** Both settings have complete, accurate descriptions. "Sends text to OpenAI" is the kind of disclosure I advocate for in every client engagement and rarely see implemented. Someone on this team has good instincts.

**Emotional response:** The absence of a notification settings section caught me. A user who wants to set a reminder to open the app daily — a legitimate and valuable use case — has no way to do that from within the app. This could be an intentional scope decision, but it feels like something worth noting.

**Missing elements:** A single "daily reminder" notification option would serve return-use cases without compromising the minimal settings philosophy. One toggle. No frequency controls needed. Just: "Remind me once a day."

---

### Just One Mode

**First impression:** One card, centered. [Start] and [Not today]. I recognize this as the "focused view" pattern — common in task management apps as an optional mode. Here it's executed with characteristic restraint.

**Copy and tone:** "Not today" — good. Not "skip," not "dismiss," not "next." "Not today" is a complete sentence that makes a temporal claim rather than a dismissal.

**Cognitive load:** Minimum viable decision. This is the right cognitive baseline for executive dysfunction.

**Friction points:** Discoverability. The [⊟] icon is opaque without context. This is an important enough feature to be discoverable without accidental tap. A first-time prompt ("feeling overwhelmed by your deck? Try Just One mode") would help without requiring a tooltip system.

---

### Archive Prompt

**First impression:** "You've set this one aside a few times. Want to rest it for now?" — I read this with professional appreciation. The copy is writing around the shame vector very deliberately. "Set aside" (not "ignored"). "Rest it" (not "archive" or "delete"). "For now" (not "permanently").

**Copy and tone:** This is some of the best contextual copy I've seen in a productivity app. I'd cite it in a client presentation.

**Emotional response:** Even I, the professional evaluator who defaults to clinical response, feel the considered care in this dialog. The word selection is doing quiet, important work.

---

## Post-Session Questions

1. I evaluated a productivity app professionally and then found myself actually using it. That's not a frequent outcome. The app produced a session in which I completed work I'd been avoiding — and the mechanism was simple enough that I can describe it: it removed every decision except the task.

2. Two moments of professional confusion that resolved quickly: what "⊟" does (opaque icon), and where swipe-to-defer is documented (nowhere — discovered by accident).

3. No. The only potential shame vector — asking me to name something "big and difficult" — landed as honest rather than clinical. The subsequent copy actively worked against shame accumulation.

4. When I tapped "Make this smaller" — I expected a single AI-generated alternative. Getting one chip that was noticeably, specifically, usefully smaller was not what I expected from an AI feature in an indie app.

5. Completely different in mechanism. A to-do list is a catalog. This app is an activation scaffold. The list is where tasks live. This app is how tasks start. These are different tools for different moments.

6. If I needed it again — which, based on this session, I probably will. The conditions that created the paralysis are structural and recurring. The app doesn't fix those conditions; it provides one very specific intervention for one very specific moment. That's enough.

7. "Make this smaller" producing genuinely useful output. And the completion screen actively not celebrating — that caught me.

8. Voice input. Not because it's badly designed, but because my work mode is written and silent. The voice feature is excellent for people who think out loud.

9. "It's a precision tool for the moment you know what you should do and can't start. It doesn't track anything, doesn't judge anything, doesn't ask for more than two minutes. That's its whole thing."

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS | Flow felt appropriately weighted; no expressed drag |
| F2 — Value Blindness | PASS | Gave precise, sophisticated articulation of value proposition |
| F3 — Timer Abandonment | PASS | Used [Keep going]; timer framing and execution both worked |
| F4 — Voice Input Cognitive Load | FLAG | VoiceAISuggestionsScreen UI worked well; the downstream serial creation flow is the problem — 3 items = 3 full creation flows, which transforms voice from a lower-friction path to a higher-friction one |
| F5 — Fresh Start Misfire | PASS | Understood Fresh Start immediately; no alarm |
| F6 — Deck Overwhelm | PASS | Used Just One Mode proactively; no paralysis |
| F7 — Emotional Framing | PASS | No shame responses; copy consistently worked against shame |
| F8 — Universal Utility | PASS | Articulated precise use case; did not frame it as only useful in extremis |
| F9 — Environmental Trap | PASS | No phone distraction issues noted |
| F10 — Working Memory | PASS | Arrived with a concrete, specific task in working memory |

---

## Overall Assessment

**Strongest moments for this persona:**
- "Make this smaller" AI feature — produced unexpectedly appropriate and usefully small output; this is the feature that earned professional respect from a user who was pre-skeptical of AI productivity features
- Timer Screen completion message ("You hit your 2 minutes.") — the deliberate absence of celebration is the correct design choice; communicates respect for user autonomy and adult relationship with accomplishment
- Archive Prompt copy — "rest it for now" demonstrates the kind of intentional emotional design that most apps produce by accident if at all; here it reads as deliberate

**Biggest friction points:**
- Swipe-to-defer discoverability on deck cards: no visible affordance; important interaction is effectively hidden from users who don't explore
- [⊟] Just One Mode icon: opaque; a mode this valuable for the target user deserves a better discoverability path
- Serial creation flow from VoiceAISuggestionsScreen: the only significant UX problem in the app; the voice feature's value is precisely its lower cognitive footprint, and the downstream serial flow eliminates that advantage completely

**Likelihood to return:** High
The app earned a personal reaction — which this persona doesn't give easily. And the structural conditions that created the paralysis will recur.

**The one change that would most improve this persona's experience:**
Replace the VoiceAISuggestionsScreen [Add selected] serial creation flow with a batch-confirm pattern: show all checked tasks as pre-created cards with goal and action pre-populated from the AI extraction, require only a single "Add all" confirmation to the deck — one screen, one tap, done.
