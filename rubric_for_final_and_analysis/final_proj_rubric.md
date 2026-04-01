# Simplified Final Grading Rubric

**Course:** BYU IS/IT Capstone – AI-Augmented Software Development  
**Total Points:** 200 (weighted across three grading domains)

**Philosophy:** We grade your **process**, not your product. A team with a simpler app and a strong, documented process will outscore a team with a polished product and no evidence of how they built it. [file:1]

---

## What Changed from Midterm

| Midterm Allowance                                      | Final Expectation                                                                                                                                                                                                 |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No penalty for missing code/implementation             | Working demo required — in person. Code must exist and run.                                                                                                                                                       |
| Friends-and-family interviews accepted                 | Must include interviews outside your immediate social circle — target users, strangers, or domain contacts. Friends-and-family can supplement but cannot be the only source.                                      |
| Falsification tests designed but unexecuted            | Falsification tests must be executed with documented results.                                                                                                                                                     |
| Empty changelogs, stale docs not penalized             | Documents must be living artifacts — current `context.md`, updated roadmaps, PRD that reflects the actual project. If you pivoted, the version history should show the evolution.                                 |
| Logging library present but unused in app              | Structured logging must be integrated into the actual application, not just defined in a standalone file.                                                                                                         |
| 15-minute presentations, no demo required              | 20-minute presentations with in-person working demo and process narrative.                                                                                                                                        |
| MCP scored as a sub-criterion                          | MCP is no longer a scored criterion. MCP configs often contain secrets and should be gitignored. We care that you used MCP, not that the config is committed.                                                    |
| CLAUDE.md / .cursorrules not explicitly required       | `CLAUDE.md` or `.cursorrules` with behavioral guidance is now an explicit sub-criterion in AI Development Infrastructure.                                                                                        |
| No peer evaluation                                     | Confidential peer evaluation form is a required deliverable (see separate form).                                                                                                                                  |

**Important:** Everything that was expected at midterm is still expected. These are additions, not replacements. [file:1]

---

## Grading Philosophy: Process Adherence as a Lens

Process adherence is not a separate grading area – it is the lens through which **all** areas are evaluated. Students are expected to demonstrate that they followed the processes taught in class: document-driven development, AI-augmented workflows, systematic iteration, and structured debugging. This is assessed within each technical and product area, not scored as its own category. Course material is required process, not optional suggestions. [file:1]

---

## Who Grades What

| Grader        | Focus                     | Weight | Areas                                      | Scoring                       |
| ------------- | ------------------------- | ------ | ------------------------------------------ | ----------------------------- |
| Jason         | Product & system design   | 45%    | 5 areas, each scored out of 20 (100 total) | Weighted to 90 of 200 points  |
| Casey         | Technical process         | 45%    | 4 areas, each scored out of 25 (100 total) | Weighted to 90 of 200 points  |
| Guest Grader  | Presentation quality      | 10%    | 4 sub-criteria, each out of 25 (100 total) | Weighted to 20 of 200 points  | [file:1]

---

## Jason’s Product & System Design (45% of Final Grade)

Each area is scored out of 20 points. Total: 100 raw points, weighted to 90 of 200 final points. [file:1]

At midterm, grading focused on whether you had these artifacts: system diagram, problem statement, customer definition, success criteria, and evidence of customer conversations. At final, grading focuses on what happened when those artifacts met reality. Every area below asks: **how did this evolve through building, testing, and engaging with real customers?** If your final presentation sounds identical to your midterm, you haven’t demonstrated growth. [file:1]

### 1. System Understanding (20 points)

At midterm you showed a system diagram. At final we want to see how building your product changed your understanding of the system. [file:1]

- Show what you got wrong — or what you didn’t see — at midterm.  
- Identify new elements, relationships, or feedback loops discovered by actually operating in this system.  
- Explain which leverage points you tried to pull, and what happened.  
- Your diagram should look different from midterm because your understanding is different.  
- If it hasn’t changed, either you got it perfectly right the first time (show evidence) or you haven’t been paying attention. [file:1]

### 2. Problem Identification (20 points)

At midterm you identified a problem. At final we want to see how that problem was tested, refined, and sharpened through real-world experience. [file:1]

