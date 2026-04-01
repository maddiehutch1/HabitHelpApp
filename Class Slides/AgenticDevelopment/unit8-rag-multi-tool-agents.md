# Unit 8: RAG, Multi-Tool Agents & Your Assignment

*Adding knowledge and chaining tools*

## What We'll Cover

1. Quick Recap - What we built last time
2. RAG & Embeddings - Give your agent a knowledge base
3. Multi-Tool Agents - Chaining tools together
4. Conversation Memory - Multi-turn context
5. Beyond LangChain - Other frameworks
6. Production Considerations - Costs, debugging, security
7. Your Agent Project - Adding RAG and finishing up

## Learning Outcomes

1. Implement RAG -- embed documents, vector search, semantic retrieval
2. Build multi-tool chatbots that select appropriate tools per question
3. Add conversation memory for multi-turn context maintenance
4. Evaluate when agents outperform single LLM calls

---

## Unit 7 Recap

Previous capabilities:
- Defining tools with `tool()` function (name, description, Zod schema)
- Creating ReAct agents via `createReactAgent`
- Building calculator and web search tools
- Error handling in tools

---

## Part 1: RAG & Embeddings

### RAG = Retrieval-Augmented Generation

Purpose: Provide agents access to proprietary documents (company docs, course notes, API references).

Process: **Embed -> Vector Search -> LLM + Context**

### What Are Embeddings?

Convert text into numerical vectors capturing semantic meaning. Similar text clusters together in vector space.

Example vectors:
- "king" -> [0.21, -0.45, 0.89, 0.12, ...]
- "queen" -> [0.19, -0.42, 0.91, 0.15, ...] (similar)
- "banana" -> [0.82, 0.33, -0.11, 0.67, ...] (different)

"Similar meanings -> similar vectors -> we can search by meaning, not just keywords."

### Embeddings in Code

```javascript
import { OpenAIEmbeddings } from "@langchain/openai";
const embeddings = new OpenAIEmbeddings({
  model: "text-embedding-3-small",
});
const vector = await embeddings.embedQuery("What is photosynthesis?");
// Returns 1536-dimensional vector
```

Note: Anthropic lacks embeddings models; requires OpenAI API key. Alternatives: Voyage AI or local options.

### Building the Vector Store

```javascript
import { MemoryVectorStore } from "@langchain/classic/vectorstores/memory";
import { OpenAIEmbeddings } from "@langchain/openai";

const embeddings = new OpenAIEmbeddings({ model: "text-embedding-3-small" });
const vectorStore = new MemoryVectorStore(embeddings);

await vectorStore.addDocuments([
  {
    pageContent: "API rate limit details...",
    metadata: { source: "api-docs.md", topic: "rate-limits" },
  },
]);
```

### Loading Documents

**Option 1:** Create `documents.ts` file with content array.

**Option 2:** Use DirectoryLoader for file-based loading:
```javascript
import { DirectoryLoader } from "langchain/document_loaders/fs/directory";
import { TextLoader } from "langchain/document_loaders/fs/text";

const loader = new DirectoryLoader("./docs", {
  ".txt": (path) => new TextLoader(path),
});
const docs = await loader.load();
await vectorStore.addDocuments(docs);
```

### The RAG Tool

```javascript
const knowledgeBase = tool(
  async ({ query }) => {
    const results = await vectorStore.similaritySearch(query, 3);
    if (results.length === 0) {
      return "No relevant documents found.";
    }
    return results
      .map((doc, i) =>
        `[${i + 1}] (Source: ${doc.metadata.source})\n${doc.pageContent}`
      )
      .join("\n\n");
  },
  {
    name: "knowledge_base",
    description: "Search documentation using semantic search.",
    schema: z.object({
      query: z.string().describe("Natural language query about documentation"),
    }),
  }
);
```

### Vector Store Options

| Approach | Best For | Trade-offs |
|----------|----------|-----------|
| In-memory | Prototypes, <10K docs | Fast, no setup; lost on restart |
| Pinecone/Weaviate | Production, large datasets | Persistent, scalable; costs money |
| ChromaDB | Local development | Persistent, free; single machine |
| PostgreSQL + pgvector | Existing Postgres users | Integrated; requires Postgres |

---

## Part 2: Multi-Tool Agents

### Multi-Tool Agent Architecture

"The LLM reads tool descriptions and decides which tool(s) to call for each question." LLM routes to Calculator, Web Search, or Knowledge Base.

### Multi-Tool Reasoning in Action

**Example 1:** "How much does the starter plan cost per year?"
- RAG retrieves pricing -> Calculator performs annual math -> Returns comprehensive answer
- Agent automatically chains tools without explicit direction

**Example 2:** "How much would it cost to cater 3 club events?"
- Step 1: `knowledge_base("catering pricing")` -> "Pizza: $85/event. Sandwich: $120/event."
- Step 2: `calculator("85 * 3")` -> "255"
- Final answer includes both pricing options with totals

---

## Part 3: Conversation Memory

### Adding Conversation Memory

