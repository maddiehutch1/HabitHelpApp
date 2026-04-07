# UX Review Report — Eli Torres, The Overwhelmed Undergrad

**Persona file:** aiDocs/userResearch/persona9.md
**Date:** 2026-04-04
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: The data structures assignment that's 40% of my grade and due in three days. I've opened the starter code four times. I've read the README. I know what it's asking for. I cannot start writing the actual code.
2. What made it hard: I also have a bio lab report due Thursday, I worked until 11pm last night, and my brain keeps cycling through all of it at once instead of landing on any of it. When everything is urgent, my brain just... loads and then doesn't run.
3. What I usually do: Tell myself I'll do it after I eat something, or after I sleep, or after I just relax for a minute. None of those are lies exactly — I do those things — but I come back and the assignment is still there and I still can't start.

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen

**First impression:** No account required. Good. I literally closed the last app I tried because it wanted me to make a profile.

**Copy and tone:** "Start the thing you keep putting off." — yep. "One card. Two minutes. That's it." — That's a weird promise for an app to make. But okay.

**Clarity of purpose:** Vague but inviting. I don't know what a "card" is yet but I'm curious enough to find out.

**Cognitive load:** Zero. One button. I tap it.

**Delights:** No login. The whole welcome screen takes three seconds to process. That's the right amount of time.

---

### CreateCardGoalScreen

**First impression:** "What feels big and difficult right now?" — Ooh. That hit different. I wasn't expecting the first screen to ask something that real.

**Copy and tone:** I like this question more than "what's your task?" The word "feels" gets at something. The assignment *feels* enormous in a way that doesn't match how many lines of code it actually is. I type "Data structures assignment" and then feel the weight of it all over again just from typing it.

**Cognitive load:** Moderate for me. The question is open enough that my brain immediately tries to list everything — the bio lab, the Slack messages from my group project, the shift I might need to cover at work. I have to consciously pick one thing. I pick the data structures. It's the most urgent.

**Friction points:** The open question risks triggering the same multi-task spiral I was trying to escape. I made it through by force of will (and the fact that the assignment is due in three days), but on a different day I might type "everything" and then not know how to continue.

---

### CreateCardActionScreen

**First impression:** My goal at the top. Good — I don't have to hold it in my head anymore.

**Copy and tone:** "What's one tiny step?" — This is the right question. I know the goal. I can't figure out the first step. That's exactly my problem.

