# Unit 3: Development Setup & Tools

*Setting up your AI-assisted development environment*

> "Everyone's going to become a forklift driver. No one's going to be carrying boxes anymore."

## Topics Covered

1. Claude Code vs Cursor
2. GitHub Setup
3. Two-Folder Pattern (aiDocs/ tracked vs ai/ gitignored)
4. MCP Overview
5. Cross-Platform & Retrofitting
6. Collaborative Prompting, Bias Toward Truth & The Frenemy
7. Setup Verification

---

## Part 1: Claude Code vs Cursor

### Two Paths to AI Development

Tools: Cursor, Claude Code, GitHub Copilot, Codex, Augment, Cody, Windsurf

**Why focus on Cursor & Claude Code:**
- State-of-the-art for agentic development
- Support taught workflows (instruction files, sub-agents, MCP)
- Concepts transfer to other tools

### Feature Comparison

| Feature | Claude Code | Cursor |
|---------|------------|--------|
| Auto-read file | `claude.md` | `.cursorrules` |
| MCP support | Native, extensive | Limited/developing |
| Environment | Terminal-based | IDE (VS Code fork) |
| Multi-model | Claude only | Claude, GPT, others |
| Code context | Manual file reading | Automatic file awareness |
| CLI scripts | Excellent | Good |

Both can reach the same capability level.

### Reaching Equivalent Setup

**Claude Code (claude.md) / Cursor (.cursorrules):**
```
Read aiDocs/context.md for project context.
Follow coding style in aiDocs/coding-style.md
Ask for opinion before complex work.
```

Same core instructions -- MCP tools are configured separately.

---

## Part 2: GitHub Setup

### Creating a Repository

```bash
# Create new repo on GitHub
gh repo create meme-generator --public

# Or initialize locally
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/you/repo
git push -u origin main
```

### Essential .gitignore

```
# AI working space (local process artifacts)
ai/

# Tool-specific config (personal workflow)
claude.md
.cursorrules

# Test environment (may contain secrets)
.testEnvVars

# Dependencies
node_modules/
venv/
__pycache__/

# Environment
.env
.env.local
```

### What IS and ISN'T Tracked

| | Tracked (committed) | Gitignored (local only) |
|---|---|---|
| | `aiDocs/` - permanent project knowledge | `ai/` - temporary working space |
| | Source code | `claude.md` / `.cursorrules` - personal config |
| | `.gitignore` | `.testEnvVars` - secrets |

**Core principle:** "aiDocs/ is shared. ai/ is personal."

### When to Commit

Good commit triggers:
- Feature complete and tested
- Before trying something risky ("checkpoint")
- Before switching contexts
- End of work session

---

## Part 3: The Two-Folder Pattern

| Folder | Tracked? | Purpose | Contents |
|--------|----------|---------|----------|
| `aiDocs/` | **Yes** | Permanent project knowledge | context.md, PRD, MVP, architecture, coding style, changelog |
| `ai/` | **No** | Temporary working space | Roadmaps, plans, research, brainstorming |

**Rule of thumb:** "Would a new engineer need this to understand the project? -> `aiDocs/`. Is it a process artifact? -> `ai/`."

### Project Structure

```
project-root/
├── aiDocs/                # <- TRACKED in git
│   ├── context.md         # THE most important file
│   ├── prd.md             # Product requirements (immutable)
│   ├── mvp.md             # MVP definition
│   ├── architecture.md    # System architecture
│   ├── coding-style.md    # Code style guide
│   └── changelog.md       # Concise change history
├── ai/                    # <- GITIGNORED
│   ├── guides/            # Library docs, research output
│   ├── roadmaps/          # Task checklists, plans
│   └── notes/             # Brainstorming
├── claude.md              # <- GITIGNORED (personal config)
├── .cursorrules           # <- GITIGNORED (personal config)
└── scripts/               # CLI scripts
```

### Why claude.md is Gitignored

- Personal tool config, not project knowledge
- Different team members may use different tools
- Different MCP setups per person
- Just a local pointer: "read `aiDocs/context.md`"
- Exception: If entire team uses same tool, you could track it

