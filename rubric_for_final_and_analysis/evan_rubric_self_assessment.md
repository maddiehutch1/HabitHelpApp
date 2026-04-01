# Micro-Deck Final Rubric Self-Assessment

**Generated:** April 1, 2026
**Repo:** MicroDeckApp
**Rubric Reference:** `rubric_for_final_and_analysis/final_proj_rubric.md`

---

## Executive Summary

| Grader | Raw Score | Weight | Weighted Points |
|--------|-----------|--------|-----------------|
| Jason (Product & System Design) | **70/100** | 45% | 63.0 / 90 |
| Casey (Technical Process) | **86/100** | 45% | 77.4 / 90 |
| Guest Grader (Presentation) | **TBD** | 10% | TBD / 20 |
| **Projected Total** | | | **~157 / 200 (with avg presentation)** |

**Projected Grade: B- to C+** (depending on presentation quality)

The project has **strong technical process documentation** and **excellent logging/debugging infrastructure**, but has significant gaps in **customer research evidence** and **git history patterns** that pull the score down.

---

## REQUIRED DELIVERABLES CHECKLIST

These are the specific artifacts that must be submitted for the final. This is the most actionable section of this report.

| # | Deliverable | Status | Location / Notes |
|---|------------|--------|------------------|
| 1 | **GitHub repo link** | ✅ Ready | Repo exists and is on GitHub. Just submit the link. |
| 2a | **Deep customer analysis** | ⚠️ Partial | PRD section 2 has personas; `ai/guides/habit-help-market-research.md` has competitive landscape. But there's no standalone "customer analysis" artifact pulling it all together for the presentation. **Need to create a dedicated customer analysis doc or slide.** |
| 2b | **Founding hypothesis** | ⚠️ Partial | The PRD section 1.2 states the core problem (intention-behavior gap), and Phase 4 doc has 8 numbered hypotheses (H1-H8). But there's no single, clearly labeled "founding hypothesis" statement as a presentation artifact. **Need to explicitly state and label it.** |
| 2c | **2 real customer conversations documented** | ❌ Missing | **Zero interview notes, conversation summaries, or customer feedback files exist anywhere in the repo.** Commit `6721594` references "after user testing" but no results are documented. This is a hard requirement — must create documentation of at least 2 real conversations. |
| 2d | **1 falsification test executed** | ❌ Missing | PRD section 7.3 defines 5 failure indicators with detection methods, but **no documented execution or results**. Need to write up: what test was run, with whom, what was measured, what the results were. |
| 2e | **2x2 differentiation grid** | ❌ Missing | The competitive analysis exists as a comparison table (PRD section 8, market research doc), but **no 2x2 grid/matrix visualization exists**. Need to create one (e.g., axes like "Complexity vs Initiation Focus" or "Restriction vs Empowerment"). |
| 2f | **Systems architecture design with leverage points** | ❌ Missing | `aiDocs/architecture.md` covers the *technical* architecture (Flutter, SQLite, packages), but it does **NOT** identify leverage points, show the problem in the system, or show where the solution targets the system. Need a *systems thinking* diagram, not a tech stack diagram. |

### Summary: 2 of 7 deliverables are ready. 5 need to be created.

### What "Ready" vs "Missing" Means

The **partial** items (2a, 2b) have raw content scattered across docs but need to be pulled into presentation-ready artifacts.

The **missing** items (2c, 2d, 2e, 2f) don't exist in any form in the repo and must be created from scratch:

- **2c (Customer conversations):** You need to actually document 2 real conversations. If you've had them but didn't write them up, do so now. If you haven't, you need to have them. At least some should be outside friends/family.
- **2d (Falsification test):** Pick one of your failure indicators from PRD 7.3 (e.g., "Differentiation perception < 5/7") and document running it. Show: hypothesis, method, who you tested with, results, what you learned.
- **2e (2x2 grid):** Create a 2x2 differentiation matrix positioning Micro-Deck against competitors. Suggested axes: "Behavior Change Approach" (Restriction ↔ Initiation) vs "User Burden" (High Setup ↔ Zero Setup). Place Opal, Forest, Streaks, one sec, and Micro-Deck on it.
- **2f (Systems architecture with leverage points):** This is NOT your tech stack diagram. Draw a systems diagram showing: the problem (intention-behavior gap), the system actors (user, phone, habits, emotions, existing tools), feedback loops, and where Micro-Deck intervenes as a leverage point.

