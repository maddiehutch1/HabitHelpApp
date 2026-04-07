# Final Grading Rubric

**Course:** IS 590r — AI Applications in Business  
**Total Points:** 200 (weighted across three grading domains)  

**Philosophy:** We grade your **process**, not your product. A team with a simpler app and a strong, documented process will outscore a team with a polished product and no evidence of how they built it.

---

## What Changed from Midterm

| Midterm Allowance | Final Expectation |
| ------------------ | ----------------- |
| No penalty for missing code/implementation | Working demo required — in person. Code must exist and run. |
| Friends-and-family interviews accepted | Must include interviews **outside your immediate social circle** — target users, strangers, or domain contacts. Friends-and-family can supplement but cannot be the only source. |
| Falsification tests designed but unexecuted | Falsification tests must be **executed** with documented results. |
| Empty changelogs, stale docs not penalized | Documents must be **living artifacts** — current `context.md`, updated roadmaps, PRD that reflects the actual project. If you pivoted, the version history should show the evolution. |
| Logging library present but unused in app | Structured logging must be **integrated into the actual application**, not just defined in a standalone file. |
| 15-minute presentations, no demo required | 20-minute presentations with in-person working demo and process narrative. |
| Midterm was a first look — introduce your idea | Final is a continuation, not a repeat. Don’t re-present your midterm; start from where midterm left off and show what changed, deepened, or pivoted. |
| MCP scored as a sub-criterion | MCP is no longer a scored criterion. MCP configs often contain secrets and should be gitignored. We care that you used MCP, not that the config is committed. |
| CLAUDE.md / .cursorrules not explicitly required | `CLAUDE.md` or `.cursorrules` with behavioral guidance is now an explicit sub-criterion in AI Development Infrastructure. |
| Some teams gitignored their `ai/` folder | Do **not** gitignore your `ai/`, `aiDocs/`, or planning folders. Graders must be able to see your roadmaps, plans, changelogs, and `context.md`. Only gitignore secrets and library folders (`.env`, `.testEnvVars`, MCP configs, `node_modules/`, `venv/`). |
| `mvp.md` not consistently graded at midterm | `mvp.md` is a required deliverable for the final. It defines the concrete, scope-constrained version of what you are actually building. |
| No peer evaluation | Confidential peer evaluation form is a required deliverable. Peer evaluations may be used to adjust individual grades if there are significant contribution imbalances. |

> **Important:** Everything that was expected at midterm is still expected. These are additions, not replacements.

---

## Grading Philosophy

Process adherence is not a separate grading area; it is the lens for **all** areas. Students are expected to follow the processes taught in class: document-driven development, AI-augmented workflows, systematic iteration, and structured debugging. This is assessed within each technical and product area.

---

## Who Grades What

| Grader        | Focus                  | Weight | Areas / Scoring |
| ------------- | ---------------------- | ------ | --------------- |
| Jason         | Product & system design | 45%   | 5 areas × 20 pts = 100 raw, weighted to 90 / 200 |
| Casey         | Technical process       | 45%   | 4 areas × 25 pts = 100 raw, weighted to 90 / 200 |
| Guest Grader  | Presentation quality    | 10%   | 4 subs × 25 pts = 100 raw, weighted to 20 / 200 |

---

## Jason’s Product & System Design (45% of Final Grade)

Each area is scored out of 20 points (100 raw, weighted to 90 / 200).

At midterm you showed artifacts (system diagram, problem statement, customer definition, success criteria, customer conversations). At final, grading focuses on **what happened when those artifacts met reality**.

### 1. System Understanding (20 points)

At final: show how building your product changed your understanding of the system.

- What did you get wrong or miss at midterm?  
- What new elements, relationships, or feedback loops did you discover?  
- Which leverage points did you try to pull, and what happened?

Your system diagram should have evolved.

### 2. Problem Identification (20 points)

At final: show how the problem was tested and refined.

- Did falsification tests confirm or challenge your assumptions?  
- If you pivoted, what evidence drove the change?  
- If you stayed the course, what evidence validated your hypothesis?

Your problem statement should be more precise and evidence-based than at midterm.

### 3. Customer Focus (20 points)

At final: show a deeper understanding of your customer.

- Did you talk to people **beyond friends and family** (target users, domain experts, strangers)?  
- Has your competitive analysis evolved based on building and feedback?

