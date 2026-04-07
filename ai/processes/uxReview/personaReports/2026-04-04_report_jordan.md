# UX Review Report — Jordan, The High-Functioning Avoider

**Persona file:** aiDocs/userResearch/persona1.md
**Date:** 2026-04-04
**Simulated by:** AI agent

---

## Pre-Session Context

1. Recent task I couldn't start: Writing a product teardown for a client presentation that's due in four days. I have twelve browser tabs open about it, a Notion doc with headers and no body text, and three competing outlines I can't choose between.
2. What made it hard: I can't start because I haven't decided on the "right" structure yet. And I won't be able to decide on the structure until I've done enough research. And I haven't started the research because... the structure isn't ready.
3. What I usually do: Open a new doc, write "OUTLINE v4," and then reorganize my browser tabs for forty minutes. Sometimes I clean my desk. Sometimes I build a new template that I'll use on the *next* project.

*Okay — keep that in mind. Now I open MicroDeck.*

---

## Screen-by-Screen Review

### Welcome Screen

**First impression:** My first instinct is to check if this is the real thing or a landing page that opens to a registration wall. It's not. That earns a point immediately.

**Copy and tone:** "Start the thing you keep putting off." That's direct. It landed in my chest in a way I didn't expect — like someone read my search history. "One card. Two minutes. That's it." Okay. I'm a little skeptical — "that's it" feels like something you say before you add "...but first, complete your profile." Let me see if they mean it.

**Visual hierarchy:** Clean. My eye goes straight to the headline, then the button. No competing elements. I'm genuinely relieved there's no mascot, no confetti, no "🎉 Welcome to MicroDeck!" I've seen too many onboarding screens that feel like a party I didn't ask to be invited to.

**Interactive affordances:** One button. I respect the restraint. My hand is already on it before I've finished reading.

**Cognitive load:** Near zero. This is the right call. Any setup form at this stage would have lost me.

**Friction points:** None on this screen. I tap through before I've had a chance to second-guess it, which is exactly what this screen should do.

**Delights:** The copy is tight. Whoever wrote "Start the thing you keep putting off" knows their user. That phrase is less of a tagline and more of a diagnosis.

---

### CreateCardGoalScreen

**First impression:** *"What feels big and difficult right now?"* I pause. Not because I don't know the answer — I know it exactly — but because the question is more honest than I was prepared for.

**Copy and tone:** This question is doing a lot. "Big and difficult" could read as accusatory — like you're being asked to confess your incompetence. For me it doesn't, because I've done enough therapy to know my avoidance patterns. But I can imagine this landing badly for someone with less self-awareness. The placeholder text, "Write my 15-page research paper," is well-chosen: it models the right grain size without being prescriptive.

**Clarity of purpose:** Completely clear. I know what I'm supposed to do.

**Interactive affordances:** The field autofocuses and the keyboard comes up immediately. Good — no extra tap required. The disabled [Next →] button makes sense and I don't feel confused by it; I know what's needed.

**Cognitive load:** Low to moderate. The question itself is slightly demanding — I do have to think about it. But I type "Write the client teardown" quickly enough that I don't stall.

**Emotional response:** That moment of pause is worth noting. The question made me feel briefly seen and briefly exposed at the same time. That's not a bad design outcome — it's exactly the kind of pattern interrupt the app is trying to create. But it won't work the same way every time. On a day when I'm in deep avoidance and the shame is high, I might freeze here.

**Friction points:** None mechanical. Emotional friction exists but is probably intentional.

**Delights:** The example in the placeholder isn't generic ("untitled task"). It's specific and slightly heavy — "Write my 15-page research paper" — which tells me this app was designed for *my* kind of problem, not for making shopping lists.

---

### CreateCardActionScreen

**First impression:** The context label showing my goal at the top is smart. It keeps me anchored. Without it, I'd be holding "Write the client teardown" in working memory while trying to answer a new question — and that's exactly the kind of cognitive double-booking that loses me.

**Copy and tone:** "What's one tiny step you could take first?" The word "tiny" is doing serious work here. I've heard this advice before — from therapists, books, ADHD content creators. It usually lands as obvious and therefore useless. Here, because I'm already inside the tool and because I've just typed my goal, it lands differently. It feels like a prompt with teeth rather than generic advice.

"Think in terms of 2 minutes or less. Smaller is better." — This is excellent copy. It sets a concrete constraint without making me feel managed.