---

## Jason's Product & System Design (45% of Final Grade)

*Each area scored out of 20 points. Total: 100 raw → 90 weighted.*

### 1. System Understanding — 14/20

**What exists:**
- `aiDocs/architecture.md` — solid technical architecture doc covering platform, dependencies, API decisions, data models, folder structure
- PRD describes the system well (behavioral science foundation, competitive positioning, feature specifications)
- The system is clearly understood from a *technical* perspective

**What's missing or weak:**
- **No visual system diagram** found in the repo (no images, mermaid diagrams, or ASCII diagrams). The rubric explicitly asks for a system diagram that evolved since midterm
- Architecture doc is dated **February 2026** — never updated since. The rubric asks: "Your diagram should look different from midterm because your understanding is different"
- No documented evidence of **what you got wrong** at midterm or **new elements discovered** by actually building
- No evidence of **leverage points tested** in practice

**Recommendation:** Create/update a system diagram showing how your understanding changed. Document what surprised you during building. Even 1 page of "what changed since midterm" would strengthen this significantly.

---

### 2. Problem Identification — 15/20

**What exists:**
- Problem statement is clear and compelling in PRD section 1.2: bridging the intention-behavior gap for people with ADHD/executive dysfunction
- PRD section 7.3 has well-defined **Failure Indicators** with detection methods (e.g., "Differentiation perception score < 5/7")
- Commit `6721594`: *"Updated PRD with success and failure metrics after user testing"* — indicates falsification tests were considered after testing
- Qualitative metrics in PRD section 7.2 include pre/post survey measures

**What's missing or weak:**
- **No documented results** of falsification tests. The rubric says: "Falsification tests must be executed with documented results"
- The failure indicators exist as design but there's no file showing: "We ran these tests, here's what we found"
- No documented evidence of whether problem was refined based on real-world experience

**Recommendation:** Document the actual results of your user testing sessions. Even brief notes like "We tested with X users, here's what we found against our failure indicators" would be very valuable.

---

### 3. Customer Focus — 13/20

**What exists:**
- Target customer is well-defined with clinical specificity: ADHD, executive dysfunction, digital burnout (PRD section 2)
- Comprehensive competitive analysis in `ai/guides/habit-help-market-research.md` and PRD section 8
- 6 competitor categories analyzed with specific user pain points
- Clear product positioning: "No major app currently positions itself as an *initiation ritual*"

**What's missing or weak:**
- **No interview notes, feedback documents, or customer research files** found anywhere in the repo
- No evidence of talking to people **beyond friends and family** — this is explicitly required for the final
- No documentation of how customer understanding **deepened** through research
- Competitive analysis doesn't show evidence of updating based on building experience
- Solution positioning appears to be based on initial assumptions, not validated customer feedback

**Recommendation:** This is a critical gap. Add interview notes, even retroactively documented. Show who you talked to, what they said, and how it changed your thinking. The rubric explicitly requires interviews **outside your immediate social circle**.

---

### 4. Success & Failure Planning — 15/20

**What exists:**
- Detailed quantitative metrics (PRD 7.1): activation rate, time-to-first-completion, day-7 retention, session abandon rate, etc.
- Detailed qualitative metrics (PRD 7.2): task initiation success, overwhelm reduction, guilt/shame reduction, perceived self-efficacy — all with specific measurement methods
- Failure indicators (PRD 7.3): 5 indicators with detection methods and what each means
- Revenue model was **honestly reassessed**: "insufficient evidence to validate pricing" — removed from v1 scope (this is good process!)

**What's missing or weak:**
- No documentation of **actual measurement** against these criteria
- No evidence that success/failure indicators were **tested against reality**
- Pivot plans remain hypothetical — not informed by real data
- The metrics exist as design artifacts but aren't shown as living tools that were used

**Recommendation:** Document where you stand against even 2-3 of your metrics. The revenue model removal is a good story to tell — show the evidence that led to that decision.

---

### 5. Customer Interaction — 13/20

