# Unit 1: Generative AI Fundamentals & How Agents Work

*Understanding the technology before using it*

## What We'll Cover Today

1. What is Generative AI? (GPT, tokens, training)
2. Fun Exercises (Creative generation)
3. From Autocomplete to Agents (ReAct framework)
4. Lab (Hands-on experimentation)

---

## Part 1: What is Generative AI?

### A Brief History of Generative AI

| Year | Milestone |
|------|-----------|
| 1957 | Perceptron - First trainable neural network |
| 1961 | ELIZA - First chatbot (early generative AI) |
| 1979 | Neocognitron - First deep learning neural network |
| 1989 | Backpropagation - Deep learning becomes practical |
| 1997 | LSTM - Long short-term memory for speech recognition |

### The Modern Era

| Year | Breakthrough |
|------|-------------|
| 2014 | GANs - Generate realistic images, video, audio |
| 2017 | Transformers - "Attention Is All You Need" paper |
| 2022 | ChatGPT - LLMs go mainstream |
| 2023+ | Agentic AI - Systems that plan and take actions |

Most contemporary "AI" emerged within the last decade.

### GPT = ?

- **G:** Generative (Creates new content)
- **P:** Pre-trained (Learned from massive data before use)
- **T:** Transformer (Architecture enabling this capability, 2017)

### The Core Insight - "World's Best Autocomplete"

- Fundamentally: predicting subsequent words
- Trained on billions of text examples
- Prediction quality creates appearance of intelligence
- Represents pattern matching at massive scale, not cognition

### How Training Works

1. Feed billions of text examples (Books, websites, code, conversations)
2. Learn to predict next token (Given previous tokens)
3. Scale up (More data + parameters = emergent capabilities)
4. Fine-tune for conversation (RLHF - Reinforcement Learning from Human Feedback)

### Key Concept: Tokens

- **Definition:** Subword pieces (~4 characters average)

| Text | Tokens |
|------|--------|
| "hello" | 1 token |
| "uncomfortable" | ["un", "comfort", "able"] = 3 tokens |

- Code typically requires more tokens per line than English text
- Billing based on token usage; limits expressed in tokens

### Key Concept: Context Window

Model's working memory includes:
- System prompt
- Conversation history
- Current message
- Documents/code

Comparisons:
- Claude: ~200K tokens
- GPT-4: ~128K tokens
- Gemini 1.5: ~1M tokens

### Key Concept: Temperature

Scale from 0 to 1.0:
- **0:** Deterministic
- **0.5:** Balanced
- **1.0:** Creative

Lower for code/facts. Higher for creative writing.

### Key Concept: Hallucinations

**Why AI makes things up:**
- Models generate plausible subsequent tokens
- Plausible ≠ True
- Confident prediction ≠ Factual accuracy
- **Always verify important outputs**

### The Jagged Frontier of AI

- **Superhuman at unexpected tasks:** Medical diagnosis, complex math, sophisticated code
- **Struggles with "simple" tasks:** Visual puzzles, counting, physical reasoning
- **Jaggedness doesn't match intuition:** Passes bar exam, fails at basic visual tasks
- **Creates collaboration opportunities:** Humans fill AI gaps, AI amplifies human strengths

Source: Ethan Mollick, "The Shape of AI"

### The Equation of Agentic Work

Key factors:
1. **Human Baseline Time:** How long would this take YOU?
2. **Probability of Success:** How likely is AI to succeed? (Remember jagged frontier)
3. **AI Process Time:** Agents run in background while you work on other tasks

**Key skill:** Management becomes superpower with AI agents.

Source: Ethan Mollick, "Management as AI Superpower"

---

## Part 2: Fun Generative Exercises

### Exercise: The Dinosaur Rewrite

Take any recent news article and rewrite it so that a dinosaur is somehow centrally involved. Keep the same journalistic tone and structure.

### Exercise: The Tone Dial

Original email: "The project deadline was missed again. This is unacceptable. We need to discuss this."

Rewrite in variations: Furious, Frustrated, Neutral, Understanding, Gracious

### Exercise: Format Juggling

Input: "John Smith is a 34-year-old software engineer from Seattle..."

Output formats: JSON, YAML, Bullet points, SQL INSERT, Haiku, Movie trailer

### Exercise: The Accordion

Starting point: "The server crashed."

- Expand to Incident report (1 paragraph) then Post-mortem (3 paragraphs)
- Compress to Tweet (280 chars) then Single emoji

---

## Part 3: From Autocomplete to Agents

### The Limitation

LLMs can only produce text:
- Can't browse the web
- Can't run code
- Can't read files
- Can't call APIs

"All talk, no action"

### The Solution: Tools

Give LLM ability to request actions:

1. User: "What's the weather in Seattle?"
2. LLM thinks: "I need weather data..."
3. LLM outputs: `{"tool": "get_weather", "location": "Seattle"}`
4. System executes: `{"temp": 52, "condition": "rainy"}`
5. LLM responds: "It's 52F and rainy in Seattle."

### The ReAct Framework

**Reasoning + Acting**

Loop components:
- **THINK:** Reason about task
- **ACT:** Tool call
- **OBSERVE:** See result
- **REPEAT**

### Why ReAct Works

1. **Explicit reasoning:** Prevents rushing to wrong actions
2. **Observation step:** Allows course correction
3. **Loop continues:** Until task complete
4. **More reliable:** Than single-shot generation

### What Makes an "Agent"

- LLM "the brain"
- Tools "the hands"
- Reasoning Loop "the process"
- = Autonomous Agent

### Common Agent Tools

| Tool Type | Examples |
|-----------|----------|
| File system | Read, write, search files |
| Web | Fetch pages, search |
| Code execution | Run scripts, tests |
| APIs | External services |
| Browser | Playwright for web interaction |

### Why Agents Matter for Development

| Before | After |
|--------|-------|
| AI suggests code | AI READS your code |
| You run tests | AI RUNS your tests |
| You research libraries | AI RESEARCHES for you |
| You fix issues | AI FIXES and verifies |

Transforms AI from assistant to autonomous developer.

---

## Part 4: Lab Exercises

1. **Token Exploration** (5 min) - Use OpenAI tokenizer to explore text splitting
2. **Creative Generation** (10 min) - Rewrite project description in 3 styles
3. **Agent Thinking** (5-10 min) - Write out ReAct steps for researching a library

---

## Key Takeaways

1. **LLMs = sophisticated autocomplete** - Predicting tokens, not thinking
2. **Tokens ≠ words** - Understanding tokens helps efficiency
3. **Agents = LLM + tools + loop** - Makes AI useful for development
4. **ReAct pattern** - Think, Act, Observe, Repeat
5. **Always verify** - Hallucinations occur

## Before Next Time

- Read: "Management as AI Superpower" - oneusefulthing.org
- Think: What would you want an AI agent to research for your project?

## Resources

- OpenAI Tokenizer: platform.openai.com/tokenizer
- Claude Documentation: docs.anthropic.com
- ReAct Paper: arxiv.org/abs/2210.03629
- Management as AI Superpower: oneusefulthing.org/p/management-as-ai-superpower
