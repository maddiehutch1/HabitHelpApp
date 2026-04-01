# Unit 5: Building Your AI Workflow System

*From ad-hoc AI to systematic workflows*

## What We'll Cover Today

1. Your Instruction Layer - The foundation that shapes every AI interaction
2. Sub-Agents & Verification - Delegating and verifying with confidence
3. Multi-Session Discipline - Preventing the #1 project killer
4. Advanced Patterns - What's possible when you combine it all
5. Your Workflow Cheat Sheet - Takeaway artifact for final projects

## What You Should Be Able to DO After Today

1. Write a CLAUDE.md that improves every AI interaction in your project
2. Codify successful workflows into reusable instruction files and slash commands
3. Deploy sub-agents for verification with risk-appropriate witness counts
4. Budget tokens knowing sub-agents cost 3-5x baseline
5. Use multi-session workflows to prevent context pollution
6. Escalate effectively when AI gets stuck (not just re-prompt)
7. Prevent over-engineering, scope creep, and stuck loops before they happen

> "Today we build a complete workflow system, not just learn individual techniques."

## The Throughline - Building a Stack

The meta-lesson: **Dynamic -> Codified -> Automated**

Each block builds on the previous: Foundation -> Power -> Survival -> Advanced

---

## Block 1: Your Instruction Layer (The Foundation)

### What is an Instruction File?

A markdown file that shapes AI behavior for your project:
- **CLAUDE.md** -- always loaded, shapes every interaction
- **Process docs** -- on-demand workflows in `ai/instructions/`
- **Skills** -- one-command shortcuts in `.claude/skills/`

"Without instructions, AI is a talented chef who doesn't know your kitchen."

### Why Instruction Files Beat Ad-Hoc Prompting

| Aspect | Ad-Hoc | Instructions |
|--------|--------|--------------|
| Results | Inconsistent | Repeatable outcomes |
| Memory | Hard to remember details | Written down once |
| Evolution | No version history | Refinable over time |
| Sharing | Solo knowledge | Shareable with team |
| Efficiency | Reinvent each time | Build on what works |

"Instruction files are the highest-leverage thing you can create."

### Anatomy of a Good CLAUDE.md

```markdown
# Project Context
[What this project is, who it's for]

## Critical Files to Review
- context.md -- project knowledge base
- PRD -- requirements source of truth
- Architecture -- system design decisions

## Behavioral Guidelines
- Keep solutions simple and focused on requirements
- Ask for expert opinion before making changes
- Don't add features not in the PRD
- Change code as if it was always this way (no compatibility layers)

## Code Style
[Patterns, naming conventions, testing expectations]
```

### The Behavioral Guidelines Section

```markdown
## Behavioral Guidelines
- Keep solutions simple and focused on requirements
- Don't add features not in the PRD
- Ask for expert opinion before making changes
- Change code as if it was always this way (no compatibility layers)
- Don't over-engineer -- we can add complexity later
- This is MVP only. Additional features go in future roadmaps.
```

"Rule-beating prevention -- changing the rules the AI optimizes against."

### The Progression: Ad-Hoc -> Codify -> Automate

1. **Ad-Hoc** - Dynamic, experimental
2. **Codify** - Document what works
3. **Automate** - Promote to slash commands

"A process document is a founding hypothesis for a workflow. Running it 3+ times is the cheap loop that tests it."

### Anatomy of a Process Document

```markdown
# Instruction: PR Review

## Context
- Read aiDocs/context.md
- Review the PRD for requirements alignment
- Check aiDocs/coding-style.md for conventions

## Workflow
1. Run git diff to see all changes
2. Review each changed file for correctness, style, and security
3. Check for missing tests
4. Check for scope creep beyond the roadmap
5. Report findings with severity (critical / suggestion / nit)

## Success Criteria
- [ ] All changes reviewed
- [ ] No critical issues remaining
- [ ] Tests cover new functionality

## Behavioral Guidelines
- Report findings before making any changes
- Don't fix things without asking first
```