Positioning should reflect what customers actually told you.

### 4. Success & Failure Planning (20 points)

At final: show how you measured yourself.

- Did you test your success/failure indicators? Where do you stand?  
- If you couldn’t measure as planned, what did that teach you about measurement?

Pivot plans should be informed by data, not hypotheticals.

### 5. Customer Interaction (20 points)

At final: show that conversations **shaped** what you built.

- Point to features or design decisions driven by feedback.  
- Show the loop: engage → learn → change → re-engage.

---

## Casey’s Technical Process (45% of Final Grade)

Each area is scored out of 25 points (100 raw, weighted to 90 / 200).

### 1. PRD & Document-Driven Development (25 points)

- PRD is clear enough to build from and can include broader vision.  
- `mvp.md` defines the concrete, scope-constrained deliverable.  
- Development follows PRD → `mvp.md` → plan → roadmap → implementation.  
- Docs are living artifacts with version history and AI-assisted iteration.

### 2. AI Development Infrastructure (25 points)

- AI folder pattern implemented (`context.md`, project docs).  
- `context.md` uses bookshelf pattern and is current.  
- `CLAUDE.md` or `.cursorrules` provides behavioral guidance.  
- Git workflow: branching, meaningful commits, PRs.  
- `ai/` folder committed (not gitignored).  
- `.gitignore` covers secrets and libraries; no secrets in repo.

### 3. Phase-by-Phase Implementation & Working Demo (25 points)

- Code built incrementally following roadmap phases.  
- Roadmaps used as checklists with tasks checked off.  
- Git history shows iterative, multi-session progress.  
- **In-person working demo** of core functionality.

### 4. Structured Logging & Debugging (25 points)

- Structured logging implemented and integrated into app code.  
- CLI test scripts exist and work (with proper exit codes).  
- Evidence of test → log → fix loop, including AI-assisted debugging.

---

## Guest Grader: Presentation (10% of Final Grade)

Each sub-criterion is out of 25 points (100 raw, weighted to 20 / 200).

1. **Communication Quality (25)**  
   Clear, confident delivery; all team members speak; thoughtful Q&A.

2. **Storytelling & Journey (25)**  
   Compelling project story; honest about challenges and “what we’d do differently”; growth since midterm.

3. **Visual Design & Demo (25)**  
   Slides support the narrative; demo integrated throughout, not just at the end.

4. **Overall Impact (25)**  
   Listener can explain what you built, why, and what you learned.

---

## Scoring Scale

| Level       | Meaning                                                | Score Range |
| ----------- | ------------------------------------------------------ | ----------- |
| Exemplary   | Exceptional work; future-student example               | 95–100%     |
| Proficient  | Solid work; process clearly followed                   | 90–94%      |
| Developing  | Partial implementation; some gaps                      | 80–89%      |
| Insufficient| Major gaps, process not followed, or work missing      | < 80%       |

---

## Grade Scale

| Grade | Min % | Min Points (/200) |
| ----- | ----- | ----------------- |
| A     | 93%   | 186               |
| A-    | 90%   | 180               |
| B+    | 87%   | 174               |
| B     | 83%   | 166               |
| B-    | 80%   | 160               |
| C+    | 77%   | 154               |
| C     | 73%   | 146               |

---

## Worked Scoring Example

| Grader                              | Raw ( /100 ) | Weight | Weighted Points |
| ----------------------------------- | ------------ | ------ | --------------- |
| Jason (Product & System Design)     | 85           | 45%    | 85 × 0.90 = 76.5 |
| Casey (Technical Process)           | 90           | 45%    | 90 × 0.90 = 81.0 |
| Guest Grader (Presentation)         | 92           | 10%    | 92 × 0.20 = 18.4 |

**Total:** 175.9 / 200 = 87.95% → **B+**

Multipliers: Jason and Casey’s raw scores × 0.90 (100 → 90). Guest Grader × 0.20 (100 → 20).

---

## Presentation Format

- **Duration:** 20 minutes per team.  
- **Schedule:** April 8, 13, 15.  
- **Submission deadline:** Monday April 7 at 23:59. All code, docs, and slides must be pushed by this deadline. Work pushed after will not be graded.  
- **Participation:** All team members must contribute and explain their contributions.

**Required elements:**

