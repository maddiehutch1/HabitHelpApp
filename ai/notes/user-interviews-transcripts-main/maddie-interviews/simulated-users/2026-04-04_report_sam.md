# UX Review Report — Sam, The Burnout Professional

**Persona file:** aiDocs/userResearch/persona4.md
**Date:** 2026-04-04
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: Responding to a client email that contains a complaint I need to address carefully. It came in four days ago. Every morning I open it, read the first sentence, and close the email app.
2. What made it hard: The reply requires careful framing. I can't dash it off, but I also can't seem to allocate the mental space to do it carefully. Every time I try, something interrupts — another email, a Slack message, myself. My attention has a hole in it.
3. What I usually do: Move the email to a "follow up" folder. Add a calendar block for "email response." Delete the calendar block. Reorganize the follow-up folder. The email is still there.

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen

**First impression:** Clean. No clutter. I've seen cleaner and I've seen worse. My first check is for the thing that will waste my time — a progress wizard, a tutorial overlay, a "connect your calendar" prompt. None present. Acceptable.

**Copy and tone:** "Start the thing you keep putting off." Hmm. The directness is appropriate. It doesn't reach for metaphor. "One card. Two minutes. That's it." — "That's it" is a bit of a claim. I'll hold that for evaluation.

**Clarity of purpose:** Partially clear. I understand that I'm going to make a card and use a timer. I don't yet understand how this differs from a Pomodoro app with extra steps.

**Cognitive load:** Zero. The screen asks nothing of me.

**Interactive affordances:** One button. I tap it.

**Friction points:** None. I don't linger.

---

### CreateCardGoalScreen

**First impression:** Text field. Prompt. Keyboard appears. Efficient.

**Copy and tone:** "What feels big and difficult right now?" — I'm a project manager. I'm not someone who uses the word "feels" professionally. The framing is slightly soft for my register. Not offensive, but not the voice I use when I'm working. I'm tempted to type a task title the way I'd write it in Jira: "CMPL-3482 Draft client escalation response." I don't, because the question is pointing at something else.

**Emotional response:** A brief beat where "feels big and difficult" lands differently than I expected. The email. I type "Respond to client complaint email." Move on.

**Cognitive load:** Low. I have a clear answer.

**Friction points:** The framing "what feels" may read as therapy-speak to a user who identifies professionally rather than emotionally. Not a hard blocker — I work through it — but it creates a brief register mismatch.

---

### CreateCardActionScreen

**First impression:** My goal is preserved at the top. Good. I know where I am.

**Copy and tone:** "What's one tiny step you could take first?" — "Tiny" again. I find this framing slightly patronizing the second time I encounter it. I'm a senior PM. I know how to break down tasks. The app doesn't know I'm not here because I lack planning skills; I'm here because I lack the mental resource to execute on plans I've already made. The copy doesn't distinguish between these.

**My input:** "Write one sentence to acknowledge the issue." That's my first step and I know it without assistance.

**Interactive affordances:** I notice "I'm stuck – show ideas" and "Make this smaller." I don't use either. I'm not stuck; I'm depleted. There's a difference.

**Cognitive load:** Low. I generate my action quickly.

**Friction points:** "Think in terms of 2 minutes or less. Smaller is better." — This subtext feels mildly condescending for someone whose problem is not understanding task decomposition. The app is designed for people who don't know how to make tasks small; I know how to make tasks small but can't execute on even the small version. The guidance misdiagnoses my problem.

**Missing elements:** Nothing needed from me mechanically. But I note that the AI features on this screen assume a user whose blocker is task-definition. My blocker is execution. The features are irrelevant to me specifically, but they don't hurt.

---

### CreateCardConfirmScreen

**First impression:** My card, rendered. "Write one sentence to acknowledge the issue." This looks reasonable.

**Copy and tone:** "Ready for your tiny start?" — I note "tiny" for the third time and make a mental note that the product is over-committing to this word. The copy under it — "You're just giving this 2 tiny minutes. You can stop after that or keep going." — is actually good. The explicit exit permission is the right design choice for someone with commitment fatigue.

**Interactive affordances:** [Start now] vs [Save for later]. I choose [Start now]. I gave myself ten minutes to evaluate this app and I'm inside that window. Let's see what happens.