- Did your falsification tests confirm you were right, or reveal something unexpected?  
- Show the results and what they meant.  
- If you pivoted, walk through the evidence that made you change course.  
- If you stayed the course, show evidence that validated your original hypothesis — not just “we still believe it” but “here’s what we learned that proved it.”  
- Your problem statement should be more precise and grounded than it was at midterm. [file:1]

### 3. Customer Focus (20 points)

At midterm you identified a target customer. At final we want to see how your understanding of that customer deepened through real research and engagement. [file:1]

- You should know your customer better now than at midterm, and be able to explain specifically what changed.  
- Did you talk to people beyond friends and family — actual target users, domain experts, strangers?  
- Has your competitive analysis evolved based on what you learned while building?  
- Your solution positioning should reflect what customers actually told you, not what you assumed. [file:1]

### 4. Success & Failure Planning (20 points)

At midterm you defined what success and failure would look like. At final we want to see whether you actually measured against those criteria and what you found. [file:1]

- Did you test your own success/failure indicators?  
- Where do you stand against the metrics you set?  
- If you couldn’t measure what you planned to measure, what did that teach you about measurement itself?  
- Pivot plans should no longer be hypothetical — they should be informed by real data.  
- Your revenue or business model should reflect what you learned through building, not just midterm assumptions. [file:1]

### 5. Customer Interaction (20 points)

At midterm you showed that you talked to customers. At final we want to see that those conversations actually shaped what you built. [file:1]

- Point to specific features, design decisions, or pivots that exist because of customer feedback.  
- Show the feedback loop: you engaged, you learned something, you changed something, and you went back to validate.  
- Interviews must extend beyond friends and family.  
- The key question: did talking to people make your solution better, and can you prove it? [file:1]

---

## Casey’s Technical Process (45% of Final Grade)

Each area is scored out of 25 points. Total: 100 raw points, weighted to 90 of 200 final points. [file:1]

### 1. PRD & Document-Driven Development (25 points)

**What “Good” Looks Like:** [file:1]

- PRD is clear enough to build from.  
- Documents drive the coding process – PRD serves as immutable source of truth.  
- Development follows the PRD → plan → roadmap → implementation pipeline.  
- Documents are living artifacts that reflect the current project state.  
- Evidence of AI-assisted iteration, not one-shot generation. [file:1]

### 2. AI Development Infrastructure (25 points)

**What “Good” Looks Like:** [file:1]

- AI folder pattern properly implemented (`context.md`, project docs).  
- `context.md` uses bookshelf pattern and is current.  
- `CLAUDE.md` or `.cursorrules` provides behavioral guidance.  
- Git workflow shows branching, meaningful commits, and PRs.  
- `.gitignore` covers `ai/`, `.env`, `.testEnvVars`, MCP configs, and secrets.  
- No secrets committed. [file:1]

### 3. Phase-by-Phase Implementation & Working Demo (25 points)

**What “Good” Looks Like:** [file:1]

- Code built incrementally following roadmap phases – not one-shot prompted.  
- Roadmaps used as checklists during implementation with tasks checked off.  
- Evidence of multi-session workflow (plan/implement/review).  
- Git history shows iterative, incremental progress across the semester.  
- In-person working demo demonstrating core functionality. [file:1]

### 4. Structured Logging & Debugging (25 points)

**What “Good” Looks Like:** [file:1]

- Structured logging implemented and integrated into application code — not just a standalone logger file.  
- CLI test scripts exist and work.  
- Proper exit codes (0/1/2) on scripts.  
- Test–log–fix loop followed – evidence that AI read logs, diagnosed issues, and fixed them.  
- Debugging process is documented or evidenced in git history. [file:1]

---

## Guest Grader (10% of Final Grade)

The guest grader evaluates presentation quality using 4 sub-criteria, each scored out of 25 points (100 raw total), weighted to 20 of 200 final points. [file:1]

| # | Sub-Criterion           | Points | What “Good” Looks Like                                                                                                                                          |
| - | ----------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1 | Communication Quality   | 25     | Presentation is clear, confident, and well-delivered. All team members speak competently. Q&A responses are thoughtful.                                       |
| 2 | Storytelling & Journey  | 25     | Team tells a compelling story about their project journey. Demonstrates honest self-awareness about challenges and what they would do differently.            |
| 3 | Visual Design & Demo    | 25     | Slides and visual materials support the narrative. Demo is well-integrated into the presentation, not tacked on at the end. Product shown throughout.        |
| 4 | Overall Impact          | 25     | Presentation leaves a positive, professional impression. A listener can explain what the team built, why they built it, and what they learned.               | [file:1]