### Skills & Slash Commands

Skills are SKILL.md files in `.claude/skills/` -- NOT in CLAUDE.md.

```
.claude/skills/
  pr-review/SKILL.md          <- defines /pr-review
  create-roadmap/SKILL.md     <- defines /create-roadmap
  frenemy-pragmatic/SKILL.md  <- defines /frenemy-pragmatic
```

Each SKILL.md = YAML frontmatter (name, description) + markdown instructions. Claude auto-discovers them.

| Skill | Purpose |
|-------|---------|
| `/create-roadmap` | Generate plan + roadmap from requirements |
| `/implement` | Execute a roadmap in fresh session |
| `/pr-review` | Review uncommitted code |
| `/verify` | Sub-agent verification of implementation |

**Promotion rule:** Promote after 3+ successful uses. Don't automate what you're still refining.

### Cursor's Approach

- `.cursorrules` -- project-level instructions (like CLAUDE.md)
- Notepad entries -- reusable prompt templates
- @-mentions -- pull specific files/docs into context on demand
- Composer rules -- workflow-specific instructions per session

"The principle is the same across tools: codify your workflows."

### Inside a Real Skill -- The Frenemy

**frenemy/SKILL.md:**
```yaml
---
name: frenemy
description: Respond with direct, critical analysis. No compliments, no softening.
  Challenge assumptions and fact-check claims.
disable-model-invocation: true
argument-hint: [prompt to critically analyze]
---
Regarding the following prompt, respond with direct, critical analysis.
Prioritize clarity over kindness. Do not compliment me or soften the tone
of your answer. Identify my logical blind spots and point out the flaws
in my assumptions. Fact-check my claims. Refute my conclusions where you
can. Assume I'm wrong and make me prove otherwise.

$ARGUMENTS
```

**frenemy-pragmatic/SKILL.md:**
```yaml
---
name: frenemy-pragmatic
description: Critical frenemy analysis via sub-agent, followed by pragmatic
  recommendations on how to proceed.
argument-hint: [optional topic to analyze]
---
First, determine the analysis topic...
Then, deploy a sub-agent with the "/frenemy" skill to critically analyze
that topic...
Finally, as the pragmatic expert, synthesize the frenemy's critique with
your own assessment and recommend how we should proceed.

$ARGUMENTS
```

### How the Frenemy Works

`disable-model-invocation` = the skill IS the prompt. Frenemy-pragmatic deploys frenemy as a sub-agent, then synthesizes. This is the **supervisor-worker pattern**, implemented as composable skills.

"The frenemy is falsifiability automated -- 'What would need to be true for this to be false?' turned into an adversarial reviewer."

### Token Budget Note

- Instruction files are essentially free -- loaded as context, negligible cost
- Sub-agents are expensive -- 3-5x token multiplier
- **Optimize the cheap layer first.** Get your CLAUDE.md right before spending tokens on multi-agent workflows

---

## Block 2: Sub-Agents & Verification (The Power Layer)

### The Supervisor-Worker Pattern

In Units 7-8, you built agents that use tools to accomplish goals. Now flip the perspective: **YOU are the supervisor agent.** AI sessions are your workers.

### The Verification Cycle

```
"Deploy a sub-agent to implement what we just discussed."
    -> [Sub-agent implements]
"Now deploy another sub-agent to verify we got it right."
    -> Almost always finds at least one issue
"Deploy another sub-agent to verify from a different angle."
    -> Often still finds something the first missed
```

"Each verifier has independent context. They can't confirm each other's blind spots."

### The Law of Witnesses

> "In the mouth of two or three witnesses shall every word be established"

Applied to AI verification:
- Different AI sessions hallucinate independently
- Agreement across independent sessions = high confidence
- Disagreement = investigate

| Risk Level | Witnesses | Method |
|------------|-----------|--------|
| **Low** (routine code) | 1 | Single AI session |
| **Medium** (important feature) | 2 | 2 sessions or 2 models |
| **High** (security-critical) | 3+ | Multiple sessions + tests + human review |

