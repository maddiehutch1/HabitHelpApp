# Phase 4 — Future Planning
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Previous: [Phase 3 — v1 Feature Build](complete/2026-02-19-phase-3-v1-features.md)*
*Status: Deferred — do not start until app has been shared with real users and meaningful feedback exists*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Nothing in this phase gets built without evidence from real user behavior. Every item is a hypothesis, not a commitment. Kill ideas freely if the data doesn't support them.

---

## Goal
Evaluate what to build next based on real usage and feedback. Produce a prioritized, evidence-backed plan for v2 — including whether and how to monetize.

---

## Gate — Do Not Enter This Phase Until:
- [ ] App has been shared with real users for a minimum of 4 weeks
- [ ] Meaningful feedback collected (reviews, direct feedback, usage patterns)
- [ ] Day 7 return rate observed (are people coming back?)
- [ ] Top user pain points and praise documented

---

## Items to Evaluate (All Hypotheses — Not Commitments)

### H1 — Monetization / Pro Tier
**Hypothesis:** Users find enough value in the app to pay a one-time fee for expanded features (unlimited cards, scheduling, Dormant Deck).
**Evidence needed:** Strong Day 7 retention; users actively hitting the card limit or requesting scheduling; willingness-to-pay signals in feedback.
**Implementation if validated:** Re-introduce `in_app_purchase`, 5-card free limit, paywall at first completion. Product IDs need setup in App Store Connect and Google Play Console.
**Evaluation criteria:** Do users cite wanting more cards or scheduling as a top request? Is Day 7 retention high enough to indicate real value before asking for payment?

### H2 — App Store Submission (iOS)
**Hypothesis:** Distributing via the App Store reaches more users and provides credibility vs. direct/TestFlight distribution.
**Evidence needed:** Desire to reach a broader audience beyond direct sharing; feedback quality improves with more diverse users.
**Note:** Requires Apple Developer account ($99/year), privacy manifest (`PrivacyInfo.xcprivacy`), screenshots, and App Review. App icon and launcher icons are already done.
**Evaluation criteria:** Is the app stable and polished enough for public scrutiny? Has enough internal/TestFlight testing been done?

### H3 — Apple Watch Companion
**Hypothesis:** Users want to initiate the 2-minute timer from their wrist, receiving the haptic on their watch rather than hunting for their phone.
**Evidence needed:** User feedback requesting wrist-based initiation; high timer completion rate suggesting they want to keep using it.
**Constraint:** Requires Swift/Xcode and a Mac development machine — significant platform shift.
**Evaluation criteria:** Is this cited by >10% of user feedback? Does it justify the platform investment?

### H4 — Android Optimization & Play Store
**Hypothesis:** There is meaningful demand from Android users who can't access the iOS version.
**Evidence needed:** Inbound requests via reviews, social media, or direct contact from Android users.
**Note:** Flutter codebase is already cross-platform — the work is primarily Play Store submission, Android-specific haptic tuning, and testing.
**Evaluation criteria:** Is the Android user segment large enough to justify the support overhead?

### H5 — Home Screen Widget
**Hypothesis:** Users want to start a card directly from their home screen without opening the app.
**Evidence needed:** User feedback requesting faster access; evidence that app-open friction is causing abandonment.
**Evaluation criteria:** Does Day 1 drop-off correlate with the number of taps to first card?

### H6 — Siri / Shortcuts Integration
**Hypothesis:** Users with ADHD want to trigger a card via voice or a custom shortcut.
**Evidence needed:** Feature requests specifically mentioning voice or automation.
**Evaluation criteria:** Is this cited by a meaningful percentage of feedback?

### H7 — LLM-Assisted Habit Suggestion (Opt-In)
**Hypothesis:** After using the app, users want AI-suggested micro-actions for new goals.
**Evidence needed:** Users expressing difficulty creating their own cards; onboarding goal→action step showing meaningful friction.
**Constraint:** Requires cloud API — opt-in only, explicit user consent, privacy policy update. No user data sent without clear consent.
**Evaluation criteria:** Does the onboarding goal→action step show meaningful friction (completion rate <70%)?

### H8 — iCloud Backup (Optional, User-Initiated)
**Hypothesis:** Users who switch devices or reinstall lose their deck and want a restore option.
**Evidence needed:** User feedback mentioning lost data after reinstall.
**Evaluation criteria:** Is this in the top 3 user complaints?

---

## Process for This Phase

1. **Collect evidence (weeks 1–4 of real use)**
   - [ ] Gather feedback by theme
   - [ ] Observe Day 7 return rate
   - [ ] Document top user complaints and top user praise
   - [ ] Note which features are actually being used

2. **Score each hypothesis**
   - [ ] For each item above: Is there evidence? How strong? How many users cited it?
   - [ ] Score: Evidence strength (strong/weak/none) × User impact (high/medium/low) × Build effort (low/medium/high)

3. **Produce v2 plan**
   - [ ] Select top 2–3 items with strong evidence and acceptable effort
   - [ ] Create new focused plan docs in `ai/roadmaps/` for selected features
   - [ ] Update high-level project plan to reflect v2 scope

---

## Roadmap

→ [Roadmap — Phase 4: Future Planning](2026-02-19-roadmap-phase-4-future-planning.md)

---

## Definition of Done
- All hypotheses scored against real user evidence
- v2 scope decided and documented with rationale
- Focused plan docs created for selected features
- Items not selected documented as "rejected with reason" — not silently dropped