**Interactive affordances:** Two text buttons mid-screen — "I'm stuck – show ideas" and "Make this smaller." The placement is a bit ambiguous. They read like links more than buttons. I know they're interactive because I'm a UX designer, but someone else might scan right past them.

**Cognitive load:** Moderate. This screen asks for creative output — I have to generate a first step. For me, "Open the Notion doc and write one subheading" comes easily. But I can imagine a day where I'd stare at this for a minute.

**Delights:** I tested the "I'm stuck – show ideas" button out of professional curiosity. The AI consent dialog appearing first is right — I don't want an app silently sending my data anywhere. The suggestion chips are genuinely useful: specific enough to be actionable, not so specific that they feel like they're doing my job for me. "Make this smaller" is the smarter button in my opinion — it takes what I've already written and makes it smaller, rather than replacing my agency with a list.

**Friction points:** After I tap a suggestion chip, does tapping [Let's go] immediately commit to that chip's text? Yes, it does. Good. No additional confirmation needed.

**Missing elements:** I briefly wish I could see a few more suggestions at once. The wrap layout should handle this, but if there are only 2–3 chips, the choices feel almost arbitrary.

---

### CreateCardConfirmScreen

**First impression:** I see my action text rendered as an actual card — rounded corners, surface color. Something clicks. It's no longer just text I typed; it's a *card*. This is a small but meaningful visual shift.

**Copy and tone:** "Ready for your tiny start?" — "tiny start" again. I've heard it twice now and it's sticking. That's good repetition; it's building a mental model. "You're just giving this 2 tiny minutes. You can stop after that or keep going." The explicit permission to stop is important for me. I have a lot of resistance around committing to tasks — I hate not being able to exit. This sentence removes that.

**Interactive affordances:** [Start now] and [Save for later]. The hierarchy is clear. I notice [Save for later] is a text button, not filled — this steers me toward [Start now] without removing my choice. Good pattern.

**Emotional response:** "Ready for your tiny start?" lands as gentle rather than cute. I expected to find it cloying — it's the kind of copy that could easily tip into baby-talk — but the restraint elsewhere in the app earns it.

**Delights:** "You can stop after that or keep going." This is the most important sentence on this screen for me. I tap [Start now] instead of [Save for later] specifically because it doesn't feel like a commitment.

---

### Timer Screen — Running

**First impression:** Full screen, white background, my task text, a big countdown. The pulsing dot is unexpected. My first reaction is analytical — "pulse on a 3-second cycle, probably targeting respiratory pacing." Then I stop analyzing and just watch it for a second. That's new.

**Copy and tone:** No copy. Just the task and the time. Correct.

**Visual hierarchy:** The action text is what I see first. Then the number. Then the dot. That order is right — the task is the most important thing.

**Cognitive load:** This is the lowest cognitive load screen in the app. Nothing to decide. Nowhere to go. The back gesture is blocked, which I only notice because I'm testing — a regular user would never try it.

**Emotional response:** I realize about 45 seconds in that I've actually started thinking about the teardown. Not actively working — but I've started formulating sentences. The constraint of the screen helped. There's nowhere to go, so my brain went to the task. This is the core mechanic working.

**Friction points:** None. The screen stays on (wakelock is doing its job), the dot keeps pulsing.

**Delights:** The pulsing dot is legitimately calming. I don't say that easily. It doesn't demand my attention but gives me something to rest on. Smart.

---

### Timer Screen — Complete + Explainer

**First impression:** "You hit your 2 minutes." This is good. Not "Congratulations!" Not "🎉 You did it!" Just a fact, delivered flatly, which somehow makes it feel more true.

**Copy and tone:** The completion message is the right tone — matter-of-fact rather than celebratory. [Done] and [Keep going] are the right choices. [Keep going] is an outlined button — secondary, but visible. I use it, because I was genuinely in the zone by minute 1:30.

**The Explainer Sheet:** "That's how it works. Two minutes was enough to start." Yes. This lands. "The hardest part isn't the doing — it's deciding to begin. You just did that." I read this three times. I've known this intellectually for years. Seeing it immediately after actually starting something is different from reading it in a book. This is the moment I update my prior on the app's value.

**Emotional response:** Something loosens. I'm not going to be dramatic about it — I'm not tearing up. But there's a small, real relief that I did the thing.

**Friction points:** First-completion-only means I'll only see this once. That's correct. The second time, I don't need it.

---

### Deck View

**First impression:** "Your Deck 1" — my card is there. My task. It looks different from inside the deck than it did during creation. Seeing it as one item in a list makes it feel manageable.

**Copy and tone:** No copy that outstays its welcome. The card tiles are clean.

**Visual hierarchy:** The count badge next to "Your Deck" is subtle. The [⊟] and [⚙] icons are unobtrusive. The FAB is the right primary action.

**Interactive affordances:** I immediately look for the settings icon. It's at the top right, next to the Just One icon. I tap settings almost before I process the rest of the deck — this is exactly what my persona file predicted.

**Friction points:** The [⊟] icon for Just One Mode is not immediately self-describing. I know what it means (collapse to one) because I'm a designer. Another user might not.

**Delights:** Swipe left to defer is discoverable without instruction. The "Later" dismiss background is satisfying.

---

### Add Method Sheet

**First impression:** [🎤 Use voice] and [✏️ Type it]. Two choices. Fine.

**Copy and tone:** Minimal. Good. The sheet title "Add a card" is accurate.

**Interactive affordances:** Both buttons are outlined — equal weight. This is slightly ambiguous if you have a preference (I prefer typing) but the sheet is quick to dismiss, so no harm done.

**Cognitive load:** Very low. Two choices. Even if I stall for a second, the cost is negligible.

---

### VoiceAISuggestionsScreen

I didn't plan to use voice, but I try it after the first card because scenario C asks me to capture what's bugging me after a meeting. I speak for about 30 seconds: a mix of three concerns — the client deadline, a stakeholder conflict, and an unrelated worry about renewing my lease.

**First impression:** Three extracted task items, all checked. The headline "Here's what I heard / Pick what to work on" is exactly right. No confusion about what I'm looking at.

**Copy and tone:** Clean and functional. "Add manually instead" is the right escape hatch, clearly labeled.

**Cognitive load:** Moderate. Three checked items — I need to evaluate each one. I uncheck the lease item because it doesn't belong in a work session. The interaction of unchecking feels natural.

**Interactive affordances:** The edit pencil icon on each item is visible but small. I notice it exists, which is enough — I don't need to use it.

**Delights:** The AI got "stakeholder conflict" right from my verbal meander. Impressive enough to make me pause.

**Friction points:** The multi-card queue flow — routing each checked task through the card creation flow serially — is going to be tedious if I have more than two items. Three tasks = three separate goal/action/confirm screens? I'd expect to see a streamlined flow for bulk additions from voice.

---

### Settings

**First impression:** Two toggles. That's it. My first reaction — trained by a decade of apps with fifteen settings screens — is: wait, did I miss something? Then: no. This is actually it. My second reaction is to check if there's a hidden menu or a scrollable section below. There isn't.

**Copy and tone:** The Fresh Start copy is clear: "Start each day with a blank deck. Yesterday's cards move to Past Days." This is better than most settings copy I've seen. It tells me what happens, not just what the toggle is called.

**Cognitive load:** Extremely low.

**Emotional response:** I feel slight dissonance. The designer in me wants to find the "data management" section, the notification settings, the theme picker. They're not here. After a beat, I decide this is intentional and respect it. But the instinct was real — an inexperienced user might feel the app is unfinished.

**Delights:** "AI Suggestions — Get ideas when you're stuck creating tasks. Sends text to OpenAI." Calling out the data destination explicitly ("Sends text to OpenAI") is rare and correct. Most apps bury this in a privacy policy. I trust this app slightly more because of it.

---

### Just One Mode

I tap [⊟] from the deck view during scenario B, when I'm deciding which card to work on from a set of three.

**First impression:** One card. Center of screen. Two buttons: [Start] and [Not today]. Nothing else.

**Copy and tone:** "Not today" is better than "Skip" or "Later." "Later" implies I'll do it eventually. "Not today" is honest.

**Visual hierarchy:** The card is dominant. My eye goes straight to it. No competing elements.

**Cognitive load:** This is the lowest-decision screen in the entire app, post-timer. One thing. Start it or not. For me, the decision is trivial. For someone like Mara or Dani, this could be the most important screen in the product.

**Emotional response:** The simplicity is slightly surprising. I expected more — a description, a duration, maybe a due date. The fact that it's just the action text and two buttons makes the choice feel low-stakes. I tap [Start] without hesitation.

**Delights:** [Not today] cycling to the next card is the right mechanic. I don't feel punished for skipping. That matters.

---

### Archive Prompt

I encounter this after deferring a card three times (I test this deliberately by swiping "Save for later" on a card twice more after returning to the deck).

**First impression:** "You've set this one aside a few times. Want to rest it for now?" — This is the best copy in the app. It's not "This task is overdue." It's not "You've been avoiding this." It's "you've set it aside a few times" — neutral observation, not indictment. "Rest it" is the right verb — it implies the card will come back, not disappear.

**Copy and tone:** [Rest it] / [Keep it]. Simple, non-judgmental, bilateral. Neither option is the "correct" one.

**Emotional response:** I feel zero shame reading this. That's exceptional. This screen could easily have been the most shame-inducing in the app and it's instead one of the best-designed moments.

**Delights:** "Want to rest it for now?" — "for now" is doing enormous work. The card isn't gone. It's resting. This is exactly the emotional framing this persona needs.

---

## Post-Session Questions

1. I opened an app, created a task card from something I'd been avoiding for days, ran a timer, actually started thinking about the thing, and then poked around the rest of the features. The whole primary flow took maybe three minutes. I've spent longer closing notification settings on other apps.

2. The moment I most expected confusion was when I came back to the deck after the first card. I wasn't sure if I'd see my completed card or an empty state. The card was there, unchanged — I'd need to swipe it away manually. That's fine, but the first-return experience isn't explicitly explained anywhere. I figured it out but I wasn't guided.

3. No. Not once. The word "tiny" could be condescending coming from a different source — but because the app is quiet and unobtrusive about everything else, it doesn't feel that way here.

4. When I tapped "I'm stuck – show ideas" — I expected an input dialog or a longer delay. The consent dialog first, then the chips appearing inline, was smoother than I expected.

5. Completely different. A to-do list is a list of things I'm not doing yet. This is a scaffold that physically stops me from doing anything except the one thing I picked, for two minutes. The constraint is the product.

6. If the first use resulted in me actually doing something I'd been avoiding. Which it did. So: already met.

7. Two surprises. One: the pulsing dot. I expected to hate it and found it genuinely calming. Two: the Archive Prompt copy — I expected shame and got "rest it." I've used a lot of productivity apps. I've never seen a deferral mechanic that respectful.

8. Fresh Start mode. It's well-designed, but I maintain my deck manually. I'd use the archive feature more.

9. "It's for people who know what they should be doing and can't start. It forces you to pick one thing and sit with it for two minutes. That's actually all it does, and it's weirdly enough."

---

## Falsification Test Results

| Test | Result | Evidence (if FLAG) |
|---|---|---|
| F1 — Complexity Burnout | PASS | Flow felt appropriately weighted for each step; no drag expressed |
| F2 — Value Blindness | PASS | Articulated the difference clearly in post-session Q5 |
| F3 — Timer Abandonment | PASS | Used [Keep going]; timer framing landed as intended |
| F4 — Voice Input Cognitive Load | FLAG | Serial card creation flow from voice (3 tasks → 3 full creation screens) felt potentially tedious; flagged as friction for bulk input |
| F5 — Fresh Start Misfire | PASS | Found the setting and understood it; no alarm, mild disinterest |
| F6 — Deck Overwhelm | PASS | Used Just One Mode proactively in scenario B; no paralysis observed |
| F7 — Emotional Framing | PASS | No shame response triggered at any screen |
| F8 — Universal Utility | PASS | Did not describe app as only useful in extreme cases |
| F9 — Environmental Trap | PASS | No mention of phone-as-distraction; used app focused |
| F10 — Working Memory | PASS | Arrived with a clear, specific goal in working memory |

---

## Overall Assessment

**Strongest moments for this persona:**
- Archive Prompt — "Want to rest it for now?" is the most emotionally intelligent copy in the app; earned immediate trust
- Timer Screen (Complete + Explainer) — The Explainer Sheet landed as a genuine insight, not a patronizing reminder
- CreateCardConfirmScreen — "You can stop after that or keep going" removed commitment resistance precisely when it was needed

**Biggest friction points:**
- VoiceAISuggestionsScreen → serial creation flow: routing three checked voice tasks through three separate full creation flows is significantly more friction than the single-card path; Jordan would abandon after the second pass
- [⊟] Just One Mode icon: not self-describing without context; Jordan decoded it from professional knowledge, not product clarity

**Likelihood to return:** High
Because the first session produced a tangible behavioral outcome (actually started the avoided task) within the 10-minute evaluation window Jordan allocates to new tools.

**The one change that would most improve this persona's experience:**
Replace the serial full-creation-flow for voice-extracted tasks with a batch review screen that lets the user confirm all extracted tasks at once before creating them as cards — eliminating 2–4 redundant screens for multi-task voice sessions.