---

## Scoring Scale

For each area, a four-level scale is used, recalibrated so that solid work earns an A-minus. [file:1]

| Level        | What It Means                                                            | Score Range              |
| ------------ | ------------------------------------------------------------------------ | ------------------------ |
| Exemplary    | Exceptional work that goes beyond expectations; example for future students. | 95–100% of area points   |
| Proficient   | Solid work, process clearly followed. Meets all expectations.            | 90–94% of area points    |
| Developing   | Partial implementation, some gaps in process or understanding.           | 80–89% of area points    |
| Insufficient | Major gaps, process not followed, or work not submitted.                 | Below 80% of area points | [file:1]

---

## Grade Scale

| Grade | Minimum Percentage | Minimum Points (/200) |
| ----- | ------------------ | ---------------------- |
| A     | 93%                | 186                    |
| A-    | 90%                | 180                    |
| B+    | 87%                | 174                    |
| B     | 83%                | 166                    |
| B-    | 80%                | 160                    |
| C+    | 77%                | 154                    |
| C     | 73%                | 146                    | [file:1]

---

## Worked Scoring Example

Suppose a team receives the following raw scores from each grader: [file:1]

| Grader                          | Raw Score (out of 100) | Weight | Weighted Points   |
| --------------------------------| ----------------------- | ------ | ----------------- |
| Jason (Product & System Design) | 85/100                  | 45%    | 85 × 0.90 = 76.5  |
| Casey (Technical Process)       | 90/100                  | 45%    | 90 × 0.90 = 81.0  |
| Guest Grader (Presentation)     | 92/100                  | 10%    | 92 × 0.20 = 18.4  |
| **Total**                       |                         |        | **175.9 / 200**   | [file:1]

175.9 / 200 = 87.95% → **B+**. [file:1]

**Domain multipliers:**  
- Jason and Casey’s raw scores are multiplied by 0.90 (to map 100 raw → 90 weighted).  
- Guest Grader’s raw score is multiplied by 0.20 (to map 100 raw → 20 weighted). [file:1]

---

## Presentation Format

- **Duration:** 20 minutes per team  
- **Schedule:** Presentations across April 8, 13, and 15. All presentation materials due April 8 regardless of presentation slot.  
- **Final exam day:** Saturday April 18 (11:00am–2:00pm, 270 TNRB) [file:1]

**All team members must:**

- Contribute to the presentation.  
- Be able to explain their individual contributions. [file:1]

**Required elements:**

- System design diagram  
- Process narrative: how you planned, built, iterated, and adapted  
- In-person working demo — demos must be live, not pre-recorded  
- Show the product throughout the presentation, not just at the end  
- Honest discussion of what you learned, what surprised you, and what you would do differently  
- Q&A: thoughtful responses demonstrating understanding of trade-offs and honest discussion of limitations  
- Peer evaluation: each team member submits a confidential peer evaluation form (see separate form) [file:1]

**Framing:** This is your completed project story. Show the full journey — the plan, the pivots, the process, and the result. [file:1]

---

## What We’re NOT Grading

- A finished, polished product. A working prototype is great; a production-ready app is not expected.  
- Paying customers or revenue. We expect evidence of customer research and engagement – interviews, feedback sessions, prototype testing with real people. Customers can be anyone (friend, family member, company contact, stranger at a bus stop). For the final, you must include interviews **outside** your immediate social circle.  
- Which AI tool you used (Claude Code, Cursor, ChatGPT, etc.). The focus is on process, not brand.  
- Complexity of the idea. A simple idea executed with strong process beats an ambitious idea with no evidence of how it was built.  
- Perfect code. What matters is the journey: plans, attempts, failures, fixes, iteration.  
- Unlimited AI access. Efficient use of limited/free-tier resources is a positive signal.  
- MCP configuration files in the repo. MCP configs often contain secrets and should be gitignored. We care that you used MCP in your workflow, not that the config is committed. [file:1]

