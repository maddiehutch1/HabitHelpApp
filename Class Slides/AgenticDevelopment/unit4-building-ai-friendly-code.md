# Unit 4: Building AI-Friendly Code

*Making code work WITH AI through CLI tools, structured logging, testing strategies, and security*

## Learning Objectives

- CLI script creation for autonomous execution
- Structured logging for AI-readable debugging
- TDD with AI collaboration
- The Explore -> Codify pattern for system-level testing
- Secret protection protocols
- The autonomous test-log-fix cycle

---

## Part 1: CLI Tools & Exit Codes

### Core Problem

AI cannot easily interact with visual interfaces or click buttons. Solution: **"If AI can run a command, AI can test your app."**

### Two Testing Modes

**AI-as-Test-Runner:** Executes pre-written test scripts, discovering only anticipated scenarios.

**AI-as-Tester:** Dynamically explores systems via ad-hoc CLI commands, uncovering unanticipated edge cases.

### Scripts Folder Pattern

```
scripts/
├── build.sh    # Compilation/build
├── run.sh      # Application execution
├── test.sh     # Test suite execution
├── lint.sh     # Linting
└── dev.sh      # Dev server startup
```

### Environment Variables: .testEnvVars File

Shell-formatted config for test-specific credentials. Separated from `.env` to distinguish between app and testing environments. Uses `export` statements for AI sourcing.

### CLI Design Principles

- **JSON Output:** Machine-parseable results enabling autonomous validation
- **--help Flag:** Self-documenting commands reducing AI confusion
- **Exit Codes:** Binary success/failure signaling (0 = success, non-zero = failure)
- **stderr vs stdout:** Errors to stderr, data to stdout

### Standard Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General failure |
| 2 | Misuse/invalid arguments |
| 126 | Permission denied |
| 127 | Command not found |
| 130 | User interruption (Ctrl+C) |

---

## Part 2: Structured Logging

> "Structured logging handles 95% of my debugging now."

Traditional debuggers cannot be used by AI; structured logs provide readable context for autonomous diagnosis.

### Unstructured vs. Structured

**Bad for AI:** `"Error occurred in user service"`

**Good for AI:**
```json
{"level":"error","service":"user","action":"create",
 "error":"duplicate_email","email":"test@example.com",
 "timestamp":"2024-01-28T10:30:00Z"}
```

### What to Log

- Function entry with input parameters
- Function exit with result data
- Errors with full context (message, stack, input parameters)

### Log Levels

| Level | Use For |
|-------|---------|
| **ERROR** | Unexpected failures requiring attention |
| **WARN** | Concerning but recoverable situations |
| **INFO** | Normal operational events |
| **DEBUG** | Detailed troubleshooting information |

Configured via environment variable: `LOG_LEVEL=debug`

### Multi-Language Logging Tools

- **Node.js:** Pino (fast, structured JSON)
- **Python:** structlog (structured, composable)
- **Go:** slog (built-in, performant)
- **Java:** Logback with SLF4J
- **Ruby:** Semantic Logger
- **Rust:** tracing (async-aware)

---

## Part 3: Testing Strategies

### Two Testing Levels

**Unit-Level (TDD):** Individual functions and business logic tested before implementation via Red-Green-Refactor.

**System-Level (Explore -> Codify):** API endpoints, integrations, and workflows tested dynamically, then formalized into repeatable integration tests.

### Why TDD Works with AI

- Tests function as executable specifications
- AI excels at comprehensive test coverage generation
- Tests define precise contracts
- AI implements to pass tests; humans review test quality

### Red-Green-Refactor Cycle

1. **RED:** Write failing tests (no implementation)
2. **GREEN:** Write minimal code to pass tests
3. **REFACTOR:** Improve code quality (tests ensure correctness)
4. **REPEAT**

### TDD Workflow with AI (7 Steps)

1. **Define Contract:** Prompt AI to write comprehensive tests
2. **Review Generated Tests:** Ask AI to identify gaps
3. **Add Missing Tests:** Implement discovered gaps
4. **Verify Failure:** Run tests to confirm they fail without implementation
5. **Implement:** Write minimal code to pass tests
6. **Verify Passing:** Run tests again, fixing implementation if needed
7. **Refactor:** Improve code while tests ensure correctness

### Explore -> Codify Pattern

**Phase 1 (Explore):** AI dynamically exercises running system via ad-hoc CLI commands (curl requests, log inspection, edge case testing).

**Phase 2 (Codify):** Discoveries transform into repeatable integration test scripts that run unattended.