---

### Timer Screen — Running

**First impression:** Task text. Countdown. Dot. Full screen.

**Copy and tone:** Nothing to read. Correct.

**Emotional response:** The first 30 seconds are normal. I'm staring at "Write one sentence to acknowledge the issue" and my brain is... doing something. Not thinking directly about the sentence, but assembling context. The phrase "acknowledge the issue" is doing work — it's removing the pressure to solve the problem and replacing it with a simpler task: acknowledge. By minute 1:00, I have a sentence in my head.

**The pulsing dot:** I'll be honest — I expected this to be annoying. It's not. It's subtle enough to be ambient rather than distracting. I wouldn't have designed it, but I won't criticize it.

**Cognitive load:** The screen's minimal design actually helps. There are no choices, no escapes, no competing inputs. My brain has nothing to do except work on the task. That's a design outcome, not an accident.

**Friction points:** None.

---

### Timer Screen — Complete + Explainer

**First impression:** "You hit your 2 minutes." I did. I also have a sentence written (mentally) and I want to send the email now.

**Copy and tone:** "You hit your 2 minutes." — This is the correct register for me. No celebration. No trophy. A statement of fact. I respect this.

**[Keep going] vs [Done]:** I tap [Keep going] immediately. I'm not done; I've started. This is the right mechanic. The timer resets. I spend another two minutes drafting the rest of the opening paragraph in my head. Then I tap [Done] and go open my email client.

**The Explainer Sheet (first completion):** "The hardest part isn't the doing — it's deciding to begin. You just did that." I read this. My first reaction is mild resistance — "I know this." My second reaction is: yes, but you just demonstrated it. The app didn't tell me something I didn't know; it gave me a concrete recent example of something I already knew. That's different.

**Emotional response:** Not quite moved, but something. Useful friction between what I know intellectually and what I experienced two minutes ago.

---

### Deck View

**First impression:** My card is there. Simple.

**Visual hierarchy:** Clean. The settings icon is where I expect it. The FAB is standard.

**Interactive affordances:** I tap settings within 30 seconds. This is my nature.

**Friction points:** None with one card. The "Just One" icon [⊟] is not obvious. I tap it after a beat of curiosity.

---

### Add Method Sheet

I return after a week to add a second card.

**First impression:** Voice and type. I choose type immediately. I have no interest in speaking aloud.

**Cognitive load:** Negligible.

---

### VoiceAISuggestionsScreen

Skipped — I would not use voice input. This is not how I work.

---

### Settings

**First impression:** Two toggles. My first reaction is: is this unfinished? My second reaction — which arrives within three seconds — is: no, this is a deliberate product choice. I've seen enough software to tell the difference between incomplete and minimal.

**Copy and tone:** "Fresh Start mode — Start each day with a blank deck. Yesterday's cards move to Past Days." Clear. I understand immediately.

"AI Suggestions — Get ideas when you're stuck creating tasks. Sends text to OpenAI." The data disclosure is correct and I respect it. I toggle AI Suggestions on. I want to test the "I'm stuck" feature properly.

**Emotional response:** The absence of notification settings, theme options, and data management tells me something intentional about the product's philosophy. This app is not trying to optimize my life. It's trying to interrupt my stuckness. Those are different products.

**Delights:** Two settings. Just two. The restraint communicates trust in the core product.

---

### Just One Mode

I tap [⊟] while managing a deck of four cards during week two.

**First impression:** One card. [Start] and [Not today].

**Copy and tone:** "Not today" is appropriate for me. It doesn't accuse. It just accepts the decision.

**Clarity of purpose:** Immediately clear. I don't need an explanation.

**Cognitive load:** The lowest decision environment in the app. For a depleted brain, this is genuinely the right reduction. I stop asking "which of four things should I do?" and just evaluate one.

**Delights:** The mode works as advertised. I tap [Start] without deliberation.

**Friction points:** The [⊟] icon needed me to tap it to understand what it did. Label or tooltip on first encounter would help.

---

### Archive Prompt

I encounter this after neglecting a card for two weeks (the "draft quarterly review" card that I added and then stopped looking at).

**First impression:** "You've set this one aside a few times. Want to rest it for now?" — I parse this practically. Rest it, keep it. I read the copy and make a decision without emotional friction.