---

## Quick Evidence Checklist

Use this to self-assess before your presentation. You do not need every single item, but the more you can demonstrate, the stronger your grade. [file:1]

### Jason’s Product & System Design Domain

**Through-line:** At midterm you had these things. At final, show how they changed through building. [file:1]

**System Understanding:**

- [ ] System diagram has evolved since midterm — not just cosmetic changes  
- [ ] Team can articulate what they learned about the system through building  
- [ ] Leverage points validated through experience, not just hypothesized [file:1]

**Problem Identification:**

- [ ] Problem statement has matured — refined or pivoted based on evidence  
- [ ] Falsification tests executed with documented results that influenced understanding  
- [ ] If pivoted: evolution justified; if stayed: evidence-based rationale for why [file:1]

**Customer Focus:**

- [ ] Customer understanding deepened through research beyond friends and family  
- [ ] Competitive analysis updated based on building experience  
- [ ] Solution positioning reflects validated understanding, not initial assumptions [file:1]

**Success & Failure Planning:**

- [ ] Success/failure criteria tested against reality — team can report where they stand  
- [ ] Pivot plans informed by real data, not midterm hypotheticals  
- [ ] Revenue/business model pressure-tested and refined [file:1]

**Customer Interaction:**

- [ ] Interaction continued beyond midterm with clear feedback loop (engage → learn → change → re-engage)  
- [ ] Specific features or decisions directly shaped by customer feedback  
- [ ] Awareness of driving vs. being driven by the customer [file:1]

### Casey’s Technical Domain

**PRD & Document-Driven Development:**

- [ ] PRD exists and is comprehensive enough to build from  
- [ ] Development driven by documents (PRD → plan → roadmap → implementation)  
- [ ] Documents are living artifacts reflecting current project state  
- [ ] Evidence of AI-assisted iteration on planning documents [file:1]

**AI Development Infrastructure:**

- [ ] AI folder structure with `context.md`, architecture docs, coding-style docs  
- [ ] `context.md` uses bookshelf pattern and is current  
- [ ] `CLAUDE.md` or `.cursorrules` with behavioral guidance  
- [ ] Git workflow with branching, meaningful commits  
- [ ] `.gitignore` covers `ai/`, `.env`, `.testEnvVars`, MCP configs, and secrets  
- [ ] No committed secrets in the repository [file:1]

**Phase-by-Phase Implementation & Working Demo:**

- [ ] Roadmaps with tasks checked off showing progression  
- [ ] Git history showing iterative, incremental development (not one big burst)  
- [ ] Evidence of multi-session workflow (plan/implement/review)  
- [ ] Roadmaps updated as living documents  
- [ ] In-person working demo demonstrating core functionality [file:1]

**Structured Logging & Debugging:**

- [ ] Structured logging implemented (not just `console.log("here")`)  
- [ ] Logging integrated into actual application code  
- [ ] CLI test scripts exist and work  
- [ ] Proper exit codes (0/1/2) on scripts  
- [ ] Evidence of test–log–fix loop in git history [file:1]

### Presentation

- [ ] All presentation materials submitted by April 8 (regardless of presentation slot)  
- [ ] All team members contribute and can explain their role  
- [ ] System design diagram included  
- [ ] Process narrative included (not just product demo)  
- [ ] In-person working demo  
- [ ] Honest discussion of what was learned and what you would do differently  
- [ ] Thoughtful Q&A responses demonstrating understanding of trade-offs  
- [ ] Confidential peer evaluation form submitted [file:1]

---

## A Note on Iteration, Pivoting, and Failure

This course values learning through doing. If your team pivoted, encountered a major setback, or realized your original plan was wrong, that is not a problem — it is evidence of good process. Show the pivot and explain what you learned. That story is often more compelling than a smooth path from start to finish. [file:1]

A team that stayed the course and executed well on the original plan is not penalized for not pivoting. Grading focuses on the quality of your process regardless of which path you took. [file:1]

---

## Accommodations

- Existing projects welcome. If you’re using a pre-existing project, show the AI retrofit process as evidence. Same expectations apply.  
- Solo projects: same rubric; presentation expectations adjusted for one person.  
- Token limits: if you’re on a free tier, efficient use of limited resources is itself a positive signal. [file:1]