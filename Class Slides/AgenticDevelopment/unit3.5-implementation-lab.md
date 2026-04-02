# Unit 3.5: Implementation Lab

*Turning plans into code*

## What We'll Cover Today

1. Implementing Roadmaps with AI - "Turning plans into code"
2. Verifying Roadmap Implementation - "Did AI build what we planned?"
3. Creating CLI Testing Scripts - "The full loop"
4. Testing with CLI Tools - "Run and validate"
5. The Fix Loop - "Autonomous bug fixing"

Format: ~15 min instruction + hands-on lab time

## Learning Objectives

By end of today, you should be able to:

1. Have AI implement at least one phase of your project from roadmaps
2. Verify implementation matches roadmap requirements
3. Create CLI scripts enabling AI to test applications
4. Run and test applications using CLI tools
5. Fix bugs found during testing using test-fix loop

> "If you accomplish all five, you're ahead of most professional developers using AI."

---

## Part 1: Where We Are

### The Development Flow

PRD (what) -> Plans (how) -> Roadmaps (checklist) -> **CODE**

"You have the planning docs. Now we turn them into working software."

### The Implementation Prompt Pattern

```
Review @context.md. Implement the roadmap at ai/roadmaps/[your-roadmap].md.
```

**Critical insight:** This only works well if you did the planning homework. Good plans = good implementation. Bad plans = AI guessing.

### What Happens Next

**What AI Does:**
- Reads roadmap and understands scope
- Reads architecture.md for system design
- Reads coding-style.md for conventions
- Implements code
- May ask clarifying questions

**What You Do:**
- Watch implementation unfold
- Answer questions when asked
- Don't micromanage -- let it work

---

## Part 2: Verification

**Verification implements the Law of Witnesses** -- a second perspective to ensure truth and correctness.

### Verification Prompt

```
Review the roadmap at ai/roadmaps/[your-roadmap].md.
Check off what was completed from phase 1.
Flag anything missed or implemented differently than planned.
Don't make any code changes -- just report.
```

### What Verification Looks Like

**What AI Does:**
- Cross-references roadmap tasks against actual code
- Marks completed items
- Flags anything missed or changed
- Notes deviations from plan

**What You Review:**
- Are deviations reasonable?
- Was anything critical missed?
- Does code match expectations?

### Update Your Roadmap

```
Update the roadmap to reflect what was completed.
Add notes on any changes from the original plan.
Mark phase 1 as complete if everything checks out.
```

Keeps your roadmap a living document -- not just a planning artifact.

### The Complete Recipe

**Step 1 - Review Context:**
"Review @context.md and the roadmap at ai/roadmaps/[your-roadmap].md."

**Step 2 - Implement:**
"Implement phase [N] of the roadmap. Follow the architecture in aiDocs/architecture.md and coding style in aiDocs/coding-style.md. Check off tasks in the roadmap as you complete them."

**Step 3 - Verify with Sub-Agent:**
"Deploy a sub-agent to verify all implementation from phase [N]. Compare what was built against the roadmap requirements. Flag anything missed or implemented differently than planned. Don't make code changes -- just report."

**Step 4 - Archive When Complete:**
"Once all phases are done and verified: Move both the plan and roadmap to ai/roadmaps/completed/"

**Summary:** Review, implement, verify, repeat. Archive when done.

---

## Part 3: CLI Testing Scripts

### The Key Insight

> "When AI can test itself, you have the full loop."

AI implements -> AI tests -> AI reads output -> AI fixes -> (repeat)

**Without CLI scripts, YOU are the bottleneck.**

### Creating CLI Scripts

```
Create CLI scripts in scripts/ that exercise the features we just built.
Each script should:
- Accept inputs as command-line arguments
- Run the feature
- Output JSON results to stdout
- Use proper exit codes (0 = success, non-zero = failure)
- Send errors to stderr
```

### The scripts/ Folder Pattern

```
scripts/
├── build.sh      # Compile/build the project
├── test.sh       # Run all tests
├── run.sh        # Run the application
└── dev.sh        # Start dev server (optional)
```

Minimum viable set: build.sh and test.sh

### Example test.sh Script

```bash
#!/bin/bash
echo "Building project..."
./scripts/build.sh || { echo '{"status":"fail","step":"build"}' >&2; exit 1; }
echo "Running tests..."
if npm test 2>&1; then
    echo '{"status": "pass", "message": "All tests passed"}'
    exit 0
else
    echo '{"status": "fail", "message": "Tests failed"}' >&2
    exit 1
fi
```

### Cross-Platform Note

Shell scripts don't work on all machines. Node.js alternative:

```javascript
// scripts/test.js
const { execSync } = require('child_process');
try {
  execSync('npm test', { stdio: 'inherit' });
  console.log(JSON.stringify({ status: 'pass' }));
  process.exit(0);
} catch (err) {
  console.error(JSON.stringify({ status: 'fail', error: err.message }));
  process.exit(1);
}
```

---

## Part 4: Running Scripts

### The Autonomous Loop

1. AI runs: `./scripts/test.sh`
2. AI reads output
3. If exit code 0: Done! Tests pass.
4. If exit code != 0: AI reads error output
5. AI diagnoses issue
6. AI fixes code
7. Return to step 1

**This can run without you touching anything.**

### What Success Looks Like

```
$ ./scripts/test.sh
{"status": "pass", "tests": 12, "failures": 0}
$ echo $?
0
```

Exit code 0 + JSON output = AI knows everything worked.

---

## Part 5: The Fix Loop

### When Tests Fail

```
Run ./scripts/test.sh. If any tests fail, analyze the output,
fix the issues, and run again. Continue until all tests pass.
```

This is the "magic moment" where AI works autonomously on bug fixing.

### When to Intervene

Let AI work autonomously **unless:**
- Same error repeating 3+ times
- AI trying increasingly complex "solutions"
- Fix is making things worse
- AI is clearly confused about root cause

**Intervention prompt:**
```
Stop. Let's step back. What have we tried so far?
What's the actual root cause?
Is there a different approach entirely?
```

### The Full Picture

PLAN (roadmap) -> IMPLEMENT (AI codes) -> TEST (CLI) -> FIX (loop) -> VERIFY (check roadmap)

"You planned well. Now let AI execute."

---

## Key Takeaways

1. **Roadmaps become code** - AI implements what you planned
2. **Verify implementation against roadmap** - Trust but verify
3. **CLI scripts enable self-testing** - The full loop
4. **Test-fix cycle runs autonomously** - Step back and let it work
5. **Human role:** planning, verification, intervention

## Lab Time

1. Have AI implement phase 1 from your roadmap
2. Verify implementation against roadmap
3. Create scripts/build.sh and scripts/test.sh
4. Run test-fix loop until tests pass
5. Commit working code and updated roadmap

## Resources

- Commander.js (CLI framework): github.com/tj/commander.js
- Bash Exit Codes: tldp.org/LDP/abs/html/exitcodes.html
- Node.js child_process: nodejs.org/api/child_process.html
- JSON Output Best Practices: jsonapi.org