### The Token Tax -- Real Numbers

Why it costs more:
1. Each sub-agent gets its own system prompt + project context (re-sent every call)
2. "Communication tax" -- agents restate goals and results to each other
3. Context replay -- each tool call replays the entire conversation

### Budget-Conscious Patterns

On Pro plans ($20/month):
- Limited messages per 5-hour window
- Supervisor + 2 sub-agents = 4-8 messages per verification cycle

Strategies:
- **Fewer, specialized agents** > many generic agents (40-60% savings)
- Use sub-agents for **high-stakes verification**, not routine tasks
- Instruction files are **free** -- optimize the cheap layer first
- Start manual, automate only when the pattern is proven

---

## Block 3: Multi-Session Discipline (Survival Skills for Final Projects)

### Context Pollution -- The Silent Killer

**What it is:** Old conversation details confuse current work.

**Signs you're polluted:**
- Conversation has been going 30+ minutes
- AI seems confused about current goals
- You've pivoted direction significantly
- Previous approaches failed multiple times

"Bounded rationality made visible: AI can only reason about what's in its context window. Polluted context = rationality bounded by garbage."

**The golden rule: When in doubt, fresh session.**

### The Three-Session Pattern

Plan -> Build -> Review (each in separate session)

**Planning session:**
```
Review aiDocs/context.md. Here's what we need to build:
[requirements]. Give me your expert opinion first.
Don't make any changes yet.
```

**Implementation session (NEW session):**
```
Review aiDocs/context.md. Then implement the work described in:
- ai/roadmaps/[date]_feature_plan.md
- ai/roadmaps/[date]_feature_roadmap.md
Check tasks off as you complete them. Run tests after each step.
```

**Review session:**
```
We just completed implementation. Please do a PR review of all
uncommitted changes. Report findings before making any changes.
```

"For final projects: Every major feature should follow this pattern."

### The Escalation Ladder

When AI gets stuck -- use in order:

| Level | Action | When to Escalate |
|-------|--------|-----------------|
| **1** | Re-prompt with more context | After 2 failed re-prompts |
| **2** | Fresh session with context.md | If fresh session also gets stuck |
| **3** | Sub-agent review to diagnose | If sub-agent doesn't find clear fix |
| **4** | Manual intervention -- you fix it | Last resort |

"Most developers never get past Level 1. They keep rephrasing in a polluted session."

### Pitfall Prevention

| Pitfall | Why | Fix |
|---------|-----|-----|
| **Over-engineering** | AI adds unrequested features | Behavioral guidelines in CLAUDE.md |
| **Scope creep** | "While we're at it" grows beyond MVP | "This is MVP only" in every prompt |

### When to Put the AI Down

1. **Deep learning needed** -- skill erosion is real
2. **Genuinely novel problem** -- AI gives confident wrong answers
3. **Security-critical code** -- the Confidence Trap (Unit 4)
4. **Stuck 20+ min** -- step away, think manually
5. **Team alignment matters** -- shared struggle builds shared knowledge

"These are all wicked-domain signals. AI dominates kind domains. You own the wicked ones."

---

## Block 4: Advanced Patterns (What's Possible)

### The Universal Agent Loop

Every major AI coding tool converges on the same pattern:

**Normalize -> Plan -> Execute -> Verify -> Repeat**

"You are the outer loop. AI is the inner loop. Instruction files (Block 1) are how you program the outer loop."

### Inside Real Commands -- /roadmap

```yaml
---
description: Create a plan doc and roadmap doc for implementing updates
---
Phase 1: Planning
  - Understand request, research codebase, create plan doc, create roadmap doc
Phase 2: Expert Review
  - Launch review sub-agent to validate before implementation
```

### Inside Real Commands -- /implement-roadmap

