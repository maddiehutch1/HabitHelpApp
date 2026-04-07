# Phase 9 — Card Detail Sheet Cleanup & AI Button Polish
*Created: April 6, 2026*
*Roadmap: [Roadmap — Phase 9](2026-04-06-roadmap-phase-9-sheet-and-ai-polish.md)*

> **Avoid over-engineering, cruft, and legacy-compatibility features.**

---

## Overview

Two focused improvements:
1. Reduce visual busyness of the card detail bottom sheet by creating clear action hierarchy
2. Make AI-powered buttons visually distinct across the app with a sparkle icon and accent color

---

## Feature 1: Card Detail Sheet Hierarchy

**File:** `lib/screens/deck/widgets/card_detail_sheet.dart`

**Current state:** Four actions stacked vertically with equal weight — Start (FilledButton), What's next? (TextButton), Edit (TextButton), Complete (TextButton). Feels like a menu.

**Target state:**
- **Start** remains a full-width `FilledButton` — the obvious primary action
- **What's next?** remains a full-width `TextButton` below Start (only shown when card has a goalLabel) — the secondary path
- **Edit and Complete** become a horizontal row of compact icon-label buttons below, visually subdued:
  - Edit: pencil icon (`Icons.edit_outlined`) + "Edit" label
  - Complete: check icon (`Icons.check`) + "Complete" label
  - Use `TextButton.icon` or a Row with icon + text, styled smaller than the primary actions
  - Place them in a `Row` with `MainAxisAlignment.center` and some spacing between

**Layout (top to bottom):**
```
[Action label — bold]
[Goal label — muted, if present]
[2 min badge]

[========= Start =========]  ← FilledButton, full width
[     What's next? →      ]  ← TextButton, full width (if goal exists)

    ✏️ Edit     ✓ Complete    ← Row of compact TextButton.icon, centered
```

**Styling for the compact row:**
- Smaller text than the main buttons — use `AppTextStyles.label` size range (12-13px) or a custom style at ~14px
- Use `AppColors.textFaint` for the icon and label color (dimmer than the muted text buttons above)
- Minimal padding — these are utility actions, not primary CTAs
- No full-width — let them sit naturally in a centered row

---

## Feature 2: AI Button Accent Styling

**Files to modify:**
- `lib/screens/create_card/next_step_screen.dart` (2 buttons: "Help me think of one", "Make this smaller")
- `lib/screens/create_card/create_card_action_screen.dart` (2 buttons: "I'm stuck – show ideas", "Make this smaller")

**Changes per button:**

1. **Add sparkle icon** — Prefix each AI button label with `Icons.auto_awesome` (Material's sparkle icon, size ~16)
2. **Add accent color** — Define a new color `AppColors.aiAccent` in `lib/theme.dart`. Choose a warm, soft tone that fits the dark palette — suggestion: a muted amber/gold like `Color(0xFFD4A855)` or soft lavender like `Color(0xFFB0A0D0)`. The exact color can be tuned, but it should be:
   - Noticeably different from `textMuted` (#8A8580)
   - Not so bright it screams — still feels calm and minimal
   - Works on the dark background without being jarring
3. **Apply to button style** — Override the TextButton's `foregroundColor` to `AppColors.aiAccent` so both icon and text take the accent color. Use `TextButton.icon` constructor or a `Row` with icon + text.

**Implementation approach:**
- Add `AppColors.aiAccent` to `lib/theme.dart`
- In each file, change the 2 AI `TextButton` widgets to `TextButton.icon` with `Icons.auto_awesome` and override `style: TextButton.styleFrom(foregroundColor: AppColors.aiAccent)`
- That's it — no new widget classes, no shared button builder. Four buttons, four simple changes.

---

## Files Modified

| File | Change |
|---|---|
| `lib/theme.dart` | Add `AppColors.aiAccent` color constant |
| `lib/screens/deck/widgets/card_detail_sheet.dart` | Restructure layout: Start + What's next stacked, Edit + Complete in compact horizontal row |
| `lib/screens/create_card/next_step_screen.dart` | Add sparkle icon + accent color to 2 AI buttons |
| `lib/screens/create_card/create_card_action_screen.dart` | Add sparkle icon + accent color to 2 AI buttons |

---

## Out of Scope

- Changing AI button labels or copy
- Adding new AI features
- Modifying the VoiceAISuggestionsScreen
- Animations or transitions
- Changes to the timer, deck, or settings screens
