# Final Deliverables — Task Assignments

**Status:** 2 of 7 required deliverables exist. 5 must be created.
**Projected grade now:** C+ (~157/200)
**Projected grade if we finish everything:** B+ (~177/200)
**All materials due:** April 8

---(/tmp/business_pdfs/lecture1-seeing-clearly.pdf

## Rules for Everyone

- **Use feature branches + PRs** for all work you push. We only have 2 PRs right now — graders want to see more. Name your branch `yourname/task-description`.
- **Commit often** with clear messages. No more `"commiting eveyrhting i can ughghghg"`.
- Each person should be able to **explain their specific contributions** during Q&A.

---

## Evan

| #   | Task                                  | Deliverable                          | Details                                                                                                                                                                                                                                                                                                            |
| --- | ------------------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | **Systems architecture diagram** (2f) | Diagram image or mermaid in markdown | Draw a _systems thinking_ diagram (NOT the tech stack). Show: user's stuck moment → emotional loops (guilt, avoidance, overwhelm) → existing tools (blockers, trackers) failing → where Micro-Deck's initiation ritual breaks the cycle. Label 2-3 leverage points. This is for the presentation — make it visual. |
| 2   | **Beef up CLAUDE.md**                 | Updated `CLAUDE.md`                  | Copy the key sections from `.cursorrules` into `CLAUDE.md` (hard constraints, code style, architecture, design principles). Graders explicitly look for CLAUDE.md with behavioral guidance — ours is currently 3 lines.                                                                                            |
| 3   | **Update architecture doc**           | Updated `aiDocs/architecture.md`     | Update the "Deferred/Excluded" table to reflect current state: `http` and `speech_to_text` are now included, `in_app_purchase` was removed, `uuid` is now used. Change "Last Updated" to April 2026.                                                                                                               |
| 4   | **Demo prep**                         | Working demo on real device          | Make sure the app builds and runs on a real device for the live demo. Test the full loop: cold launch → onboarding → timer → haptic → deck → add card (voice + type) → AI suggestions. Have a backup plan if the API key doesn't work live.                                                                        |

---

## Maddie

| #   | Task                                   | Deliverable                      | Details                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --- | -------------------------------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | **Customer conversation #1** (2c)      | Documented interview in repo     | Have a real conversation with someone **outside friends/family** (classmate who fits the target persona, someone with ADHD, a productivity app user, etc.). Document: who they are (anonymous is fine), what you asked, what they said, what you learned, what it changed about the product.                                                                                                                                                                                   |
| 2   | **Customer analysis artifact** (2a)    | Presentation-ready doc or slides | Pull together into one document: target personas (from PRD section 2), market size (from market research — 15.5M US adults with ADHD), behavioral science basis (PRD section 3), competitive positioning, and insights from the customer conversations. This is the "deep analysis of your customer" deliverable.                                                                                                                                                              |
| 3   | **Founding hypothesis statement** (2b) | Clearly labeled statement        | Write 1-2 paragraphs: "Our founding hypothesis is that people with ADHD and executive dysfunction fail at habit initiation not because they lack motivation, but because the friction of starting is too high. Existing tools (blockers, trackers, planners) address the wrong moment. Micro-Deck's 2-minute initiation ritual targets the specific stuck moment with zero setup, no judgment, and a haptic completion signal." Tie it to evidence from conversations and PRD. |

---

## Thomas

| #   | Task                              | Deliverable                             | Details                                                                                                                                                                                                                                                                                                                                                                                                |
| --- | --------------------------------- | --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | **Customer conversation #2** (2c) | Documented interview in repo            | Same format as Maddie's — have a real conversation with a different person. Ideally someone who has tried other habit/productivity apps and can speak to why they stopped using them. At least one of the two conversations (yours or Maddie's) must be outside friends/family.                                                                                                                        |
| 2   | **2x2 differentiation grid** (2e) | Visual grid (image, slide, or markdown) | Create a 2x2 matrix. Suggested axes: X = "Approach" (Restriction ↔ Empowerment), Y = "User Burden" (High Setup ↔ Zero Setup). Place: Opal, Freedom (restriction/high), Forest (restriction/medium), one sec (restriction/low), Streaks, Habitify (empowerment/high), Tiimo (empowerment/high), **Micro-Deck** (empowerment/zero). Micro-Deck should be alone in its quadrant — that's the white space. |
| 3   | **Q&A prep doc**                  | Talking points markdown                 | Write up answers to likely Q&A questions: Why Flutter? Why no accounts/cloud? Why remove monetization? What would you do differently? What's the hardest technical challenge? What surprised you about customers? What's next if you kept building?                                                                                                                                                    |

---

## David

| #   | Task                            | Deliverable                | Details                                                                                                                                                                                                                                                                                                                                                          |
| --- | ------------------------------- | -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | **Falsification test** (2d)     | Documented test + results  | Pick one failure indicator from PRD 7.3 (recommend: "Differentiation perception" — ask users to rate 1-7 how different this feels from other apps). Run it with 3-5 people. Document: hypothesis, method, who participated, raw scores, interpretation, what it means for the product. Even if results are mixed, that's fine — honest results are what matters. |
| 2   | **Success metric measurements** | Results doc                | Report where we stand on at least 3 metrics from PRD 7.1/7.2. Can overlap with falsification test participants. Examples: time-to-first-completion (can you time it?), activation rate (did they complete 1 card?), overwhelm reduction (pre/post 1-7 scale). Doesn't need to be a huge study — even 3-5 data points show we measured.                           |
| 3   | **"What we learned" slide**     | Presentation slide content | Write up honest reflections: What surprised us? What did we get wrong? What would we do differently? Include: the monetization pivot (removed freemium), the language changes (from "work toward" to "stuck moment"), the template removal (replaced with AI). This is the storytelling element graders love.                                                    |

---

## Presentation Slides (Split)

Everyone owns their section of the presentation. Coordinate on a shared slide deck.

| Slide(s)                               | Owner              | Content                                                              |
| -------------------------------------- | ------------------ | -------------------------------------------------------------------- |
| Problem + Founding Hypothesis          | **Maddie**         | Customer analysis, hypothesis, why this matters                      |
| System Diagram + Leverage Points       | **Evan**           | Systems architecture, where we intervene, what changed since midterm |
| Customer Conversations + Falsification | **David + Thomas** | Interview highlights, test results, 2x2 grid                         |
| Demo                                   | **Evan**           | Live walkthrough of core loop + AI features                          |
| Technical Process                      | **Evan**           | Brief: doc-driven dev, logging, CLI tests, phase structure           |
| What We Learned                        | **David**          | Honest reflections, surprises, what we'd do differently              |
| Q&A                                    | **Everyone**       | Thomas has prep doc, but all should be ready                         |

---

## File Locations

Put all new deliverable docs here so graders can find them:

```
rubric_for_final_and_analysis/
├── final_proj_rubric.md          (already exists)
├── rubric_self_assessment.md     (already exists, gitignored)
├── final_task_assignments.md     (this file)
├── customer_conversation_1.md    ← Maddie
├── customer_conversation_2.md    ← Thomas
├── falsification_test.md         ← David
├── success_metrics_results.md    ← David
├── founding_hypothesis.md        ← Maddie
├── customer_analysis.md          ← Maddie
├── differentiation_grid.md       ← Thomas (or image file)
├── system_diagram.md             ← Evan (or image file)
├── qa_prep.md                    ← Thomas
└── what_we_learned.md            ← David
```

---

## Quick Summary

| Person     | Required Deliverables                                                           | Grade Improvement                      | Presentation                    |
| ---------- | ------------------------------------------------------------------------------- | -------------------------------------- | ------------------------------- |
| **Evan**   | Systems diagram (2f)                                                            | CLAUDE.md, architecture doc, demo prep | Demo + technical process slides |
| **Maddie** | Customer conversation #1 (2c), customer analysis (2a), founding hypothesis (2b) | —                                      | Problem + hypothesis slides     |
| **Thomas** | Customer conversation #2 (2c), 2x2 grid (2e)                                    | Q&A prep                               | Customer + falsification slides |
| **David**  | Falsification test (2d)                                                         | Success metrics                        | What we learned slides          |