### context.md - The Most Important File

```markdown
# Project Context

## Critical Files to Review
- PRD: aiDocs/prd.md
- Architecture: aiDocs/architecture.md
- Style Guide: aiDocs/coding-style.md

## Tech Stack
- Frontend: React, TypeScript
- Backend: Node.js, Express

## Important Notes
- All scripts return JSON to stdout
- Use structured logging to files
- Never commit .testEnvVars

## Current Focus
Building caption generation CLI script
```

### Key Principles for context.md

- **Keep it concise** - bullet points, not essays
- **List references with descriptions** - like a bookshelf with labeled spines
- **Update regularly** - especially "Current Focus"
- AI reads files on demand - picks only what's relevant

**The Bookshelf Analogy:** You don't read every book on a shelf -- you scan titles and pick the relevant ones. AI does the same with context.md.

### The Concise Changelog

```markdown
# Changelog

## 2026-02-01
- Added caption generation CLI (JPG/PNG input, JSON output)
- Switched from OpenAI to Anthropic Vision API for cost

## 2026-01-28
- Initial project setup: React frontend, Express backend
- Created PRD and MVP definition
```

Rules: What changed and why (not how). 1-2 lines each. AI tends verbose -- trim it.

### Plans vs Roadmaps

| Plan | Roadmap |
|------|---------|
| The WHAT and HOW | The checklist |
| Detailed approach | Task list by phases |
| Technical decisions | Progress tracking |

Both go in `ai/roadmaps/` (gitignored) -- process artifacts, not permanent docs.

---

## Part 4: MCP Overview

### What is MCP?

**Model Context Protocol** - Extends AI capabilities beyond text

- Standard for extending AI capabilities
- Gives AI access to tools (like browser extensions for AI)
- Tools run locally, results fed back to AI
- Developed by Anthropic, open standard

Mental model: "AI can REQUEST actions -> Tools EXECUTE -> AI sees results"

### MCP Tool Comparison

| Tool | Type | Best For | Cost |
|------|------|----------|------|
| **Context7** | Library docs | Specific package API docs | Free |
| **Firecrawl** | Web research | Search + scrape, Claude synthesizes | Free tier |
| **Bright Data** | Web research | Similar to Firecrawl | Free tier |
| **Perplexity** | Deep research | Pre-synthesized answers (optional) | Paid |

All store results in `ai/guides/` (gitignored working reference).

### How to Add an MCP Server

Config location: `~/.config/claude/mcp.json` (Claude Code)

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp"]
    },
    "perplexity": {
      "command": "npx",
      "args": ["-y", "@perplexity/mcp"],
      "env": {
        "PERPLEXITY_API_KEY": "your-key-here"
      }
    }
  }
}
```

---

## Part 5: Cross-Platform & Retrofitting

### Windows vs Mac/Linux Gotchas

| Issue | Mac/Linux | Windows |
|-------|-----------|---------|
| Shell scripts | `./script.sh` works | May need WSL or Git Bash |
| Path separators | `/` | `\` (but `/` often works) |
| Line endings | LF | CRLF (configure git) |
| Environment vars | `export VAR=value` | `set VAR=value` |

Best practice: Use Node.js scripts when possible (cross-platform).

### Retrofitting AI into Existing Projects

1. Add `aiDocs/` folder - Start with context.md
2. Add `ai/` folder - Even if empty at first
3. Create context.md - Document what you discover
4. Add `.gitignore` - Protect ai/, claude.md, .cursorrules, .testEnvVars
5. Ask AI to analyze - "Review this codebase and create a context.md"

---

## Part 6: Collaborative Prompting, Bias Toward Truth & The Frenemy

### Collaborative Prompting: Tentative Approach

**Don't:** `"Add JWT authentication to the API"`

**Do:**
```
We need to add authentication.
I'm thinking JWT tokens but I'm not sure
if that's the best approach here.
What do you think?
```

Invites AI to provide expert opinion, identifies better approaches, reduces risk.

### Pattern: Context-First

```
Review the context file.
Then review how [feature] currently works.
Understand it thoroughly.

