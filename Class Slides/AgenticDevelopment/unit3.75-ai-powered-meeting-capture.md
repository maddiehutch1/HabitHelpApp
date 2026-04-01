# Unit 3.75: AI-Powered Meeting Capture

*Never lose a decision again*

## What We'll Cover Today

1. The Problem with Meetings - Why human notes fail
2. The Record -> Transcribe -> Extract Workflow - Zero-effort capture
3. What AI Can Do With Transcripts - The real superpower
4. Pro Tips & Real Examples - Making it stick

## Learning Outcomes

By end of session, you should be able to:

1. Record meetings/lectures via phone or computer
2. Transcribe recordings using free/cheap AI tools
3. Extract key details, decisions, and action items via AI
4. Transform meeting content into project artifacts (specs, slides, study guides)

---

## The Problem with Meetings

**Why Human Notes Fail:**
- Notes are incomplete and biased toward note-taker priorities
- Multiple attendees develop different understandings
- Details fade within 24 hours
- The solution is recording, not better note-taking

---

## The Workflow: Record -> Transcribe -> AI Extract -> Share

### Recording Tools

- Phone voice memo (free, portable)
- OS recording (QuickTime, Sound Recorder)
- Otter.ai (automatic recording + transcription)
- Zoom/Teams/Meet (built-in)

### Transcription Tools

- Whisper (free, local, open source)
- Otter.ai (600 min/month free tier)
- Phone built-in transcription

Recording and transcription are nearly free; extraction is where value lies.

---

## Before You Hit Record - Legal Considerations

Recording consent varies by jurisdiction:
- **One-party consent states** (e.g., Utah): Recorder can record as participant
- **All-party consent states** (e.g., California): All participants must agree
- **Cross-state meetings:** Strictest applicable law governs

**Best practice:** Announce recording and obtain explicit consent regardless of location.

---

## What AI Can Do With Transcripts

### Extract All Important Details

```
Extract from transcript:
- All decisions made
- Action items with owners
- Unresolved open questions
- Key discussion points
- Mentioned deadlines
Format: Organized markdown with clear sections
```

Structured summary in 30 seconds vs. 20 minutes manual effort.

### Compare to Existing Project

```
Given meeting transcript and current PRD, identify:
- Required PRD changes
- New requirements discussed
- Conflicts with current plans
- Architecture-affecting decisions
```

Automatic detection prevents missed requirement updates.

### Create Specs & Slides

**Spec Generation:**
Create technical specification from transcript including requirements, acceptance criteria, technical approach, dependencies.

**Slide Generation:**
Convert transcript into presentation slides with key points as content and full conversational context in speaker notes.

### Cross-Meeting Synthesis

```
Across multiple meeting transcripts, identify:
- Common themes
- Evolving decisions between meetings
- Open action items
- Consolidated status update
```

Most people synthesize single meetings; AI handles multi-meeting patterns effortlessly.

---

## Pro Tips

- Always record (free, zero effort)
- Transcription + AI summary takes 5 minutes
- Share AI summary instead of raw transcript
- Apply to lectures ("Create study guide")
- Stack recordings with codebase for context-aware updates

### Real Example

> "I recorded 8 meetings at a hackathon across 6 teams. Fed them all to AI. Published consolidated summary immediately."

Competitive advantage through immediate artifact generation.

---

## Key Takeaways

1. **Record everything** (meetings, lectures, brainstorms) - free and available
2. **Transcribe + extract in 5 minutes** - near-zero effort, enormous ROI
3. **AI creates specs, slides, study guides, action items** from transcripts
4. **Compare transcripts against project docs** for automatic requirement updates
5. **High-ROI AI skill** providing true competitive advantage

## Resources

- Whisper (OpenAI): github.com/openai/whisper
- Otter.ai: otter.ai
- Rev.com: rev.com
- Apple Voice Memos: Built-in