### When to Use Which

- **TDD:** Best before implementation starts (unit-level)
- **Explore -> Codify:** Best after initial implementation (system-level)
- **Combined:** TDD ensures component correctness; Explore -> Codify ensures integration correctness

---

## Part 4: Security Considerations

### AI Development Security Risks

- Insecure pattern suggestions from AI
- Secret leakage into prompts/context
- Unaudited dependency recommendations
- Prompt injection vulnerabilities

### Secrets Management

**Never commit:** API keys, database passwords, authentication tokens, private keys, certificates

**Use instead:** `.env` files (in .gitignore), `.testEnvVars` (in .gitignore), environment variables, secret management services

### Prompt Injection Awareness

User input manipulation of AI behavior is a critical vulnerability. Defenses:
- Validate/sanitize input
- Use structured inputs (not freeform prompts)
- Separate user content from instructions
- Never trust user input in AI prompts

### The Confidence Trap (Stanford Study)

> "Developers using AI assistants produce MORE security vulnerabilities -- and express HIGHER confidence that their code is secure."

This reflects bounded rationality: AI optimizes for plausible code, not provably secure code. Confidence outruns reality.

### Three Common Vulnerability Patterns

1. **SQL Injection:** User input directly in SQL queries -> Use parameterized queries
2. **Hardcoded Secrets:** API keys in source code -> Use environment variables
3. **Prompt Injection:** User input as AI instructions -> Sanitize input, separate data from instructions

### Dependency Auditing

AI-suggested packages require verification for:
- Known vulnerabilities
- Maintenance status
- Recent changes
- Typosquatting attacks

Use `npm audit` / `pip audit`. Check: last update date, download count, GitHub issues, security advisories.

### Security Checklist

- [ ] Secrets in `.gitignore` before first commit
- [ ] No hardcoded credentials in code
- [ ] `.testEnvVars` contains only test data
- [ ] Dependencies audited regularly
- [ ] User input sanitized before AI processing
- [ ] API keys rotated regularly
- [ ] Production secrets in secret management system
- [ ] `.env.example` committed (no actual secrets)

---

## Part 5: The Test-Log-Fix Loop

### The Autonomous Cycle

Test results -> log analysis -> issue identification -> code fixes -> re-testing (repeat until all pass)

**Systems Thinking Connection:** Feedback loops from Jason's "Systems Thinking" lecture apply here.

### Autonomous AI Workflow (7 Steps)

1. Implements code changes
2. Runs test scripts
3. Reads log output
4. Analyzes failures
5. Fixes issues
6. Re-tests for verification
7. Repeats until passing

### When AI Gets Stuck

Signs: repeated identical fixes, increasingly complex "solutions," failure to address root causes, circular patterns.

**Root cause:** Bounded rationality -- AI optimizes visible problem aspects within context window, not the whole system.

**Solution:** Step back, review objectives, examine attempted solutions, identify root cause, consider alternative approaches.

### Error Sharing Best Practices

**Bad:** "It doesn't work" / "I got an error"

**Good:** Full error with stack trace, description of intended action, expected vs. actual behavior, relevant code paths, structured log output, previous attempted fixes.

---

## Key Takeaways

1. **CLI-first enables AI testing** - If AI can run it, AI can test it
2. **AI functions as tester and test-runner** - CLI enables system exploration
3. **TDD for units, Explore -> Codify for integration** - Complementary strategies
4. **Structured logging replaces traditional debugging** - AI reads logs
5. **Security requires active vigilance** - Never commit secrets, audit dependencies
6. **Complete the loop** - test -> log -> analyze -> fix -> test

## Homework

1. Create CLI scripts (build.sh, test.sh, run.sh) with proper exit codes and JSON output
2. Implement structured logging (replace console.log with Pino, structlog, etc.)
3. Set up .testEnvVars and add to .gitignore
4. Write/generate tests with TDD: tests first, verify failure, implement to pass
5. Try Explore -> Codify: AI explores running feature, then creates repeatable test-integration.sh
6. Run the loop: Execute tests, review logs, fix issues, repeat until passing

## Resources

- Pino Logger (Node.js): getpino.io
- structlog (Python): structlog.org
- slog (Go): pkg.go.dev/log/slog
- Commander.js (CLI): github.com/tj/commander.js
- 12 Factor App - Logs: 12factor.net/logs
- OWASP Top 10: owasp.org/www-project-top-ten
- Stanford AI Security Study: arxiv.org/abs/2211.03622
