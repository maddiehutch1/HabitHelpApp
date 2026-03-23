# Phase 2 — Polish & Stability
*Created: February 19, 2026*
*Part of: [Project Plan](2026-02-19-high-level-project-plan.md)*
*Previous: [Phase 1 — MVP Demo](2026-02-19-phase-1-mvp-demo.md)*
*Next: [Phase 3 — v1 Feature Build](2026-02-19-phase-3-v1-features.md)*
*Status: Complete — Feb 21, 2026*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**
> Polish means fixing what's rough, not adding new features. Every item here should make the existing demo loop feel better — not extend its scope. If a "polish" idea adds a new user-facing behavior, it belongs in Phase 3.

---

## Goal
The Phase 1 demo loop feels like a real product. Dark, calm, fast, and trustworthy. No rough edges visible in a demo or user test.

---

## Plan

### 1 — Theming
- [ ] Define color constants: background (warm near-black `#0F0E0D`), surface, text primary, text muted, accent
- [ ] Define typography: font sizes for headline, body, label, muted — all using system font (no custom font in v1)
- [ ] Define spacing constants: consistent padding and gap values (8, 16, 24, 32)
- [ ] Apply `ThemeData` to `MaterialApp` — dark theme, no Material splash effects
- [ ] Remove all default Flutter blue/purple accent colors
- [ ] Verify all screens use theme values — no hardcoded colors anywhere

### 2 — Timer Animations
- [ ] Pulsing dot: slow sine-wave opacity animation (period ~3s, opacity 0.3→1.0→0.3) using `AnimationController`
- [ ] Completion fade: countdown replaced by completion word with a soft opacity fade-in
- [ ] Keep animations purposeful and slow — no bounce, no scale pop, no spring physics
- [ ] Confirm pulsing dot stops cleanly when timer is paused

### 3 — Screen Transitions
- [ ] Default Flutter slide transition is acceptable for onboarding flow (left-to-right)
- [ ] Timer screen: consider a fade transition instead of slide (calmer entry)
- [ ] Deck screen after completion: pop animation, not a push
- [ ] No custom page transition library — use `PageRouteBuilder` only if needed

### 4 — Edge Cases
- [ ] **Empty deck state**: visible prompt and [+] button — not a blank screen
- [ ] **Keyboard handling**: all text fields scroll/resize correctly, "Next" keyboard action moves to next field or submits
- [ ] **Long text**: action labels that exceed one line wrap cleanly on cards and timer screen
- [ ] **Back navigation**: confirm behavior on each screen is intentional (onboarding back flows work, timer blocks back during active session)
- [ ] **Rapid tapping**: tapping [Start now] or a deck card twice quickly doesn't push timer screen twice
- [ ] **App backgrounded during timer**: timer pauses when app goes to background, resumes when foregrounded (use `AppLifecycleState`)
- [ ] **First launch after uninstall/reinstall**: `hasCompletedOnboarding` is false, Welcome screen shows correctly

### 5 — Error Handling
- [ ] Database open failure: show an error screen (rare but handle gracefully — don't crash silently)
- [ ] Card insert failure: surface a brief error message — don't silently drop the card
- [ ] `SharedPreferencesAsync` read failure: default to showing onboarding (safe fallback)
- [ ] All `async` calls wrapped in try/catch where failure would affect the user

### 6 — Accessibility
- [ ] All tap targets meet minimum 44×44pt size
- [ ] Text contrast ratio meets WCAG AA (4.5:1 minimum) against dark background
- [ ] All interactive elements have semantic labels for screen readers
- [ ] Timer screen readable without color — countdown visible in grayscale

### 7 — Performance
- [ ] Cold launch to deck visible: measure with `flutter run --profile` — target under 1.5s
- [ ] Card tap to timer screen: target under 200ms (no loading state)
- [ ] Database query on deck load: no visible lag on 10+ cards
- [ ] No `setState` rebuilds on every timer tick that cause unnecessary repaints (timer state isolated)

### 8 — Device Testing
- [ ] Android emulator: full demo loop without issues
- [ ] Android real device (if available): haptic feels correct, wakelock works
- [ ] iOS simulator via Codemagic: layout correct, no overflow errors
- [ ] iOS real device: haptic confirms `mediumImpact` vs `successNotification` — pick one and lock in

---

## Roadmap

→ [Roadmap — Phase 2: Polish & Stability](2026-02-19-roadmap-phase-2-polish.md)

---

## Definition of Done
- Full demo loop runs on a real iOS and Android device without visible rough edges
- Theme is consistent — no hardcoded colors, no Flutter defaults visible
- Pulsing dot animates correctly and stops on pause
- All listed edge cases handled
- Cold launch under 1.5s on a mid-range device
- Haptic type finalized and consistent

## Next Phase
→ [Phase 3 — v1 Feature Build](2026-02-19-phase-3-v1-features.md)