```yaml
---
description: Implement a roadmap using sub-agents with progress tracking
---
Phase 1: Preparation - Read roadmap, plan, and CLAUDE.md
Phase 2: Implementation - Delegate to sub-agents in parallel
Phase 2.5: Verification - Launch verification sub-agents for high-risk work
Phase 3: Build & Test - npm run build, npm test, fix failures
Phase 4: PR Review - Review everything, fix minor issues, escalate drift
Phase 5: Archive - Move to complete/, update changelog, commit
```

Key principle: **You orchestrate, sub-agents implement. Never skip Phase 5.**

### Playwright + Persona UX Review

Personas:

| Persona | Role | Focus |
|---------|------|-------|
| Sarah | VP of Engineering | Time-to-value, adoption |
| Jake | Junior Developer | Onboarding, confusion |
| Marcus | QA Manager | Evidence quality, data trust |
| Mei | UX Designer | Visual hierarchy, consistency |

Workflow: Launch personas in parallel -> each navigates live UI -> structured reviews -> consensus matrix (3/5 agree = real) -> frenemy reviews feasibility

### Git Worktrees

A second working directory tied to the same repo, on a different branch. No switching. No stashing.

```bash
git worktree add ../project-feature-B feature-B
# Now: project/ (feature-A) + project-feature-B/ (feature-B)
```

Each directory is a full checkout -- separate terminals, separate AI sessions. Claude Code supports this natively with `--worktree` flag.

**Use when:** Tasks are independent, you're blocked waiting, need clean directory for verification, have token budget.

**Skip when:** Tasks overlap same files heavily, limited messages remaining, feature is small enough for one session.

---

## Your Workflow Cheat Sheet

```
INSTRUCTION FILES               SUB-AGENTS & VERIFICATION
=================               ==========================
CLAUDE.md    -> Always loaded    Pattern  -> You supervise, agents execute
ai/instruc./ -> On demand        Witness  -> Match count to risk (1/2/3+)
Slash cmds   -> After 3+ uses    Cost     -> 3-5x normal (controlled)
Progression  -> Ad-hoc ->        Budget   -> Specialized > generic
               Codify ->                    (40-60% savings)
               Automate

MULTI-SESSION                   ESCALATION LADDER
=============                   =================
Session 1: Plan -> plan.md       1. Re-prompt with context
Session 2: Build -> code         2. Fresh session + context.md
  (FRESH context!)               3. Sub-agent review
Session 3: Review -> refined     4. Manual intervention

Golden rule: when in doubt,     WHEN TO STOP USING AI
  fresh session                 =====================
                                1. Deep learning needed
PITFALL PREVENTION              2. Genuinely novel problem
==================              3. Security-critical code
Over-engineering -> CLAUDE.md   4. Stuck in a loop (20+ min)
Scope creep -> PRD reality check 5. Team understanding matters
Context pollution -> fresh
```

---

## The Meta-Lesson

**Dynamic -> Codified -> Automated**

1. **Experiment** with AI dynamically
2. **Codify** what works into a process document
3. **Automate** into a slash command after repeated success
4. **Build** on that automation to create more complex workflows

"The best forklift drivers don't just drive -- they design the warehouse."

## What You Should Do This Week

1. **Create a CLAUDE.md** for your team project (use the template)
2. **Try the three-session pattern** on your next feature
3. **Write one instruction file** for a workflow you'll repeat
4. **Bookmark the cheat sheet** -- use the escalation ladder when stuck

"These aren't suggestions. They're how you demonstrate AI development process in your final presentation."

## Resources

- AgentTaxo (ICML 2025): arxiv.org/html/2510.26585v1
- Anthropic Agent SDK: anthropic.com/engineering/building-agents-with-the-claude-agent-sdk
- Claude Code Analysis: youtube.com/watch?v=RFKCzGlAU6Q
- Claude Code Docs: docs.anthropic.com/en/docs/claude-code
- Playwright: playwright.dev
- Course connections: Units 1 (ReAct), 2 (PRD/docs), 3 (Frenemy/context.md), 4 (Security/Confidence Trap), 7-8 (Agent architecture)