```javascript
let messageHistory = [];

async function chat(userMessage) {
  messageHistory.push({ role: "user", content: userMessage });
  const result = await agent.invoke({ messages: messageHistory });
  const assistantMessage = result.messages[result.messages.length - 1];
  messageHistory.push({ role: "assistant", content: assistantMessage.content });
  return assistantMessage.content;
}

// Multi-turn conversation
await chat("What does the starter plan cost?");
await chat("And what's that per year?");  // Understands context from previous turn
```

### Conversation Memory Caveats

- **Warning 1:** Naive implementation -- message array grows infinitely. Production requires truncation or summarization.
- **Warning 2:** Simplified version stores only final response. Tool-using agents should preserve full history including tool calls.

---

## Part 4: Beyond LangChain

### Framework Comparison

| Framework | Language | Best For |
|-----------|----------|----------|
| LangChain | Python + JS/TS | Broadest ecosystem, most tutorials |
| Mastra | TypeScript only | TS-native DX, built-in production features |
| CrewAI | Python | Multi-agent teams with defined roles |
| OpenAI Agents SDK | Python | Simple agents, OpenAI-only (vendor locked) |

"They all implement the same ReAct loop under the hood."

---

## Part 5: Production Considerations

### Token Costs and Iteration Limits

| Scenario | Typical Iterations | Cost Impact |
|----------|-------------------|-------------|
| Simple calculation | 1-2 | Low |
| Web search + answer | 2-3 | Medium |
| Multi-tool chain | 3-5 | Higher |
| Agent stuck in loop | 10+ | Expensive! |

Control strategy:
```javascript
const agent = createReactAgent({
  model: new ChatAnthropic({ model: "claude-haiku-3-5" }),
  tools: tools,
});
const result = await agent.invoke({ messages }, { recursionLimit: 10 });
```

### Security Considerations

- Never hardcode API keys (use environment variables)
- Validate tool inputs (especially calculator)
- Sanitize user input (prevent prompt injection)
- Audit tool outputs (don't trust web search blindly)

Safe math evaluation:
```javascript
// Bad: eval(userExpression)
// Bad: Function() also unsafe for untrusted input
// Good:
import { evaluate } from "mathjs";
const result = evaluate(expression);
```

### Troubleshooting Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| API_KEY not set | Missing env variable | Export key |
| Tool not found | Typo in tool name | Check name matches exactly |
| Agent returns text instead of calling tool | Bad tool description | Make description more specific |
| RateLimitError | Too many API calls | Add delays, use haiku model |
| RAG returns no results | Documents not loaded | Verify addDocuments() was awaited |
| TypeError: Cannot read properties | Forgot async/await | Web and RAG tools MUST be async |

---

## Part 6: Your Agent Project

### Target by Deadline

- Working agent with calculator and web search
- Repo with context.md, PRD, roadmap
- Web UI in progress (minimum: terminal interface)
- Incremental git history showing development
- Logging showing tool calls, arguments, results

### What to Add Now

**RAG implementation:**
- Choose document set (5+ documents)
- Use OpenAI embeddings + in-memory vector store
- Build knowledge_base tool with source attribution

**Conversation memory:**
- Maintain message history array
- Pass full history on each invocation
- Verify multi-turn conversations work

**Web UI:**
- Agent accessible through chat web page (not just terminal)

### Deliverables

1. **Repository:** context.md, .gitignore, PRD, roadmap with checkmarks, logging output, incremental git history
2. **Working agent:** Three tools (calculator, web search, RAG with 5+ real docs), conversation memory, web UI
3. **README.md:** Explaining agent, available tools, run instructions
4. **Demo:** 2-minute screen capture showing web UI with 2-3 tool features

### Stretch Goals

1. Add streaming -- real-time response display in web UI
2. Add 4th tool -- file reader, database query, or API integration
3. Persistent vector store -- ChromaDB or hosted vector DB
4. Connect to project -- ~1 page proposal identifying project feature benefiting from agent pattern

---

## Key Takeaways

1. **RAG gives agents YOUR knowledge** - Embeddings + vector search + documents
2. **Multi-tool chaining is automatic** - Agent reasons about tool selection and sequence
3. **Agent frameworks share patterns** - LangChain, Mastra, CrewAI implement same ReAct loop
4. **Not every feature needs an agent** - Set clear hypothesis before building
5. **The full picture:** Agents = LLM + Tools + Loop + Knowledge

## Resources

- Anthropic Docs: docs.anthropic.com
- LangChain + Anthropic: docs.langchain.com/oss/javascript/integrations/chat/anthropic
- LangChain.js: js.langchain.com
- LangChain Agents: docs.langchain.com/oss/javascript/langchain/agents
- LangGraph (ReAct): langchain-ai.github.io/langgraphjs
- Tavily (Web Search): tavily.com
- OpenAI Embeddings: platform.openai.com/docs/guides/embeddings
- Mastra: mastra.ai/docs
- Zod: zod.dev
- ReAct Paper: arxiv.org/abs/2210.03629
