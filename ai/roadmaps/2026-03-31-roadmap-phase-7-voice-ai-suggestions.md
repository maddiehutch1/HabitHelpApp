# Roadmap — Phase 7: Voice AI Suggestions
*Created: March 31, 2026*
*Detailed plan: [Phase 7 Plan](2026-03-31-phase-7-voice-ai-suggestions.md)*
*Previous: [Phase 6 — Tiny Start Unified](2026-03-28-phase-6-tiny-start-unified.md)*
*Status: ✅ Complete — all milestones built; manual device testing pending*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Phase Goal

Add a lightweight AI-powered suggestions screen between voice transcription and card creation. The user records a voice dump, the AI extracts up to 3 actionable task titles, and the user picks which ones to turn into cards. Nothing is auto-added. Failure falls through gracefully to the existing manual flow.

---

## Milestones

| # | Milestone | Outcome | Depends On | Status |
|---|---|---|---|---|
| M7.1 | AI prompt & parser | `suggestTasksFromTranscription()` returns 0–3 titles; errors return empty list | `ai_service.dart` operational | ✅ Complete |
| M7.2 | VoiceAISuggestionsScreen | New screen renders 1–3 checkable, editable suggestions; [Add selected] and fallback link work | M7.1 | ✅ Complete |
| M7.3 | Multi-card queue | Selecting N tasks routes through `CreateCardGoalScreen` N times in order | M7.2 | ✅ Complete |
| M7.4 | Loading state & fallback | Loading indicator shown during AI call; 0 results or errors go to manual path | M7.1 | ✅ Complete |
| M7.5 | Routing update | `_openVoiceInput()` in `deck_screen.dart` routes to new screen after transcription | M7.2 | ✅ Complete |
| M7.6 | Tests & analyze | Integration test updated; `flutter analyze` clean | M7.5 | ✅ Complete |

---

## Out of Scope

- AI-generated goal/action pairs (action titles only)
- Suggestions from manual text input
- More than 3 suggestions
- Any changes to `VoiceInputSheet` UI
- Saving transcription history

---

## Manual Testing Checklist

**AI Parsing:**
- [ ] Short transcription (1 task) → returns 1 suggestion, not padded to 3
- [ ] Long transcription (3+ tasks) → returns exactly 3 suggestions
- [ ] Transcription with no clear tasks → returns 0 suggestions; falls through to manual path
- [ ] API timeout (>8s) → falls through to `CreateCardGoalScreen` with raw transcription
- [ ] API error / invalid key → falls through cleanly; no crash, no blank screen

**VoiceAISuggestionsScreen:**
- [ ] Screen shows correct number of suggestions (1, 2, or 3)
- [ ] All suggestions checked by default
- [ ] Unchecking a suggestion excludes it from [Add selected] queue
- [ ] Edit icon opens inline text field for that suggestion
- [ ] Edited text is used (not original) when added
- [ ] [Add selected] disabled when 0 suggestions checked
- [ ] [Add selected] enabled when ≥1 checked
- [ ] "Add manually instead" link navigates to `CreateCardGoalScreen` with raw transcription

**Multi-card Queue:**
- [ ] Selecting 1 task → `CreateCardGoalScreen` opens once; returns to deck after
- [ ] Selecting 3 tasks → `CreateCardGoalScreen` opens 3 times in order
- [ ] Each task can be completed (save/defer/timer) independently
- [ ] After all tasks processed, deck is shown

**Loading State:**
- [ ] Loading indicator shows immediately after "Create cards from this" tapped
- [ ] Loading indicator dismisses when suggestions arrive or fallback triggers
- [ ] No jank or blank screens during transition

**Regression:**
- [ ] Existing voice → manual path (via "Add manually instead") still works
- [ ] FAB "Type it" path unaffected
- [ ] Fresh Start "Voice planning" button still works
- [ ] All Phase 5 + 6 features unaffected

---

## Definition of Done

- [x] Voice transcription routes through AI and produces 0–3 suggestions
- [x] `VoiceAISuggestionsScreen` renders correctly for 1, 2, and 3 suggestions
- [x] Inline editing works for each suggestion title
- [x] [Add selected] queues selected tasks through `CreateCardGoalScreen` in order
- [x] API failure / timeout falls through cleanly to manual path
- [x] `flutter analyze` clean
- [x] Integration test updated
- [ ] All manual testing checklist items pass on real device

---

## Dependencies

- Phase 5 voice input complete ✅
- Phase 6 unified card creation flow complete ✅
- `ai_service.dart` operational ✅

---

## Progress Log
*Update this section as milestones are completed.*

| Date | Milestone | Notes |
|---|---|---|
| Mar 31, 2026 | M7.1–M7.6 | All features built. `suggestTasksFromTranscription()` added to `ai_service.dart`; `VoiceAISuggestionsScreen` created; `onCardSaved` callback threaded through GoalScreen → ActionScreen → ConfirmScreen for multi-card queue; `_openVoiceInput()` updated with consent check, loading dialog, and route to suggestions screen; integration test regression group added; `flutter analyze` clean. |
