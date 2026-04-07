# Future Feature: Swipe-to-Set Timer (Winding Clock Gesture)

**Status:** Parked — compelling idea, out of MVP scope  
**Date noted:** 2026-04-06

---

## The Concept

Right-swiping a card on the deck screen adjusts its timer duration in real time, like winding a clock. The further right you drag, the more time you commit to. Release to confirm — no buttons, no edit sheet.

The mental model is **physical, tactile, and fluid**, not steppy or mechanical.

---

## Interaction Design

### Duration Intervals
Cards move through threshold zones as the user drags right:

| Zone | Duration |
|------|----------|
| 0–20% of card width | 2 min |
| 20–40% | 5 min |
| 40–60% | 10 min |
| 60–80% | 15 min |
| 80–100%+ | 20 min |

### Live Feedback
- A duration label updates in real time **below the card text** as the user crosses each threshold (e.g. "5 min → 10 min → 15 min").
- No snapping animation — the drag is fully fluid; the zone check happens on release.
- On release, the card's stored duration is updated immediately and the UI reflects the new value.

### No Dismissal
Unlike the left-swipe defer gesture (`Dismissible`), this gesture does **not** dismiss the card. The card stays in place with an updated label.

---

## Why We Didn't Build It Now

1. `Dismissible` does not support continuous feedback — would require a full custom `GestureDetector` drag implementation.
2. Discoverability is near zero with no visual affordance.
3. Precision concerns on small screens, even with threshold zones.
4. MVP scope: editing the timer via the detail sheet is sufficient for now.

---

## Why It's Worth Revisiting

- It's genuinely novel and maps to the core mechanic (time = the entire point of the app).
- The "winding clock" mental model is memorable and could become a signature gesture of MicroDeck.
- The threshold-zone approach (not continuous float) makes precision manageable.
- Could replace the timer edit field entirely, reducing the need for a full edit sheet.

---

## Implementation Notes (When Ready)

- Replace the right-swipe affordance on `_CardTile` with a custom `GestureDetector` tracking `onHorizontalDragUpdate` and `onHorizontalDragEnd`.
- Track drag position as `dx / cardWidth` to determine which zone the user is in.
- On `onHorizontalDragUpdate`: update a local state variable `_hoveredDuration` and rebuild the label.
- On `onHorizontalDragEnd`: if `dx > 0`, persist the duration to the repo; if `dx <= 0`, discard.
- Add haptic feedback (`HapticFeedback.selectionClick()`) each time a zone threshold is crossed.