**What exists:**
- Language changes in Phase 6 suggest *some* feedback influenced the product:
  - Goal prompt changed: "What do you want to work toward?" → "What feels big and difficult right now?"
  - Action prompt changed: "What's one tiny thing that starts it?" → "What's one tiny step you could take first?"
- Commit message references "after user testing"
- AI suggestion features ("I'm stuck", "Make this smaller") suggest user pain points were heard

**What's missing or weak:**
- **No documented feedback loop**: engage → learn → change → re-engage
- No files showing specific features that exist **because** of customer feedback
- No interview records beyond friends and family
- Cannot prove that talking to people made the solution better — the key rubric question

**Recommendation:** Document the feedback loop explicitly. Even a single markdown file showing: "User X said Y, so we built Z, then we went back and they said W" would dramatically improve this score.

---

### Jason's Section Summary

| Area | Score | Level |
|------|-------|-------|
| System Understanding | 14/20 | Developing |
| Problem Identification | 15/20 | Developing |
| Customer Focus | 13/20 | Developing |
| Success & Failure Planning | 15/20 | Developing |
| Customer Interaction | 13/20 | Developing |
| **Total** | **70/100** | |

**Weighted: 70 x 0.90 = 63.0 / 90**

---

## Casey's Technical Process (45% of Final Grade)

*Each area scored out of 25 points. Total: 100 raw → 90 weighted.*

### 1. PRD & Document-Driven Development — 23/25

**What exists:**
- **Exceptional PRD** (`aiDocs/prd.md`): ~467 lines, 10 sections covering product positioning, personas, behavioral science, features, data models, metrics, competitive landscape, out-of-scope, and open questions
- Clear document pipeline: PRD → high-level project plan → phase plans → phase roadmaps → changelog
- **29 markdown files** devoted to planning and process documentation
- Each phase has paired plan + roadmap documents
- context.md uses **bookshelf pattern** with a "Key Documents" table
- Documents are **living artifacts**: status marks updated, completion dates noted, PRD revised multiple times
- Git evidence of iterative doc updates (commits `6721594`, `44024a0`, `a96dd33`)
- Engineering philosophy ("avoid over-engineering") repeated consistently across all phase docs
- PRD has "Open Questions" section — evidence of human-AI collaboration, not one-shot generation

