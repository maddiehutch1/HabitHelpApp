# Unit 2: Ideation & Planning with AI

*Using AI to plan before you build*

## Industry Context

"Top engineers at Anthropic, OpenAI say AI now writes 100% of their code" - Fortune, January 29, 2026

## Reading Recap - "Management as AI Superpower" (Ethan Mollick)

- As AI handles execution, roles shift from doing to delegating
- Core Equation: Human Baseline Time vs. AI Process Time x Probability of Success
- Management skills = AI skills (scoping, defining deliverables, evaluating output)
- Subject matter expertise matters (experts give better instructions, spot errors faster)
- "Soft" skills are hardest (knowing what good looks like, explaining clearly)

> "The people who thrive will be the ones who know what good looks like -- and can explain it clearly enough that even an AI can deliver it."

## What We'll Cover Today

1. Ideation with AI - Brainstorming techniques
2. Market Research - Using Perplexity
3. Project Documentation - PRD, plan docs, roadmap docs, MVP
4. Git Workflow Concepts - Branching, commits, PRs with AI
5. Iterative Refinement - Making docs better

---

## Part 1: Ideation with AI

*Generate ideas you wouldn't think of alone*

### Why Ideate with AI?

- Broad knowledge across domains
- Generates unique ideas you wouldn't conceive independently
- Fast iteration on concepts
- Judgment-free exploration (safely test "bad" ideas)
- Cross-domain synthesis (combines concepts from different fields)

### Technique: Quantity Generation

```
I want to build something that helps college students manage their time.
Give me 15 different product ideas, ranging from simple apps to ambitious platforms.
Include at least 3 ideas that seem "weird" or unusual.
```

### Technique: Constraint-Based Ideation

```
I need a solution for [problem] that:
- Can be built by 3 students in 8 weeks
- Requires no budget for infrastructure
- Works offline
- Doesn't require user accounts
Generate 10 ideas that fit ALL these constraints.
```

### Technique: Combination Ideation

```
Combine these two concepts:
- Concept A: Habit tracking apps
- Concept B: Social accountability
What would a product look like that merges these approaches?
Generate 5 product ideas.
```

### Expanding Ideas - Deep Dive

```
I'm considering building [idea].
Help me explore:
1. 5 different ways this could work
2. 3 different user personas it might serve
3. The simplest possible version
4. The most ambitious version
5. Similar products and how this differs
```

### Challenging Ideas - Devil's Advocate

```
Here's my product idea: [description]
Play devil's advocate. Tell me:
- Why this might fail
- What assumptions might be wrong
- Who wouldn't want to use this
- What's the hardest part I'm underestimating
```

### Assumption Testing

```
My product assumes that [assumption].
Is this assumption valid?
What evidence supports or contradicts it?
What would happen if this assumption is wrong?
```

---

## Part 2: Market Research with Perplexity

*Web-connected research with citations (Claude and Gemini also work in web search mode)*

### Why Perplexity?

| Feature | Benefit |
|---------|---------|
| Web-connected | Current information |
| Citations | Verify sources |
| Synthesis | Multiple sources combined |
| Structured | Good for analysis |

### Finding Competitors (from "Click!")

```
What companies and products currently solve [problem]?
For each, tell me:
- Company name and product
- Pricing model
- Target audience
- Key features
- What users complain about (from reviews)

Also identify:
- Substitute solutions (workarounds instead of a product)
- The "do nothing" option (tolerating the problem)
- The "800-pound gorilla" (strongest alternative)
```

### Competitive Positioning

```
I'm building [product description].
Compare to [Competitor A], [B], and [C].
Create a comparison table: Features, Pricing, Target user, Strengths, Weaknesses
Where is the gap in the market?
```

### Market Size (TAM/SAM/SOM)

```
Help me estimate market size for [category]:
TAM (Total Addressable Market): Everyone who could possibly use this
SAM (Serviceable Addressable Market): The segment we can reach
SOM (Serviceable Obtainable Market): Realistic first-year target
Provide numbers with sources.
```

### User Personas

```
I'm building [product] for [general audience].
Develop 3 detailed user personas:
- Name and demographics
- Job/role and daily challenges
- Goals and motivations
- Pain points my product addresses
- How they currently solve this
- What would make them switch
- Potential objections
```

### Founding Hypothesis (from "Click!")

```
For [target customer], who has [problem],
our [approach] will solve it better than [competition]
because [differentiation].
```

Scoring criteria:
- Is the customer specific enough?
- Is the problem verified, not assumed?
- Will people choose this over alternatives AND doing nothing?
- Is the differentiation radical or incremental?

> If you can't write a compelling hypothesis, you don't understand your market yet.

---

## Part 3: Project Documentation

### Document Hierarchy

```
Project Description    <- 1-2 paragraphs
PRD                    <- What & Why
Plan Doc               <- What & How
Roadmap Doc            <- Checklist
MVP Definition         <- Minimum viable
Architecture Doc       <- How it's built
```

### PRD Structure

1. Problem Statement
2. Target Users
3. Goals and Success Metrics
4. Key Features (P0, P1, P2)
5. User Stories
6. Out of Scope
7. Risks and Mitigations
8. Timeline and Milestones

### PRD as Immutable Source of Truth

