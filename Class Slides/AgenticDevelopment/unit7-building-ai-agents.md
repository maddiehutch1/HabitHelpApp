# Unit 7: Building AI Agents

*From driving a forklift to building forklifts*

## Overview

Transitions developers from using pre-built AI agents to building them from scratch. Covers the ReAct pattern (Think -> Act -> Observe), LangChain fundamentals, and practical tool creation.

---

## Part 1: Why Build Agents?

### Core Concept Shift

From operating AI tools to creating them.

### Single-Shot vs. Agent-Powered

- **Single-shot:** One prompt generates structured output (user does thinking)
- **Agent-powered:** AI decides which tool to use, observes results, determines next steps

**Key Design Principle:** "Not every feature needs an agent. Ask: 'What task will this handle better than a single prompt?'"

---

## Part 2: The ReAct Pattern in Code

### ReAct Loop Components

1. **Think** - model analyzes problem and available tools
2. **Act** - model selects and calls appropriate tool
3. **Observe** - model receives tool result
4. **Repeat** - loop continues until answer found

### Tool Calling Workflow

1. Send message + tool definitions to LLM
2. Model returns structured tool call (not plain text)
3. Code executes tool and returns result
4. Model reasons about result and decides next action

### Agent Loop Pseudocode

```
while true:
  - Call LLM with messages and tools
  - If tool calls exist: execute and append results
  - Else: return final answer
```

---

## Part 3: LangChain Fundamentals

### What is LangChain

- Dominant agent framework (90M+ monthly downloads)
- Available in Python and JavaScript/TypeScript
- Provides abstractions for models, tools, agents, memory

### Key Packages

- `langchain` - main package
- `@langchain/anthropic` - Claude integration
- `@langchain/langgraph` - execution engine
- `@langchain/core` - tool definitions
- `zod` - schema validation

### Tool Anatomy (3 Essential Parts)

1. **Function** - implements the tool logic
2. **Name + Description** - identifies and explains purpose
3. **Schema (Zod)** - defines expected input parameters

Good tool description example: "Search the web for current information not in training data: recent events, current prices, real-time data"

### Agent Creation Pattern

1. Choose model (Claude or OpenAI)
2. Define tools array
3. Call `createAgent()` with model and tools
4. Invoke with user messages

### Execution Models

- `.invoke()` - wait for complete response
- `.stream()` - real-time updates for UI (recommended)

---

## Part 4: Building First Tools

### Calculator Tool

- Evaluates mathematical expressions safely
- Uses `Function()` in strict mode (not eval)
- Returns error messages, never throws
- Handles infinity/NaN cases

### Web Search Tool (Tavily)

- Purpose-built for LLM agents (vs. generic search APIs)
- Returns structured content with metadata
- Free tier: 1,000 searches/month
- Superior to raw Google API for agent consumption

---

## Part 5: Important Concepts & Gotchas

### Error Handling Rules

- Always catch errors in tools
- Return error messages (not exceptions)
- Allows LLM to adapt and retry with different approach

### Common Pitfalls

| Problem | Symptom | Solution |
|---------|---------|----------|
| Vague descriptions | Wrong tool selection | Be specific about tool use cases |
| Missing error handling | Agent crashes | Implement try/catch blocks |
| Too many tools | Confusion and slowness | Start with 3-5 tools maximum |
| No iteration limits | Infinite loops | Set recursion limits |
| Forgetting async keyword | Tool hangs | Make web/RAG tools async |

---

## Part 6: Individual Agent Project (Homework)

### Two-Part Assignment (Units 7-8)

1. Calculator tool
2. Web search tool (Tavily)
3. RAG tool (vector search)
4. Web UI chat interface
5. Multi-turn conversation memory
6. Streaming responses

### Infrastructure Requirements

- Project repository with proper structure
- `aiDocs/` folder with context.md
- PRD documenting tools and purpose
- `.gitignore` configured (no secrets)
- `scripts/` folder with test scripts
- Meaningful, incremental git commits

### API Keys Needed

- Anthropic ($5 new account credit)
- Tavily (1,000 searches/month free)
- Estimated total cost: $2-5

### Phase 1 Deliverables

- Project infrastructure setup
- Two working tools (calculator + web search)
- Agent routing between tools verified
- Web UI begun
- Incremental commits pushed

---

## Key Takeaways

1. **Agents = LLM + tools + loop** -- developers can now build the loop
2. **Tools are functions with metadata** (name, description, schema)
3. **Tool descriptions guide LLM decision-making** about when to invoke them
4. **LangChain's createAgent** handles the ReAct loop automatically
5. **Tools must handle errors gracefully** -- return messages instead of exceptions
6. **Projects should follow professional development practices**

## Resources

- Anthropic Docs: docs.anthropic.com
- LangChain + Anthropic: docs.langchain.com/oss/javascript/integrations/chat/anthropic
- LangChain.js: js.langchain.com
- LangChain Agents: docs.langchain.com/oss/javascript/langchain/agents
- LangGraph (ReAct): langchain-ai.github.io/langgraphjs
- Tavily (Web Search): tavily.com
- Zod: zod.dev
- ReAct Paper: arxiv.org/abs/2210.03629