**Minor gaps:**
- Architecture doc not updated since February (doesn't reflect removal of `in_app_purchase`, addition of `http`, etc.)
- Phase 7 has a plan but no corresponding "complete" roadmap document yet

**This is exemplary work for a class project.**

---

### 2. AI Development Infrastructure — 20/25

**What exists:**
- **`CLAUDE.md`**: exists but is minimal (3 lines — just a redirect to `context.md`)
- **`.cursorrules`**: excellent (68 lines with hard constraints, code style, architecture patterns, design principles, development process). This is the actual behavioral guidance file
- **`context.md`**: solid bookshelf pattern, current (March 2026), documents all screens and current focus
- **`aiDocs/` folder**: 5 docs (context, PRD, MVP, architecture, CLI test plan)
- **`ai/` folder**: 24 additional docs (roadmaps, guides, changelog)
- **`.gitignore`**: covers `.env`, `.env.*`, `.testEnvVars`, IDE files, Flutter build artifacts. Well-organized with section comments
- **No secrets committed** in the repository

**Gaps:**
- **CLAUDE.md is too thin** — the rubric explicitly calls this out as a sub-criterion. Having `.cursorrules` with the real content is fine functionally, but the grader may expect CLAUDE.md itself to have behavioral guidance
- **MCP configs not explicitly listed** in `.gitignore` (though rubric says this matters less now)
- **Git workflow is weak**: only **2 PRs** and **2 branches** (main + evan_dev). Most work was committed directly to main. The rubric asks for "branching, meaningful commits, and PRs"
- **`ai/` folder is commented out** in `.gitignore` — it's tracked, which is fine for aiDocs, but the rubric suggests `ai/` should be gitignored. The ai/ folder contains roadmaps and guides which probably *should* be tracked for this class

**Recommendation:** Move the behavioral content from `.cursorrules` into `CLAUDE.md` (or at least add a meaningful summary). Consider creating more branches/PRs for remaining work.

---

### 3. Phase-by-Phase Implementation & Working Demo — 19/25

**What exists:**
- **7+ phases** completed with paired plan/roadmap documents, all with checked-off milestones:
  - Phase 0: Foundation
  - Phase 1: MVP Demo
  - Phase 2: Polish & Stability
  - Phase 3: v1 Feature Build
  - Extra: CLI Testing
  - Phase 5: Daily Refresh
  - Phase 6: Tiny Start Unified
  - Phase 7: Voice AI Suggestions
- **18 roadmap/plan docs** in `ai/roadmaps/complete/`
- All roadmaps have **manual testing checklists with every item checked off** (e.g., Phase 6 has 34 checkbox items, all marked complete)
- App is a **substantial Flutter application** with 9+ screens, SQLite database, Riverpod state management, structured logging, voice input, AI suggestions, notifications
- **Integration tests** exist (`integration_test/app_test.dart`) with 5+ test scenarios
- **Unit tests** for data layer (`test/unit/card_repository_test.dart`)
- **Widget tests** for multiple screens

**Gaps — Git History is the main concern:**

| Metric | Finding | Concern Level |
|--------|---------|---------------|
| Total commits | **21** (including merges) | Low for a semester project |
| Commit spread | 6 on Feb 23, 5 on Mar 30, 3 on Mar 31 | Heavy burst pattern |
| Largest gap | Feb 24 → Mar 23 (nearly **1 month**) | Significant |
| PRs | Only **2** | Weak branching workflow |
| Contributors | maddiehutch1 (17), tchappy15 (3), evan (1) | Uneven distribution |
| Branches | main + evan_dev only | Minimal branching |

The rubric says: *"Git history shows iterative, incremental progress across the semester"* and *"not one-shot prompted."* The git history shows concentrated bursts rather than steady iteration. The code quality suggests careful development, but the commit pattern could be interpreted as late-stage bulk commits.

Some commit messages are informal: `"commiting eveyrhting i can ughghghg"` — this doesn't help the grading impression.

**Recommendation:** Make more frequent, smaller commits going forward. Create feature branches and PRs for any remaining work. Consider if any local work was done that wasn't pushed — if so, the graders can only see what's in git.

---

### 4. Structured Logging & Debugging — 24/25

**What exists:**
- **Structured logging via Dart `logging` package** with `app_logger.dart`:
  - 5 named loggers: `appLog`, `cardRepoLog`, `scheduleRepoLog`, `notificationLog`, `voiceLog`
  - Format: `[LEVEL] LoggerName: message`
  - Setup called in `main.dart`
- **Logging genuinely integrated** across **7+ application files** with 40+ log calls:
  - `card_repository.dart`: logs all CRUD operations
  - `schedule_repository.dart`: logs schedule operations
  - `notification_service.dart`: logs lifecycle and permissions
  - `voice_service.dart`: logs recognition operations
  - `app.dart`: logs cold-launch state
  - `voice_input_sheet.dart`: logs recording state
- **Multiple log levels used**: `info()`, `fine()`, `warning()`, `severe()`
- **4 CLI test scripts**:
  - `scripts/test.sh` (Bash) — analyze → format → unit → integration
  - `scripts/test.ps1` (PowerShell) — equivalent Windows version
  - `scripts/analyze.sh` — fast first-pass
  - `scripts/build.sh` — release APK compile check
- **Proper exit codes**: `set -e`, explicit `exit 1` on failures, `$ErrorActionPreference = "Stop"` in PowerShell
- **Test suite**: unit tests (with in-memory SQLite), widget tests, integration tests
- **Test-log-fix loop evidence**: commits show `b4d147c` (add logging) → `ddd8092` (add CLI tests) → `1a6f0a0` (CLI testing success, fix errors) → `bcb73b3` (ran CLI tests, fixed issues)
- **Excellent documentation**: `TEST_README.md` with AI agent debugging loop, `cliTestPlan.md` with feature-to-test matrix

**This area is near-exemplary.** Minor deduction for no timestamps in log output and no use of exit code 2.

---

### Casey's Section Summary

| Area | Score | Level |
|------|-------|-------|
| PRD & Document-Driven Dev | 23/25 | Exemplary |
| AI Development Infrastructure | 20/25 | Proficient |
| Phase Implementation & Demo | 19/25 | Developing+ |
| Structured Logging & Debugging | 24/25 | Exemplary |
| **Total** | **86/100** | |

**Weighted: 86 x 0.90 = 77.4 / 90**

---

## Guest Grader (10% of Final Grade) — TBD

Presentation hasn't happened yet. Assuming average performance (85/100):

**Projected: 85 x 0.20 = 17.0 / 20**

---

## Projected Grade Calculation

| Grader | Raw | Weighted |
|--------|-----|----------|
| Jason | 70/100 | 63.0 |
| Casey | 86/100 | 77.4 |
| Guest (projected) | 85/100 | 17.0 |
| **Total** | | **157.4 / 200 = 78.7%** |

**Projected Grade: C+ (77% threshold = 154 pts)**

---

## Priority Actions — Required Deliverables First

**These are ordered by: required deliverables first, then grade-improvement actions.**

### CRITICAL — Required Deliverables That Don't Exist Yet

| # | Deliverable | What To Create | Maps To |
|---|------------|----------------|---------|
| 1 | **2 customer conversations (2c)** | Write up 2 real conversations. Format: who they are, context, what you asked, what they said, what you learned, what changed. At least 1 must be outside friends/family. | Jason areas 3 & 5 (+8-12 pts) |
| 2 | **1 falsification test (2d)** | Pick a failure indicator from PRD 7.3. Document: hypothesis, method, participants, results, interpretation. Example: "We tested differentiation perception with 5 users using a post-session 1-7 scale. Average score was X. This means Y." | Jason area 2 (+5-8 pts) |
| 3 | **2x2 differentiation grid (2e)** | Create a 2-axis grid. Suggested: X-axis = "Behavior Change Approach" (Restriction ↔ Initiation), Y-axis = "User Burden" (High Setup ↔ Zero Setup). Plot: Opal, Forest, Streaks, one sec, Tiimo, Micro-Deck. | Jason area 3 (+2-3 pts) |
| 4 | **Systems architecture with leverage points (2f)** | Draw a systems thinking diagram (NOT tech stack). Show: user's stuck moment, emotional feedback loops (guilt, avoidance), existing tool interventions (blockers, trackers), and where Micro-Deck's initiation ritual breaks the cycle. Label leverage points. | Jason area 1 (+4-6 pts) |
| 5 | **Founding hypothesis statement (2b)** | Write a clear, labeled statement: "Our founding hypothesis is that [people with ADHD/executive dysfunction] fail at habit initiation not because of motivation but because of [the friction of starting]. Micro-Deck's 2-minute initiation ritual reduces this friction by [specific mechanism]." | Jason area 2 (+1-2 pts) |
| 6 | **Customer analysis artifact (2a)** | Pull together: target personas (from PRD), market size (from market research), behavioral science basis (from PRD section 3), and customer interview insights into one presentation-ready document or slide deck section. | Jason area 3 (+2-3 pts) |

### ALSO IMPORTANT — Grade Improvement

| # | Action | Est. Points Recoverable | Effort |
|---|--------|------------------------|--------|
| 7 | **Beef up CLAUDE.md** — Move behavioral guidance from `.cursorrules` into `CLAUDE.md`. This is an explicit grading sub-criterion. | +2-3 pts (Casey area 2) | Very Low |
| 8 | **Document success metric measurements** — Where do you stand against PRD section 7 metrics? Report findings, even partial. | +3-5 pts (Jason area 4) | Low |
| 9 | **Update architecture doc** — Reflect current state (added `http`, `speech_to_text`, removed `in_app_purchase`). | +1-2 pts (Casey areas 1 & 2) | Low |
| 10 | **Improve git workflow** — More frequent commits, feature branches, PRs for remaining work. | +2-4 pts (Casey area 3) | Ongoing |

### PRESENTATION PREP

| # | Action | Details |
|---|--------|---------|
| 11 | Practice the demo — make sure it works live on a real device |
| 12 | Prepare a "what we learned" slide with honest surprises and changes |
| 13 | Each team member should be able to explain their contributions |
| 14 | Prepare Q&A talking points about trade-offs and limitations |

---

## Optimistic Scenario (If All Actions Completed)

If the team addresses items 1-7 before the final:

| Grader | Current Raw | Improved Raw | Improved Weighted |
|--------|------------|-------------|-------------------|
| Jason | 70/100 | ~85/100 | 76.5 |
| Casey | 86/100 | ~92/100 | 82.8 |
| Guest | 85/100 | 88/100 | 17.6 |
| **Total** | | | **176.9 / 200 = 88.5%** |

**Improved Grade: B+** (potentially approaching A- with strong presentation)

---

## Git History Analysis

```
COMMITS PER DAY:
  6  2026-02-23  (logging, CLI testing, cleanup, icon, readme)
  5  2026-03-30  (PR #1 merge, fixes, CLI tests, phase 5-7 updates)
  3  2026-03-31  (PR #2 merge, docs, rubric)
  1  2026-03-23  (ai folder push)
  1  2026-02-24  (CLI testing success)
  1  2026-02-21  (Phase 3 updates)
  1  2026-02-20  (architecture, context, PRD updates)
  1  2026-02-19  (MVP, PRD, market research)
  1  2026-02-18  (README update)
  1  2026-02-11  (Initial commit)

CONTRIBUTORS:
  17  maddiehutch1
   3  tchappy15
   1  evan

BRANCHES:
  main (primary)
  evan_dev (remote only)

PULL REQUESTS: 2
  #1: maddiehutch1/evan_dev → main (Mar 30)
  #2: maddiehutch1/document-updates → main (Mar 31)
```

**Timeline concern:** The 1-month gap (Feb 24 → Mar 23) with only 1 commit is the biggest risk factor for the "iterative, incremental progress" criterion.

---

## Quick Evidence Checklist (From Rubric)

### Jason's Product & System Design

**System Understanding:**
- [ ] System diagram has evolved since midterm
- [x] Team can articulate what they learned (in PRD open questions, phase iterations)
- [ ] Leverage points validated through experience

**Problem Identification:**
- [x] Problem statement has matured (refined through phases)
- [ ] Falsification tests executed with documented results
- [x] Evolution justified (revenue model removed with rationale)

**Customer Focus:**
- [ ] Customer understanding deepened beyond friends and family
- [x] Competitive analysis exists and is detailed
- [ ] Solution positioning reflects validated understanding

**Success & Failure Planning:**
- [x] Success/failure criteria defined (PRD 7.1, 7.2, 7.3)
- [ ] Criteria tested against reality with documented results
- [x] Revenue model pressure-tested (removed based on evidence)

**Customer Interaction:**
- [ ] Interaction continued with clear feedback loop
- [ ] Specific features shaped by documented customer feedback
- [ ] Interviews beyond friends and family documented

### Casey's Technical Domain

**PRD & Doc-Driven Dev:**
- [x] PRD exists and is comprehensive
- [x] Development driven by documents (PRD → plan → roadmap → implementation)
- [x] Documents are living artifacts
- [x] Evidence of AI-assisted iteration

**AI Development Infrastructure:**
- [x] AI folder structure with context.md, architecture docs
- [x] context.md uses bookshelf pattern and is current
- [x] `.cursorrules` with detailed behavioral guidance
- [ ] `CLAUDE.md` with behavioral guidance (currently just a redirect)
- [ ] Git workflow with branching, meaningful commits, PRs (only 2 PRs)
- [x] `.gitignore` covers secrets and environment files
- [x] No committed secrets

**Phase-by-Phase Implementation:**
- [x] Roadmaps with tasks checked off (all 7 phases complete)
- [ ] Git history showing iterative development (concentrated bursts instead)
- [x] Evidence of multi-session workflow in docs
- [x] Roadmaps updated as living documents
- [x] App appears to be runnable (Flutter app with integration tests)

**Structured Logging & Debugging:**
- [x] Structured logging implemented (Dart logging package, named loggers)
- [x] Logging integrated into actual application code (7+ files, 40+ calls)
- [x] CLI test scripts exist (4 scripts: test.sh, test.ps1, analyze.sh, build.sh)
- [x] Proper exit codes (set -e, explicit exit 1)
- [x] Evidence of test-log-fix loop in git history

---

*This assessment is based on repository contents as of April 1, 2026. Scores are estimates — actual grading depends on the presentation narrative and grader interpretation.*