- PRD captures original requirements and intent
- Other docs change; PRD should not
- Maintains "long-term memory" of agreed items
- If requirements change: new PRD version or addendum

### Plan Documents - The WHAT and HOW

Purpose: Detailed work breakdown and implementation approach

File naming: `ai/roadmaps/2025-12-05_feature-name_plan.md`

### Roadmap Documents - The Checklist

Purpose: Task checklist organized by phases for tracking progress

File naming: `ai/roadmaps/2025-12-05_feature-name_roadmap.md`

### Plan vs Roadmap

| Aspect | Plan | Roadmap |
|--------|------|---------|
| Focus | The WHAT and HOW | The checklist |
| Content | Detailed work breakdown | Task list by phases |
| Details | Implementation approach | Clear completion criteria |
| Includes | Technical considerations | Progress tracking |
| Use Case | For understanding | For execution |

Both needed -- keeps AI organized and ensures nothing is missed.

### The Research Phase

For complex tasks, research first -- document what exists with no opinions:

```
Review ai/context.md.
Then research how [feature/area] currently works.
Document what you find. DO NOT suggest changes.
Save to ai/roadmaps/YYYY-MM-DD_topic_research.md
```

When to use: Complex changes, unfamiliar code, third-party libraries
When to skip: Simple changes, greenfield projects

### PRD -> Research -> Plan -> Roadmap Pipeline

1. **PRD** - What & Why (defines requirements - immutable)
2. **Research** - What exists now (facts only, no opinions)
3. **Plan** - What & How (describes implementation strategy)
4. **Roadmap** - Checklist to execute (execution steps)
5. **Implementation** - AI implements following the roadmap

### MVP Definition - Be Ruthless About Scope

```
Here's my PRD: [reference]
Define the MVP:
1. What's the ONE core problem to solve?
2. Minimum feature set?
3. What can we cut that feels important but isn't?
4. Simplest technical approach?
5. How will we validate with users?
We have [X weeks] and [Y team members].
```

---

## Part 4: Git Workflow Concepts

### Why Git Matters for AI Development

AI needs to understand version control:
- Reads your git history to understand changes
- Can commit code with meaningful messages
- Can create branches for features
- Can review uncommitted changes
- Works with PR workflows

Not just a backup system -- it's collaboration infrastructure.

### Branching Mental Model

```
main -----*-------*-------*-------->
           \             /
            \           /
  feature    *-----*---*
          [AI develops here]
```

- `main` = production-ready code
- Feature branches = isolated work
- AI can work on branches without breaking main

### Reviewing AI's Work

Essential commands:
```
git status          # What files were changed?
git diff            # What exactly changed?
git diff --stat     # Summary: files and lines changed
git log --oneline   # What has AI committed so far?
```

**This is your most important job as the human in the loop.**

### Git as Your Safety Net

1. Commit your current working state (checkpoint)
2. Let AI attempt something risky or complex
3. Review the result with `git diff`
4. If it works -> `git commit`
5. If it breaks -> `git checkout -- .` (revert to checkpoint)

**Rule of thumb:** Commit before every major AI task -- treat commits as save points.

---

## Part 5: Iterative Refinement

### Gap Analysis

```
Review this PRD: [paste]
What's missing?
What questions would a developer have that aren't answered here?
What assumptions need to be stated explicitly?
```

### Clarity Check

```
Read this spec as if you're a developer who needs to implement it.
What's unclear? What could be interpreted multiple ways?
Rewrite any ambiguous sections to be crystal clear.
```

### Scope Creep Detection

```
Compare this MVP definition to the original problem statement.
Are we solving the original problem, or have we drifted?
What features don't directly serve the core problem?
```

### Stakeholder Perspectives

```
Review this PRD from these perspectives:
1. As the CEO: Is the business case strong?
2. As lead developer: Is this buildable?
3. As a user: Would I actually use this?
4. As an investor: Is this worth funding?
What concerns would each raise?
```

### Differentiation Check (from "Click!")

```
Look at our product positioning:
1. Two most important dimensions customers use to evaluate solutions?
2. Plot our product and 3 competitors on a 2x2
3. Are we in a quadrant alone, or clustered?
4. If clustered: differentiation isn't radical enough.
   How could we reframe to stand alone?
```

---

## Key Takeaways

1. **AI excels at ideation** - Generate quantity, filter for quality
2. **Perplexity = research assistant** - Web-connected, with citations
3. **Document pipeline matters** - PRD -> Research -> Plan -> Roadmap
4. **Plans describe WHAT and HOW** - Detailed implementation strategy
5. **Roadmaps are checklists** - Keep AI organized during execution
6. **Be ruthless about MVP scope** - You can always add later
7. **Git is your review tool and safety net** - Use git diff to review AI work, commits as checkpoints

## Before Next Time

- Meet with your team for 1 hour - Use AI to brainstorm ideas, do market research, assess customer fit, and sketch MVPs
- Narrow down to 2-3 top ideas
- Prepare for hands-on setup - Dev Unit 3 will configure tools and repos

## Resources

- Perplexity AI: perplexity.ai
- Business Model Canvas: strategyzer.com
- PRD Best Practices: svpg.com
- Git Documentation: git-scm.com
- Mermaid Diagrams: mermaid.js.org