- System design diagram  
- Process narrative: how you planned, built, iterated, adapted  
- In-person working demo (backup recording recommended)  
- Product shown throughout, not just at the end  
- Honest discussion of learning, surprises, and what you’d do differently  
- Q&A with thoughtful responses  
- Confidential peer evaluations (each team member submits one)

**Framing:** This is your completed project story — plan, pivots, process, and result.

---

## Structuring Your Presentation: Pivot vs. Refinement

**Do not re-present your midterm.** Structure based on your path:

### If your team pivoted

- Open with the pivot story and the evidence that triggered it.  
- Show customer validation of the new idea.  
- Demo the new product.  
- Connect pivot to falsification results and customer feedback.  
- Show updated system diagram, problem statement, success/failure criteria.

### If your team refined

- Start from where midterm left off.  
- Show depth from sustained execution: more feedback, sharper problem, validated assumptions.  
- Show evolution in system diagram, problem statement, competitive analysis.  
- Demo should show meaningful progress.  
- Show the iteration loop: engage → learn → change → re-engage.

Either path is valid; grading focuses on **process quality and learning depth**, not whether you pivoted.

---

## What We’re NOT Grading

- A finished, polished product  
- Paying customers, revenue, or business model  
- Which AI tool you used  
- Complexity of the idea  
- Perfect code  
- Unlimited AI access  
- MCP configuration files in the repo

We do expect **customer research and engagement**, including interviews with people **outside your immediate social circle**.

---

## Quick Evidence Checklist

### Jason’s Product & System Design

**System Understanding**

- [ ] System diagram evolved since midterm  
- [ ] Team can articulate what they learned about the system  
- [ ] Leverage points validated through experience

**Problem Identification**

- [ ] Problem statement refined or pivoted based on evidence  
- [ ] Falsification tests executed with documented results  
- [ ] Pivot/stay decision justified with evidence

**Customer Focus**

- [ ] Customer understanding deepened beyond friends and family  
- [ ] Competitive analysis updated  
- [ ] Solution positioning reflects validated understanding

**Success & Failure Planning**

- [ ] Success/failure criteria tested against reality  
- [ ] Pivot plans informed by real data

**Customer Interaction**

- [ ] Ongoing interaction with feedback loop (engage → learn → change → re-engage)  
- [ ] Features/decisions shaped by customer feedback  
- [ ] Awareness of leading vs. being led by the customer

### Casey’s Technical Domain

**PRD & Document-Driven Development**

- [ ] PRD exists and is buildable  
- [ ] `mvp.md` exists and defines concrete deliverable  
- [ ] Dev driven by PRD → `mvp.md` → plan → roadmap → implementation  
- [ ] Docs are living artifacts  
- [ ] Evidence of AI-assisted iteration on docs

**AI Development Infrastructure**

- [ ] AI folder structure with `context.md`, architecture docs, coding-style docs  
- [ ] `context.md` uses bookshelf pattern and is current  
- [ ] `CLAUDE.md` or `.cursorrules` present  
- [ ] Proper Git workflow with meaningful commits  
- [ ] `ai/` folder committed  
- [ ] `.gitignore` covers secrets and libraries  
- [ ] No committed secrets

**Phase-by-Phase Implementation & Working Demo**

- [ ] Roadmaps with tasks checked off  
- [ ] Git history shows incremental development  
- [ ] Evidence of multi-session workflow  
- [ ] Roadmaps updated as living docs  
- [ ] In-person working demo of core functionality

**Structured Logging & Debugging**

- [ ] Structured logging implemented (beyond `console.log("here")`)  
- [ ] Logging integrated into app code  
- [ ] CLI test scripts exist and work  
- [ ] Proper exit codes (0/1/2)  
- [ ] Evidence of test–log–fix loop in history

### Presentation

- [ ] All materials pushed by April 7 at 23:59  
- [ ] All team members contribute and can explain their role  
- [ ] System design diagram included  
- [ ] Process narrative included  
- [ ] In-person working demo  
- [ ] Honest discussion of learning and next steps  
- [ ] Thoughtful Q&A  
- [ ] Confidential peer evaluation submitted

---

## Note on Iteration, Pivoting, and Failure

This course values learning through doing. Pivots, setbacks, and discovering your original plan was wrong are **not** problems — they are evidence of good process. Show the pivot and explain what you learned.

Teams that stayed the course and executed well are **not** penalized for not pivoting. Grading is about the quality of your process on whichever path you took.