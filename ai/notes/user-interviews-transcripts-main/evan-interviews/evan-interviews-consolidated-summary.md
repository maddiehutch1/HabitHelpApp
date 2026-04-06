# Evan Interviews — Consolidated Summary & Key Updates

**Interviews**: Kylie, Madelyn, Indy
**Product**: Microdeck (Micro Duck)

---

## Overall Takeaway

Across all three interviews, the same verdict emerged: **the core mechanic works, but the experience around it doesn't**. Users consistently validated the idea of breaking overwhelming tasks into two-minute micro-actions. The AI decomposition and "make it smaller" feature landed well every time. What failed — repeatedly and in compounding ways — was everything that happens *after* the first micro-step. Every interviewee hit the same wall: the app delivers one moment of momentum and then abandons the user.

---

## Recurring Themes Across All Three Interviews

### 1. The Post-Session Dead End (Flagged in ALL 3 interviews)
This is the single highest-priority issue. After the timer ends, users land on a screen with no forward path. There is no "Ready for Step 2?" prompt, no continuation flow, no way to stay in the momentum the app just created. This was independently identified by Kylie, Madelyn, and Indy.

**Recommended update**: Build a post-session continuation prompt — either "Can you take it from here?" or "Do you want help with the next step?" This transforms Microdeck from a one-shot nudge into a real momentum engine.

### 2. Identity Crisis: Habit Tool vs. Task Launcher (Kylie, Indy)
The app tries to serve two use cases without committing to either:
- **Habit Mode** (daily recurring behavior — put on running shoes): a single repeatable micro-step + notification + streak tracker makes sense here.
- **Task Mode** (one-time overwhelming task — clean closet, write essay): users expect a full sequential breakdown, not a single step.

Kylie explicitly asked why the app wouldn't show the full breakdown at once. Indy surfaced the "hidden checklist" idea — silently track the full project breakdown and reveal it progressively as steps are completed.

**Recommended update**: Split into two distinct flows. Habit Mode delivers daily micro-steps with streak tracking. Task Mode delivers a full AI-generated sequential breakdown the user can work through.

### 3. Text Truncation / Overflow Bug (Madelyn, Indy)
AI-generated suggestions are getting clipped or overhanging on screen. Users cannot read the full instruction they selected. This was flagged in two separate sessions.

**Recommended update**: Fix the text rendering so full micro-step text is always visible.

### 4. Timer UX Issues (Madelyn)
- No visible stop/end-session button — users don't know to tap the timer itself.
- No option to extend time when a task legitimately requires more than two minutes.

**Recommended update**: Add a clearly labeled stop button and a time-extension option.

### 5. AI Button is Buried (Madelyn)
The AI suggestion button is visually too small and subordinate to the manual text input. Users default to typing manually and miss the app's most powerful feature.

**Recommended update**: Enlarge and reposition the AI button so it reads as a primary action, not an afterthought.

### 6. Visual Identity & Emotional Design (Kylie, Indy)
Two interviewees flagged the dark/flat UI as working against the product's purpose. A motivation app targeting people with ADHD should feel calm and inviting, not sterile. Kylie specifically referenced color psychology and soft, warm palettes. Indy noted the app is "functional but visually flat" and suggested micro-animations to reinforce task-completion feedback.

**Recommended update**: Replace the dark interface with a warm, low-stress color palette. Add micro-animations or visual rewards on step completion to close the emotional feedback loop.

### 7. No Completion Tracking or Streaks (Kylie)
Without a log of completed steps or a streak visualization, there is no retention mechanic and no evidence that small actions are accumulating. Kylie benchmarked Microdeck against existing habit apps and immediately identified this gap.

**Recommended update**: Implement streak tracking and a completion log — this is the behavioral reinforcement layer that makes habit apps sticky.

### 8. Onboarding Prompt is Misleading (Kylie)
The current prompt — "What is something that feels difficult for you right now?" — primes users to input huge, paralyzing tasks, after which a single micro-step feels absurd.

**Recommended update**: Reframe to "What habit do you want to build?" (for habit mode) or provide clearer scoping guidance for task mode.

---

## Prioritized Action Items

| Priority | Update | Source |
|----------|--------|--------|
| **P0 — Critical** | Build post-session continuation flow (next step prompt) | Kylie, Madelyn, Indy |
| **P0 — Critical** | Separate Habit Mode vs. Task Mode into distinct flows | Kylie, Indy |
| **P1 — High** | Fix text truncation/overflow on micro-step cards | Madelyn, Indy |
| **P1 — High** | Implement completion tracking / streak visualization | Kylie |
| **P1 — High** | Enlarge and reposition the AI suggestion button | Madelyn |
| **P2 — Medium** | Add stop button and time-extension to the timer | Madelyn |
| **P2 — Medium** | Redesign onboarding prompt for clarity | Kylie |
| **P2 — Medium** | Visual/color overhaul — warm palette, micro-animations | Kylie, Indy |
| **P3 — Low** | Prototype the "hidden checklist" progressive reveal mechanic | Indy |
| **P3 — Low** | Rename "Your Deck" to "Your Tasks" or equivalent | Madelyn |

---

## Unique High-Signal Ideas Worth Exploring

- **Hidden Checklist Mechanic** (from Indy): The app silently tracks the full project breakdown and progressively reveals it as the user completes steps. Reframes Microdeck from a "task starter" into a "project revealer." High potential for the Task Mode flow.
- **Post-Step Branch Prompt** (from Madelyn): "Can you take it from here?" vs. "Do you want help with the next step?" — gives users agency while keeping momentum alive.
- **Kawaii / Soft Aesthetic** (from Kylie): The target audience (ADHD, motivation-deficit users) responds to warm, playful, low-stress design language — not dark utilitarian UI.
