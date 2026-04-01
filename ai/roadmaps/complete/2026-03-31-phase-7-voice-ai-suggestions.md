# Phase 7 — Voice AI Suggestions
*Created: March 31, 2026*
*Part of: Micro-Deck v2 Feature Expansion*
*Previous: [Phase 6 — Tiny Start Unified](2026-03-28-phase-6-tiny-start-unified.md)*
*Roadmap: [Roadmap — Phase 7](2026-03-31-roadmap-phase-7-voice-ai-suggestions.md)*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> This is a single, focused screen addition. It should not require changes to the card model, the AI service interface, or the existing voice flow — it sits cleanly between them. If it starts growing, cut scope before adding complexity.

---

## Goal

After a user records a voice dump and taps "Create cards from this," intercept the raw transcription and pass it to the AI service. Show the user up to 3 suggested micro-tasks extracted from their words. Let them pick which ones to keep and optionally edit any suggestion before adding it to their deck. Selected tasks route into the existing card creation breakdown flow.

**The single sentence version:** Turn a messy voice dump into a short, curated list of actionable cards — without making the user do the parsing themselves.

---

## Background & Context

### Why this exists

The current voice → card flow hands the entire raw transcription to `CreateCardGoalScreen` as a prefilled goal. This works for a single concise thought but fails for what voice input is actually used for: "I need to finish my capstone, email my advisor, and do my morning stretches." That's 3 cards, not one, and the user is left manually editing a wall of text into a single card goal field.

### What already exists (do not rebuild)

- `lib/services/voice_service.dart` — STT service, fully implemented
- `lib/screens/deck/widgets/voice_input_sheet.dart` — records, transcribes, returns transcription string
- `lib/services/ai_service.dart` — OpenAI API integration, already wired
- `lib/screens/create_card/create_card_goal_screen.dart` — destination after suggestion selection
- `.env.json` — API key already stored
- `_openVoiceInput()` in `deck_screen.dart` — the caller that will route to the new screen

### Design decisions locked in (from planning)

- **3 suggestions max** — prevents deck bloat, keeps the screen scannable
- **No transcript shown on the suggestions screen** — the AI already processed it; showing raw text adds noise
- **Inline editing** — task title only (not full card detail); goal and action detail happens in the existing breakdown flow
- **User picks; nothing is auto-added** — every card added is a deliberate tap
- **Graceful AI failure** — if the API call fails or times out, fall through to the existing `CreateCardGoalScreen(prefilledGoal: transcription)` behavior so the user is never blocked
- **Action titles only from AI** — the AI returns suggested action labels, not goal/action pairs; the existing goal → action breakdown flow handles the rest

---

## User Flow

```
FAB → Add Method Sheet → "Use voice"
  ↓
VoiceInputSheet (existing)
  ↓
User taps "Create cards from this"
  ↓
[Loading state] AI parses transcription → up to 3 suggested task titles
  ↓
VoiceAISuggestionsScreen (NEW)
  Shows: "Here's what I heard" + list of 1–3 suggestions
  Each suggestion: checkbox + task title + edit icon
  Bottom: [Add selected] button (disabled until ≥1 selected)
  Fallback link: "Add manually instead" (goes to CreateCardGoalScreen)
  ↓
User selects/edits suggestions → taps [Add selected]
  ↓
For each selected task:
  → Push CreateCardGoalScreen(prefilledGoal: taskTitle)
  → User completes breakdown flow (action, confirm, timer/save)
```

---

## Plan

### Feature 1 — AI Prompt & Response Parsing

- [ ] Add a `suggestTasksFromTranscription(String transcription)` method to `ai_service.dart`
- [ ] Prompt instructs the model to extract up to 3 distinct actionable tasks from the transcription
- [ ] Response returns a plain list of short task titles (not goal/action pairs)
- [ ] Cap response to 3 items; strip empty or duplicate entries
- [ ] Handle API errors, timeouts, and malformed responses gracefully — return empty list on failure

**Prompt shape (not final wording):**
> "Extract up to 3 distinct tasks from this voice note. Return only a JSON array of short, actionable task titles (under 10 words each). If fewer than 3 tasks are present, return only what's there. Do not invent tasks. Voice note: [transcription]"

---

### Feature 2 — VoiceAISuggestionsScreen

- [ ] New screen: `lib/screens/create_card/voice_ai_suggestions_screen.dart`
- [ ] Receives: `List<String> suggestions` + original `String transcription` (for fallback)
- [ ] Shows screen title: "Here's what I heard"
- [ ] Shows subtitle: "Pick what to work on" (or similar short, calm copy)
- [ ] Renders 1–3 suggestion tiles, each with:
  - Checkbox (default: checked)
  - Task title text
  - Edit icon → inline text field for editing the title
- [ ] [Add selected] button: disabled when 0 checked, enabled when ≥1 checked
- [ ] "Add manually instead" text link at bottom → `CreateCardGoalScreen(prefilledGoal: transcription)`
- [ ] No back-navigation complexity — user can always dismiss or use fallback link

---

### Feature 3 — Multi-card Queue After Selection

- [ ] When [Add selected] is tapped, collect all checked (and edited) titles into an ordered list
- [ ] Navigate to `CreateCardGoalScreen` for the first task (prefilledGoal: title)
- [ ] After that card is saved/deferred, navigate back to the queue and push next task
- [ ] If queue is empty after all tasks processed: return to deck
- [ ] Keep queue logic simple — a plain `List<String>` passed through navigator or a minimal state holder; no global state, no Riverpod provider needed for this

---

### Feature 4 — Loading State & Fallback

- [ ] After "Create cards from this" is tapped in `VoiceInputSheet`, show a brief loading indicator while the AI call completes (expected: 1–3 seconds)
- [ ] If AI returns 0 suggestions or errors: skip `VoiceAISuggestionsScreen` entirely, go directly to `CreateCardGoalScreen(prefilledGoal: transcription)`
- [ ] If AI returns 1–3 suggestions: push `VoiceAISuggestionsScreen`
- [ ] Do not block the UI for more than 8 seconds — set a timeout and fall through to manual path

---

### Feature 5 — Routing Update in deck_screen.dart

- [ ] Update `_openVoiceInput()` in `deck_screen.dart` to route to the new screen after transcription returns
- [ ] Import `voice_ai_suggestions_screen.dart`
- [ ] The existing `VoiceInputSheet` return value (transcription string) is unchanged — all new logic is in `_openVoiceInput()` after the sheet closes

---

## Out of Scope for This Phase

- ❌ AI-generated goal/action pairs (AI returns action titles only)
- ❌ Saving transcription history
- ❌ Batch-adding all suggestions without the breakdown flow
- ❌ Suggestions from manual text input (voice path only for now)
- ❌ More than 3 suggestions
- ❌ Any changes to `VoiceInputSheet` UI

---

## Definition of Done

- [ ] Voice transcription routes through AI and produces 0–3 suggestions
- [ ] `VoiceAISuggestionsScreen` renders correctly for 1, 2, and 3 suggestions
- [ ] Inline editing works for each suggestion title
- [ ] [Add selected] queues selected tasks into `CreateCardGoalScreen` in order
- [ ] API failure / timeout falls through cleanly to manual path
- [ ] `flutter analyze` clean
- [ ] Integration test updated for new voice → AI flow

---

## Dependencies

- Phase 5 voice input flow complete ✅
- Phase 6 `CreateCardGoalScreen` unified flow complete ✅
- `ai_service.dart` operational ✅
- `.env.json` API key present ✅