**Copy and tone:** For me, the non-judgmental framing is good but I'd notice it neutrally rather than with relief. I don't carry the shame load that would make "rest" vs. "archive" a meaningful distinction emotionally. The practical question is: can I get it back if I need it? Answer is yes (Past Days). I tap [Rest it].

**Delights:** The design insight of the Archive Prompt is that it lets the app maintain itself without requiring the user to curate. The deck doesn't silently accumulate dead weight. Smart.

---

## Post-Session Questions

1. I created a card for a task I've been avoiding. I ran the timer. Somewhere in that two minutes I assembled the mental resources I'd been unable to mobilize. After the session, I went and sent the email. That's a clean causal chain. The app earns credit for that outcome.

2. Nothing mechanical. The question "What feels big and difficult right now?" was slightly soft for my register but not confusing.

3. No. One borderline moment: "tiny" used repeatedly. I read this as either condescending or designed for a different user. Not actually pressuring, but mildly grating.

4. When I tapped [Keep going] — I expected it to ask me if I wanted to do the same task or pick a new one. It just restarted the timer. Correct call. I didn't need to be asked.

5. Very different. A to-do list is a ledger of obligations. This app is a scaffold for initiation — it's designed for the specific gap between knowing and doing. I use to-do lists constantly. They don't help with this problem. This does.

6. If the first session produced a real result. It did. Condition met.

7. Two things: [Keep going] extending the timer without navigation overhead — I expected more friction. And the Explainer Sheet — I expected it to be hollow. It wasn't.

8. The AI suggestion features on the action screen. I know how to decompose tasks. The AI buttons are for someone with a different problem.

9. "It's for when you know what you need to do and your brain won't let you start. It makes you pick one thing and commit to two minutes. It's a very specific tool. If your problem is different from that, it won't help. If your problem is exactly that, it's the best thing I've found."

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS | Flow efficient and well-weighted; no drag |
| F2 — Value Blindness | PASS | Gave a precise, unprompted articulation of the value proposition |
| F3 — Timer Abandonment | PASS | Proactively used [Keep going]; timer framing worked for this persona |
| F4 — Voice Input Cognitive Load | N/A | Did not use voice input; not consistent with persona's work style |
| F5 — Fresh Start Misfire | PASS | Understood Fresh Start immediately; no alarm |
| F6 — Deck Overwhelm | PASS | Used Just One Mode proactively when deck grew |
| F7 — Emotional Framing | FLAG | "Tiny" used three times across the creation flow registered as condescending for a user who identifies as a high-functioning professional; not a hard failure, but a tone mismatch |
| F8 — Universal Utility | PASS | Identified the app's specific use case precisely; did not express that it added friction for easy tasks |
| F9 — Environmental Trap | PASS | No phone-distraction issues; session completed with focus |
| F10 — Working Memory | PASS | Arrived with a specific, concrete task in working memory |

---

## Overall Assessment

**Strongest moments for this persona:**
- Timer Screen (Running) — the constraint of nothing-to-do-except-the-task produced the actual cognitive state shift needed; this is the core mechanic working on a depleted-but-capable user
- [Keep going] on the completion screen — zero friction to extend the session; correct UX decision for a user who was in flow
- Settings screen — two toggles read as principled minimalism to a professional evaluator; earned respect, not confusion

**Biggest friction points:**
- "Tiny" used three times across Goal/Action/Confirm screens: for a professional user who doesn't identify with impairment but with situational burnout, repeated use of "tiny" lands as talking-down; consider varying the vocabulary ("small," "one step," "quick") to avoid the accumulation effect
- AI features on CreateCardActionScreen are irrelevant for users whose blocker is execution rather than task-definition; not a friction point per se, but the copy ("I'm stuck") misdiagnoses some users' problems

**Likelihood to return:** High
Because the first session produced a direct, measurable outcome — sent the avoided email — within the 10-minute evaluation window. This persona's return criterion was explicitly the session producing a tangible result. It did.

**The one change that would most improve this persona's experience:**
Vary the use of "tiny" across the creation flow — use it once (on the action screen, where it earns its place) and replace the other two instances with adjacent vocabulary ("small step," "2 minutes"), reducing the accumulation effect that lands as condescending for capable users who aren't in crisis.
