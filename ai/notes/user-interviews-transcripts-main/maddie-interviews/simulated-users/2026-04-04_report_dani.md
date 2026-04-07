# UX Review Report — Dani, The Crisis Mode User

**Persona file:** aiDocs/userResearch/persona3.md
**Date:** 2026-04-04
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: Calling the pharmacy about the Vyvanse shortage. They had it two weeks ago and then they didn't. I need to call three other pharmacies to see who has it. I've had the phone numbers on a sticky note on my fridge for eight days.
2. What made it hard: Making phone calls is hard on a good day. Making phone calls that involve explaining a medication situation to a stranger who might be dismissive is very hard. And every day I don't call, getting to the point of calling gets harder. I'm in a loop.
3. What I usually do: I take a photo of the sticky note so I don't lose it. I put "call pharmacy" in my alarm list. Then I walk past the fridge and see the note and feel tired.

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen

**First impression:** White. Quiet. I don't process a lot of it. I'm looking for something to do, somewhere to tap.

**Copy and tone:** "Start the thing you keep putting off." — I don't read this fully. I register it. It feels relevant but I'm not in a state where text lands deeply. "One card. Two minutes. That's it." — The numbers help. Two minutes is a time frame I can hold.

**Clarity of purpose:** I don't fully understand what the app is yet. But I don't need to understand it — I need somewhere to go. The button says "Let's begin" and that's enough.

**Cognitive load:** Very low on this screen. Nothing to fill out. Nothing to read carefully. One button.

