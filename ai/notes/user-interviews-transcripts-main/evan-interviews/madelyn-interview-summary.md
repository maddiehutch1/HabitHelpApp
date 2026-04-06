[image]

## Core Synopsis

Microdeck — a habit-formation app designed to break paralyzing tasks into two-minute micro-actions — is functional at the MVP stage but carries several UX friction points that, left unaddressed, will undermine the core promise of frictionless momentum-building. The usability test revealed that the app's logic is sound: a user identifies a large goal, receives AI-generated or self-typed micro-steps, executes a timed session, and builds momentum iteratively. However, the session surfaced three compounding gaps: users cannot intuitively stop the timer (no visible stop button), the two-minute constraint has no extension mechanism despite tasks that inherently demand more time, and the post-session state — "Your Deck" — communicates nothing meaningful to a first-time user. The AI suggestion button is visually undersized, causing users to default to manual input and miss the app's most powerful feature entirely. Critically, the app currently deposits the user into a dead end after one micro-step, when the highest-leverage moment — sustained momentum — demands a continuation prompt. **We know the core mechanic works; what we haven't solved yet is keeping the user inside the loop.**

---

## Closing the UX Gaps: Where Microdeck Breaks Down

### 1. The Timer Interface — Control Without Clarity

The timer session is the product's centerpiece, yet it offers the user no visible exit path. The test user explicitly stated they would not know to tap the timer itself to stop it — an interaction model that violates standard affordance expectations. Compounding this, the fixed two-minute window is incompatible with tasks like "gather examples of your best work," which inherently exceed that threshold. The session currently offers a binary: finish in two minutes or abandon. There is no middle path.

- **Gap 1**: No dedicated stop/end-session button is visible during the timer.
- **Gap 2**: No option to extend time exists when a task legitimately requires more than two minutes.

### 2. The Continuation Dead End — The Highest-Value Feature That Doesn't Exist Yet

After the timer ends, the user lands on a screen with no forward path. The original design intent was to deliver a single ignition step — enough to break inertia — but the test revealed that users expect the app to keep guiding them. The more strategically sound direction, already surfaced during prior interviews with Kylie and confirmed in this session, is a **post-step branch prompt**: either "Can you take it from here?" (user self-directs) or "Do you want help with the next step?" (AI continues). This single addition transforms Microdeck from a one-shot nudge into a genuine momentum engine.

### 3. The "Your Deck" Screen — An Unlabeled Room

The landing/history screen labeled "Your Deck" generated immediate confusion. The test user could not determine whether completed items were clickable, whether they could re-enter an active task, or what "deck" referred to in this context. The terminology carries no self-evident meaning for a first-time user. Renaming this view to something transparent — "Your Tasks" being the minimum viable label — and clarifying the interaction model (can items be resumed? expanded?) is prerequisite to this screen serving any navigational function.

### 4. The AI Button — A Buried Power Feature

On the task-input screen, the AI-generation button is visually subordinate to the manual text field. The test user's instinct was to type manually, treating the AI option as secondary. Given that AI-powered step generation is a core differentiator of Microdeck, its visual hierarchy must match its strategic weight. The button needs to be enlarged and repositioned so it reads as a primary action, not an afterthought.

### 5. The Text Overflow Bug

AI-generated suggestions that exceed a certain character count are visually clipped or overhanging. This is a confirmed rendering defect that the development team has already identified but not yet resolved.

---

## Action Items

**@Microdeck Dev Team**

- [ ] Add a clearly labeled stop/end-session button to the timer screen — [TBD]
- [ ] Build a time-extension option within the active timer session — [TBD]
- [ ] Design and implement the post-session continuation branch prompt ("Can you take it from here?" / "Do you want help with the next step?") — [TBD]
- [ ] Rename "Your Deck" to "Your Tasks" (or equivalent) and define and surface the interaction model for items on that screen — [TBD]
- [ ] Increase the visual size and hierarchy of the AI suggestion button on the task-input screen — [TBD]
- [ ] Fix the text overflow/overhang rendering bug on AI-generated suggestion cards — [TBD]