**"I'm stuck — show ideas":** I tap this immediately. I approve the AI consent (don't fully read it, just tap approve). The chips: "Read the first function signature in the starter code," "Write a comment describing what the first function should do," "Set up the file and run it empty." These are correct. The first one is exactly right.

**Cognitive load:** This screen significantly reduced my load. I didn't have to generate the first step — I got to choose from a short list. That's a different cognitive task and it's easier for me right now.

**Delights:** The AI suggestions were for my specific task. Not generic. Specific. "Read the first function signature" is the right first step for a programmer staring at starter code. That specificity matters.

**Friction points:** None mechanical. The consent dialog required me to toggle on AI Suggestions first — I had to go to Settings, enable it, come back. That's friction I didn't expect.

*(Note: on first use, the app prompts consent inline on the action screen — I'm interpreting that the toggle is handled within the consent dialog. If the Settings page is actually required first, that's a barrier.)*

---

### CreateCardConfirmScreen

**First impression:** My card: "Read the first function signature in the starter code." I can do that. It'll take thirty seconds.

**Copy and tone:** "Ready for your tiny start?" — I'm past evaluating this phrase. I just tap [Start now].

"You can stop after that or keep going." — I notice this and feel relief. I'm not committing to the whole assignment. I'm committing to reading one function signature.

---

### Timer Screen — Running

**First impression:** Full screen. Task. Countdown. Dot.

**Cognitive load:** Zero. There's nothing here. My phone is the timer. I go to my laptop and open the starter code while the timer runs.

**Emotional response:** Within the first 30 seconds, I'm reading the function signature. By 1:00, I've read the second one. By 2:00, I've written a comment that says what the first function should return. I've started.

**The pulsing dot:** I barely notice it. The timer is peripheral and I'm working. That's the right outcome.

**Friction points:** My phone is in my hand while I'm at my laptop. If I'm working at a laptop, having the timer on my phone is slightly awkward — I'd need to prop it up or glance at it. A minor ergonomic note.

---

### Timer Screen — Complete + Explainer

**First impression:** "You hit your 2 minutes." — I did. And I also wrote a comment. The two minutes is done. I can keep going or stop.

**[Keep going]:** I tap it. I'm writing the second comment.

**Explainer Sheet:** "The hardest part isn't the doing — it's deciding to begin. You just did that." I stop and read this. I've been in this pattern for three years of my academic life — knowing I should start, not being able to, doing it in a panic — and this is the first time a piece of software has named the actual problem. I feel something like recognition.

**Emotional response:** More than I expected. Not over the top. Just a quiet "yes, that's exactly it."

---

### Deck View

**First impression:** My card. Clean. Simple. A count says "1."

**Visual hierarchy:** Nothing competing for attention. I notice the [+] FAB. I notice the [⚙] settings icon and the [⊟] icon (don't know what that one does yet).

**Interactive affordances:** I don't explore much. I'm in "it worked" mode, not "let me learn the features" mode.

---

### Add Method Sheet

I return a day later to add another card.

**First impression:** [🎤 Use voice] and [✏️ Type it]. I try voice — I think out loud when I'm stressed and maybe the voice thing will be useful.

**Copy and tone:** Clean, minimal labels. The icons are clear.

---

### VoiceAISuggestionsScreen

I speak for about 25 seconds about the bio lab report, a group project presentation, and the data structures assignment again (it's not done yet).

**First impression:** Three extracted items. "Here's what I heard / Pick what to work on." The items are: "Finish data structures assignment," "Write bio lab report," "Prepare group project presentation." These are accurate but they're the full tasks, not broken down.

**Copy and tone:** "Here's what I heard" is good — it's accurate.

**Cognitive load:** Moderate. The checklist makes me re-evaluate which is most urgent. I uncheck the group project (it's not until next week) and leave two checked.

**Friction points:** Two checked items means I have to go through two complete creation flows afterward. By the time I'm on the second one, I've lost the momentum from the voice input. I tap through the goal and action screens faster on the second one, which means the AI suggestions don't help as much because I'm rushing.

**Missing elements:** A way to carry the AI action suggestions from the voice extraction through to the card creation screens, so I don't have to re-generate them. If the AI already knows my task is "Write bio lab report," why does the action screen ask me to generate a first step from scratch?

---

### Settings

**First impression:** Two toggles. I turn on AI Suggestions. I look at Fresh Start.

**Fresh Start copy:** "Start each day with a blank deck." — first reaction: wait, it will delete my cards? Then I read the rest: "Yesterday's cards move to Past Days." Okay. Still cautious. I don't turn it on.

**Emotional response:** The absence of streaks is a relief. Duolingo's streak system has broken me three times. I don't want that here.

---

### Just One Mode

I find this on day three, when I have four cards and feel the familiar overwhelm of looking at all of them.

**First impression:** One card. [Start] and [Not today]. Oh. This is the thing.

**Emotional response:** I feel the tension of four tasks evaporate when the screen shows me just one. The one task doesn't feel like four tasks. I tap [Start].

**Delights:** "Not today" is exactly right. It's not "dismiss" or "skip." It's a real sentence I can say to myself.

**Friction points:** I had to find this accidentally. The [⊟] icon told me nothing. If this mode wasn't discoverable by accident, I might never have found it.

---

### Archive Prompt

Simulated after deferring the group presentation card multiple times:

**First impression:** "You've set this one aside a few times. Want to rest it for now?" — This is the gentlest possible prompt for this action. Not "You've ignored this task." Not "This card is overdue." "Set it aside."

**Emotional response:** I feel seen without feeling judged. The app noticed what I was doing without interpreting it as failure. That's important.

---

## Post-Session Questions

1. I opened something with no account, answered a direct question about what I'm avoiding, was given a first step by an AI that actually understood my situation, set a two-minute timer, and started the assignment. That's it. The assignment is now partially done. This is not something I could have predicted an hour ago.

2. At "What feels big and difficult?" — I almost typed "everything" and then realized I needed to pick one thing. That transition — from "everything" to "one thing" — is the hardest cognitive move in the app and the screen doesn't help with it.

3. No pressure. No shame. The only moment of external pressure was the Discord notification during the timer, but that's not this app.

4. When I tapped [Add selected] after voice input — I expected to land on a summary screen where I could review all the cards I was about to add. Instead I went through two creation flows. That was unexpected.

5. A to-do list is everything at once. This is one thing at a time. The constraint is the point. I've made to-do lists my whole academic life and they've never helped me start anything. This app started something.

6. If the same multi-urgency paralysis happens again, which it will. Probably tomorrow.

7. "I'm stuck — show ideas" giving me a correct, specific first step. I expected something generic like "break the task into smaller pieces." I got "read the first function signature." That's actually the right answer.

8. Fresh Start mode. I can't afford to have cards disappear, even temporarily.

9. "It's for when you have too much to do and you can't start any of it. You tell it one thing you're avoiding. It makes the first step tiny. You do two minutes. You've started. There's no other thing it does."

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS | Flow completed; no expressed fatigue |
| F2 — Value Blindness | PASS | Clearly articulated the app's specific value proposition |
| F3 — Timer Abandonment | PASS | Used [Keep going]; timer felt appropriately scoped |
| F4 — Voice Input Cognitive Load | FLAG | Voice extraction worked; but 2 checked items → 2 full creation flows lost momentum; described as unexpected and frustrating; also noted that action suggestions should carry through from extraction rather than being regenerated |
| F5 — Fresh Start Misfire | FLAG | Initial alarm at "blank deck" language; resolved but cautious enough to not turn it on; represents incomplete trust in the feature |
| F6 — Deck Overwhelm | FLAG | Four-card deck triggered the same multi-urgency paralysis the app was supposed to solve; Just One Mode was the rescue but wasn't discovered until day three; the deck view with 4 items is genuinely overwhelming for this persona |
| F7 — Emotional Framing | PASS | No shame triggered; Explainer Sheet produced recognition |
| F8 — Universal Utility | PASS | Correctly identified app as a specific tool for a specific problem |
| F9 — Environmental Trap | FLAG | Discord notification arrived during timer; phone-as-distraction is structural for this persona; explicitly described as a risk |
| F10 — Working Memory | FLAG | "What feels big and difficult right now?" nearly triggered the multi-task spiral; persona arrived with multiple urgent tasks and had difficulty selecting just one; resolved by force of circumstance (most urgent deadline), but this is a real working memory prerequisite |

---

## Overall Assessment

**Strongest moments for this persona:**
- "I'm stuck — show ideas" producing a task-specific, correct first step — this is the feature that converted this persona; the AI understood "data structures assignment" well enough to suggest "read the first function signature," which is precisely right
- Timer Screen constraint producing actual output — Eli started writing code within two minutes; the mechanism worked exactly as designed
- Explainer Sheet — "The hardest part isn't the doing — it's deciding to begin" named the pattern Eli has been living for three years; this moment produced genuine recognition

**Biggest friction points:**
- "What feels big and difficult right now?" + blank field for a user with 3+ simultaneous urgent tasks: the question requires the selection Eli can't make; without a scaffold for that selection, the blank field risks becoming another paralysis point
- VoiceAISuggestionsScreen → serial creation flow: flagged as the most jarring discontinuity; "why does the action screen ask me to generate a first step if the AI already knows my task?"
- Deck view with 4+ cards triggers the same multi-urgency overwhelm the app is meant to solve; Just One Mode is the fix but its discoverability path is insufficient

**Likelihood to return:** High
Every structural condition that brought Eli to MicroDeck will recur tomorrow. The first session worked. Return is driven by need — which is perpetual.

**The one change that would most improve this persona's experience:**
When the user arrives at CreateCardGoalScreen with the keyboard open and doesn't type for 5+ seconds, show a subtle prompt: "Having trouble picking one? Write the thing with the nearest deadline." — this provides a concrete decision rule that breaks the multi-urgency paralysis without restructuring the screen.