**Interactive affordances:** [Let's begin →] is clear and large. I tap it without much deliberation.

**Delights:** The absence of anything to configure. I have zero bandwidth for settings at this stage.

---

### CreateCardGoalScreen

**First impression:** A text field and a question. The keyboard comes up automatically. That's the right call — it moves me forward without requiring another tap.

**Copy and tone:** "What feels big and difficult right now?" — On a good day, this question might resonate. Today — or the day I'm simulating — I'm in freeze mode and the question is almost too large. "What feels big and difficult" is... everything. The whole week. The pharmacy. The burnout. Getting out of bed.

**Cognitive load:** Moderate to high. This is the highest cognitive load moment for me in the app. Not because the interface is demanding — the interface is simple — but because the question asks me to do something my brain isn't currently capable of: identify and prioritize a specific task from the pile.

**Emotional response:** I stall for about 20 seconds. I'm not choosing between options, because the options feel like they're all weighted the same. This is the freeze pattern in action. Then I type "pharmacy calls" because the sticky note is right there in my peripheral memory.

**Friction points:** The question "What feels big and difficult right now?" combined with a blank field is the point in this flow where freeze mode users are most at risk. I made it through because the pharmacy task was nearby in memory. On a harder day, I might not have an answer ready.

**Missing elements:** Something that gently scaffolds users who freeze here — a second, smaller question if the first field stays blank for more than a few seconds ("Or: what's one thing you keep putting off?") — might help. Alternatively, a visible path to voice input from this screen would serve me better than typing.

---

### CreateCardActionScreen

**First impression:** My goal text is at the top: "pharmacy calls." Good — I don't have to remember it.

**Copy and tone:** "What's one tiny step?" — I can work with this. The specific question is better for me than the open question. "One tiny step" is constrained in a way that "what feels big and difficult" is not.

**Voice option:** In my session, I actually tap the [+] FAB from the deck view and choose [🎤 Use voice] instead of continuing with typing. But since I'm simulating the primary path first: I type "call the first pharmacy on the list." That's a real step. Smaller would be "find the first phone number" but I don't know how to make it smaller right now.

**Interactive affordances:** I see "I'm stuck – show ideas" but I don't use it on this screen. I don't think to. In freeze mode, I'm not in exploration mode — I'm in survival mode. The button is there but I don't register it as useful to me right now.

**"Make this smaller":** I do use this, after typing my action. The result: "Read the first phone number on the sticky note." Yes. That's the actual first step. Something loosens slightly. I tap that chip.

**Cognitive load:** Lower than the goal screen. The constrained question is more workable.

**Delights:** "Make this smaller" produced a genuinely useful result. The app understood that "call the pharmacy" is too large and gave me something real to do instead.

---

### CreateCardConfirmScreen

**First impression:** My card: "Read the first phone number on the sticky note." That's a real thing. I can do that in ten seconds.

**Copy and tone:** "Ready for your tiny start?" doesn't land strongly one way or the other for me. I'm not reading copy deeply right now. But "You're just giving this 2 tiny minutes. You can stop after that or keep going" — I process this. Two minutes. Stop after if needed. I tap [Start now].

**Cognitive load:** Low. The choice between [Start now] and [Save for later] is clear. [Start now] is the only one that makes sense.

---

### Timer Screen — Running

**First impression:** Full screen. My task text. A countdown. A dot.

**Emotional response:** Something happens when the screen fills and the back button disappears. I feel contained. The right kind of contained. Like there's nowhere to spiral to. The task is there. The time is counting. The dot is breathing. I'm not inside my head — I'm inside this screen.

**The pulsing dot:** I focus on it more than on the countdown. The countdown number changing is slightly anxious-making. The dot is steadier. I don't consciously decide to look at the dot; it just happens.

**Cognitive load:** Near zero. This is the right screen for me. No text to process. No decision to make. Just the dot.

**Friction points:** None. The wakelock matters — my screen goes dark quickly and on another app this would break the flow. Here, it stays on.

**Delights:** The back gesture being blocked. I don't usually notice back gestures. But in freeze mode, there's a reflex to exit anything demanding. The block removes that option without being punishing — it's just... the screen. The screen is the place.

---

### Timer Screen — Complete + Explainer

**First impression:** "You hit your 2 minutes." I did. That feels larger than it is, because two minutes of being unstuck is longer than the eight days I spent looking at the sticky note.

**Copy and tone:** Flat. True. No celebration. "You hit your 2 minutes." Something in my chest releases very slightly.

**The Explainer Sheet:** "The hardest part isn't the doing — it's deciding to begin. You just did that." I read this and feel something. Not pride. More like: the weight of the thing being accurately named. I'm very tired. Deciding to begin is exhausting in a way people don't understand. This sentence understands.

**Emotional response:** Disproportionate relief. This is specific to the severity of my executive dysfunction. A high-functioning user might feel mild satisfaction. I feel something closer to gratitude.

**Delights:** The Explainer Sheet showing on first completion is a good design decision. It reframes what just happened. I needed that reframe.

---

### Deck View

**First impression:** My card. "Read the first phone number on the sticky note." I look at it and then feel the pull to go do that — to look at the actual sticky note, which is a real thing in my real kitchen.

**Visual hierarchy:** Simple. Clean. One card.

**Friction points:** The deck is fine with one card. A growing deck will be an issue — more on that in the assessment.

---

### Add Method Sheet

I tap the FAB after a few days (simulating return) to add a second card. I choose [🎤 Use voice] this time.

**First impression:** Two clean buttons. Voice and type. No description of what each does beyond the label. I trust the icons — microphone and pencil — to carry the meaning.

**Cognitive load:** Very low.

---

### VoiceAISuggestionsScreen

I hold the phone up and speak: "I have to call the pharmacy again, and I need to call the doctor about the Vyvanse, and I forgot to text my coworker back, and I was supposed to mail something three days ago."

**First impression:** The screen shows four extracted items — all four things I said, roughly verbatim. The headline says "Here's what I heard / Pick what to work on." I understand what I'm looking at. I didn't expect to.

**Copy and tone:** "Here's what I heard" is exactly the right framing. It doesn't say "Here are your tasks." It says: I listened, here's what I got, you tell me what to do with it. That respects my agency in a way that doesn't increase my load.

**Interactive affordances:** Four checkboxes, all checked by default. I uncheck "text my coworker back" — it's not something I can do from inside this app or right now. I leave three checked.

**Cognitive load:** Moderate but manageable. The act of reviewing and unchecking is more tractable than typing four things would have been. Voice was the right input mode for this state.

**Friction points:** The [Add selected] routing each item through the full creation flow (goal → action → confirm) is a real problem. Three items means three goal screens, three action screens, three confirm screens. By the second pass, I've lost momentum. By the third, I'd have stopped.

**Emotional response:** The voice extraction felt like a small miracle. That it then routes me through three complete creation flows diminishes the miracle significantly.

**Missing elements:** A batch-confirm option that creates all selected cards at once, without requiring full per-card creation flow navigation, is critical for this persona. The voice input method's value is entirely undermined by the per-card follow-up burden.

---

### Settings

**First impression:** Two toggles. I don't read them in detail.

**Fresh Start:** I turn this on eventually, on day three of my simulated use. The description tells me cards go to Past Days. I feel a brief spike of alarm — where do they go? — and then I read "Past Days" and relax. They're not deleted.

**Emotional response:** The alarm and recovery is worth noting. "Start each day with a blank deck" sounds like deletion to someone who's already worried about losing things. The second sentence ("Yesterday's cards move to Past Days") is essential and needs to be seen before the alarm registers.

**Friction points:** The toggle label alone ("Fresh Start mode") does not communicate what happens to existing cards. A new user who turns it on without reading the full description might genuinely panic.

---

### Just One Mode

I discover this after the deck grows to four cards. I tap [⊟] by accident.

**First impression:** One card. One card. Just one card.

**Emotional response:** I say this plainly: Just One Mode is the screen this app should probably default to for me. The deck view with multiple cards is manageable when I have bandwidth. When I don't — when it's a freeze day — the deck view with four items is already too many items. Just One Mode is better. The single card, centered, with two choices, is the simplest possible version of the app's core offer.

**Delights:** [Not today] cycling to the next card without judgment is exactly right. I can say "not today" to three things and it doesn't make me feel like I've failed three times. It feels like I've had three honest conversations.

**Missing elements:** I wish this was more discoverable. The [⊟] icon was opaque to me. I'd benefit from Just One Mode being surfaced when the deck grows — even a subtle "deck feeling big? Try Just One" prompt would help.

---

### Archive Prompt

Simulated after deferring two cards multiple times over a week.

**First impression:** "You've set this one aside a few times. Want to rest it for now?" — I exhale. I expected the app to judge me. It doesn't.

**Copy and tone:** "Rest it" is the right word. Not "archive." Not "dismiss." Rest. The card isn't gone. It's resting. I'm resting too, maybe.

**Emotional response:** There are tears that don't fully form, which tells me the emotional accuracy of this screen is real. That's unusual feedback for a modal dialog. It is that accurate.

---

## Post-Session Questions

1. I opened something. It asked me one question I almost couldn't answer, and then I answered it. It gave me a timer. I sat with the timer and the dot. Two minutes happened. I was less frozen at the end than I was at the start. That's the whole thing. That's enough.

2. At "What feels big and difficult right now?" — I was close to frozen. The blank field and the open question were the hardest combination for me.

3. No. Not once. And I want to say how unusual that is. Most productivity apps make me feel like I'm failing at using a tool designed for competent people. This one didn't.

4. When I first tapped the voice button — I expected it to be confusing, like Siri when I'm trying to set an alarm and it opens a browser instead. It worked. That surprised me.

5. A to-do list is a thing I write and never look at again. This app makes me sit with one thing for two minutes and then it's done. I didn't have to look at the rest. Just one thing.

6. If it doesn't make me feel bad when I haven't opened it in three days. The app itself doesn't do that — no badges, no guilt prompts. So the answer is: yes. I'd open it again.

7. The Archive Prompt. "Rest it." I expected to be judged. I wasn't.

8. Settings and just everything below the deck, honestly. I use the core loop and that's it. That's fine. That's the right thing for an app like this to support.

9. "It's for when you're frozen and can't start anything. You say what you can't start, it makes it tiny, you do two minutes. Then it's done. Sometimes that's enough."

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS | Primary flow completed; no abandonment |
| F2 — Value Blindness | PASS | Articulated core difference clearly |
| F3 — Timer Abandonment | PASS | Timer was the best screen in the app for this persona; full acceptance |
| F4 — Voice Input Cognitive Load | FLAG | VoiceAISuggestionsScreen worked well; but [Add selected] routing 3 tasks through 3 full creation flows lost momentum by task 2; the extraction UI worked, the downstream flow didn't |
| F5 — Fresh Start Misfire | FLAG | Brief alarm on first exposure to "blank deck" framing; resolved after reading second sentence, but the initial reaction was genuine panic |
| F6 — Deck Overwhelm | FLAG | Four-card deck felt like too many for freeze-day state; Just One Mode was the rescue, but it's not discoverable enough for this to be reliable |
| F7 — Emotional Framing | PASS | No shame triggered; Archive Prompt and timer copy were both emotionally accurate |
| F8 — Universal Utility | PASS | App clearly appropriate for this persona's specific need |
| F9 — Environmental Trap | PASS | No mention of phone-as-distraction; focus held throughout |
| F10 — Working Memory | FLAG | "What feels big and difficult right now?" nearly caused breakdown for a persona in freeze mode; pharmacy task was in working memory but just barely; on a harder day this session wouldn't have succeeded |

---

## Overall Assessment

**Strongest moments for this persona:**
- Timer Screen (Running) — the pulsing dot, wakelock, back-blocked full-screen was the most valuable environment in the app; it contained the session in exactly the right way
- Archive Prompt — "rest it for now" was experienced as genuine emotional accuracy, not UX copy
- Just One Mode — the right default for severe executive dysfunction; single card, two options, no visible pile

**Biggest friction points:**
- CreateCardGoalScreen: the blank field + open-ended question is the highest-risk moment for freeze mode users; a fallback scaffold or visible voice option here would reduce the chance of pre-flow abandonment
- VoiceAISuggestionsScreen → serial creation flow: critical friction; the voice input gained a user, the downstream per-card flow lost them

**Likelihood to return:** High (conditional)
If the primary flow stays as simple as it is and the voice-to-serial-creation friction is reduced. Return is likely because the app produced a real result and didn't produce shame — two things most tools fail at for this persona.

**The one change that would most improve this persona's experience:**
Reduce the VoiceAISuggestionsScreen [Add selected] flow to a single batch confirm screen — show all checked tasks as cards simultaneously and create them all at once — removing the 3× navigation overhead that undermines everything voice input achieved.