Now here's what we need to change: [requirements]
What's your opinion on the best approach?
Don't make any code changes yet.
```

### Positivity Matters

- Research shows negativity causes erratic AI behavior
- Positivity produces more neutral, focused results
- Clear and positive = best combination
- "You don't need to flatter AI, just stay positive, unaccusing, and clear (same as with people!)"

### Bias Toward Truth

Why hallucinations happen:
- LLMs predict "likely next tokens" -- plausible does not equal true
- Gaps in training data filled with confident guesses
- No built-in fact-checking mechanism

### 5 Strategies You Can Use Today

| Strategy | How |
|----------|-----|
| **Chain-of-Thought** | "Show your reasoning step by step" |
| **Structured Output** | Request JSON -- reduces creative drift |
| **Explicit Uncertainty** | "Say 'I don't know' rather than guessing" |
| **Context Clarification** | Give AI the files and facts it needs |
| **Multi-Step Verification** | Generate -> Verify -> Refine -> Present |

### The Frenemy Prompt - Adversarial Review

```
Regarding the following prompt, respond with direct,
critical analysis. Prioritize clarity over kindness.
Do not compliment me or soften the tone of your answer.
Identify my logical blind spots and point out the flaws
in my assumptions. Fact-check my claims. Refute my
conclusions where you can. Assume I'm wrong and make
me prove otherwise.
```

### The Two-Step Frenemy Workflow

**Step 1 - Frenemy Session (adversarial):** Run the frenemy prompt on your PRD/plan. AI will ruthlessly identify cracks, contradictions, missing pieces, and weak assumptions.

**Step 2 - Fresh Collaborative Session (synthesis):** Take the criticism to a new session and ask which are truly valid and actionable, which are noise, and what should change.

"Frenemy finds the cracks. Collaboration decides which ones matter."

### When to Use the Frenemy

| Use Case | What You're Stress-Testing |
|----------|---------------------------|
| PRDs & Plans | Missing requirements, scope gaps, contradictions |
| Architecture | Scalability issues, wrong tool choices, over-engineering |
| Code Reviews | Edge cases, security holes, maintainability |
| Assumptions | "Is this actually true, or do I just believe it?" |

**When NOT to use:** During initial brainstorming, when you need encouragement, on trivial decisions.

**Rule of thumb:** "Build collaboratively first. Frenemy it before you commit."

---

## Setup Verification (Hands-On Activity)

1. Create a GitHub repository for your project
2. Add .gitignore with ai/, claude.md, .cursorrules, .testEnvVars
3. Create aiDocs/ with context.md (reference PRD, list tech stack)
4. Create ai/ folder structure (guides/, roadmaps/, notes/)
5. Create claude.md or .cursorrules pointing to aiDocs/context.md
6. Ask AI to read context.md and summarize your project
7. Verify AI can see your project context

**Success criteria:** AI can describe your project from aiDocs/context.md

---

## Key Takeaways

1. **Claude Code vs Cursor** - Both excellent; choose based on workflow preference
2. **Two-folder pattern** - aiDocs/ (tracked) vs ai/ (gitignored)
3. **context.md is your AI brain** - Lives in aiDocs/, shared with team
4. **claude.md is personal config** - Gitignored, points to aiDocs/context.md
5. **MCP extends AI** - Context7 for docs, Firecrawl for web research
6. **Bias toward truth** - Prompt habits reducing hallucinations
7. **Collaborate, don't command** - "What do you think?" gets better results
8. **Frenemy for stress-testing** - Adversarial review before committing to plans

## Before Next Time

1. Complete workspace setup (repo, aiDocs/, ai/, .gitignore, claude.md)
2. Have AI generate planning docs (then review & refine): prd.md, mvp.md, architecture.md, coding-style.md
3. Create context.md referencing all docs with descriptions
4. Plan implementation phases with AI

## Resources

- Claude Code: docs.anthropic.com/claude-code
- Cursor: cursor.sh
- MCP Protocol: modelcontextprotocol.io
- Context7: context7.io
- GitHub CLI: cli.github.com
- Mermaid Diagrams: mermaid.js.org
