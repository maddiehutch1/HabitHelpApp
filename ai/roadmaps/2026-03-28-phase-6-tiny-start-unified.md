# Phase 6 — Unified "Tiny Start" Flow with AI Assistance
*Created: March 28, 2026*
*Part of: Micro-Deck v2 Core UX Refinement*
*Previous: [Phase 5 — Daily Refresh](2026-03-28-phase-5-daily-refresh.md)*
*Status: ✅ Complete — Mar 31, 2026*

> **Goal:** Replace fragmented card creation flows with a single, momentum-building "Tiny Start" experience. Add AI-powered suggestions to help users when stuck.

---

## Executive Summary

**Problem:**
- Onboarding flow (goal → action → confirm → timer) only runs once on first launch
- Ongoing card creation uses completely different UX (templates, sheets, duration pickers)
- No AI assistance when users blank out during task creation
- Language emphasizes long-term goals instead of immediate barriers

**Solution:**
- Make onboarding screens reusable for all card creation
- Remove template browser and deck add sheets
- Add AI suggestions: "I'm stuck – show ideas" and "Make this smaller"
- Simplify language to match V2 feedback
- Keep voice input as entry point (prefills "big thing")

**Impact:**
- Consistent UX every time users create a card
- Better support for executive dysfunction moments
- Clearer momentum-building flow
- Reduced cognitive load

---

## What Changes

### 1. **Unified Card Creation Flow**

**Remove:**
- Template browser sheet (`_TemplateBrowserSheet`)
- Manual add card sheet (`_AddCardSheet`)
- Add method choice sheet (`_AddMethodSheet`)
- Template data file (`lib/data/templates.dart`)

**Keep & Enhance:**
- `OnboardingGoalScreen` → **rename to** `CreateCardGoalScreen` (reusable)
- `OnboardingActionScreen` → **rename to** `CreateCardActionScreen` (reusable)
- `OnboardingConfirmScreen` → **rename to** `CreateCardConfirmScreen` (reusable)
- Voice input flow (now prefills goal screen instead of separate flow)

**New Entry Point:**
- Tap + button on deck → minimal voice/type sheet (`_showAddMethodSheet`)
  - "Type it" → `CreateCardGoalScreen`
  - "Use voice" → records → `CreateCardGoalScreen(prefilledGoal: transcription)`

---

### 2. **Language Simplification**

**Current → New:**

| Screen | Current Prompt | New Prompt |
|--------|---------------|------------|
| Goal | "What do you want to work toward?" | "What feels big and difficult right now?" |
| Goal subtitle | "A goal, an area of life, anything you want more of." | *(remove - too wordy)* |
| Action | "What's one tiny thing that starts it?" | "What's one tiny step you could take first?" |
| Action subtitle | "Start with a verb. Make it small enough to do right now." | "Think in terms of 2 minutes or less. Smaller is better." |
| Confirm | "Good. Let's do two minutes of it right now." | "Ready for your tiny start?" |
| Confirm subtitle | *(none)* | "You're just giving this 2 tiny minutes. You can stop after that or keep going." |

**Placeholder examples:**

| Field | Current | New |
|-------|---------|-----|
| Goal | "e.g. Run more often · Sleep better" | "e.g. Write my 15-page research paper" |
| Action | "e.g. Put on my running shoes" | "e.g. Open the document" |

---

### 3. **AI Suggestion Features**

#### A. "I'm stuck – show ideas" (Action Screen)

**Trigger:** Link/button on `CreateCardActionScreen` below text input

**Behavior:**
1. User taps "I'm stuck – show ideas"
2. Loading indicator appears (1-3 seconds)
3. AI generates 2-3 tiny first step suggestions based on goal text
4. Shows as tappable pills below input field
5. Tapping a pill fills the text input (user can still edit)
6. Suggestions disappear when user starts typing manually

**API Call:**
```
POST https://api.openai.com/v1/chat/completions

Prompt:
"A user wants to work on: '{goal_text}'

Generate 3 tiny first steps they could take to start this task. Each step should:
- Take 2 minutes or less
- Be concrete and specific
- Start with a verb
- Feel doable even when overwhelmed

Format as a JSON array of strings. Example: ["Open the document", "Set a 2-minute timer", "Write one sentence"]"

Model: gpt-4o-mini (fast, cheap)
Max tokens: 100
Temperature: 0.7
```

**Privacy:**
- First use: Show consent dialog
  - "AI suggestions will send your text to OpenAI to generate ideas. Continue?"
  - [Don't allow] [Allow]
- If denied: Button becomes disabled, shows tooltip "Enable AI suggestions in Settings"
- Setting saved to `shared_preferences.aiSuggestionsEnabled` (default: null = not asked yet)

#### B. "Make this smaller" (Action Screen)

**Trigger:** Link appears AFTER user has typed something in action field

**Behavior:**
1. User types an action like "Clean my kitchen"
2. "Make this smaller" link appears below input
3. User taps it
4. AI breaks down the action into an even smaller step
5. Shows suggestion as tappable pill
6. User can accept (fills input) or ignore (keeps typing)

**API Call:**
```
POST https://api.openai.com/v1/chat/completions

Prompt:
"A user wrote this first step: '{action_text}'

This feels too big for them. Suggest ONE smaller, more concrete first step that takes 2 minutes or less and requires minimal decision-making.

Format as a single string, not a list. Start with a verb. Be specific."

Model: gpt-4o-mini
Max tokens: 50
Temperature: 0.5
```

---

### 4. **Voice Input Integration**

**Current:** Voice input only available in Fresh Start mode, shows as separate choice

**New:** Voice input available for all users, prefills goal field

**Updated Flow:**
1. User long-presses + button on deck (or taps microphone icon)
2. Voice input sheet opens (30-second recording)
3. Transcription completes
4. **Instead of showing add card sheet**, navigate to `CreateCardGoalScreen` with:
   - Goal field prefilled with transcription
   - Action field empty (user proceeds to next screen)
   - Optional: Auto-advance to action screen if user confirms transcription

**Alternative (simpler):**
- Remove long-press gesture complexity
- Voice input only available from goal screen as a microphone button
- Tapping mic → records → fills goal field
- Keeps UX simpler, avoids hidden gestures

---

### 5. **Settings Changes**

**Add new setting:**
- "AI Suggestions" toggle (default: off, requires first-time consent)
- Sub-text: "Get ideas when you're stuck creating tasks. Sends text to OpenAI."
- Only shown after user has seen consent dialog once

**Settings screen now has:**
1. Fresh Start mode (existing)
2. AI Suggestions (new)
3. *(Future: notification preferences, timer defaults)*

---

## Technical Implementation

### Phase 6.1 — Unified Flow (No AI)

**Goal:** Replace fragmented flows with consistent "Tiny Start" UX

#### Step 1: Rename & Refactor Screens

**File changes:**
```
lib/screens/onboarding/onboarding_goal_screen.dart
  → lib/screens/create_card/create_card_goal_screen.dart

lib/screens/onboarding/onboarding_action_screen.dart
  → lib/screens/create_card/create_card_action_screen.dart

lib/screens/onboarding/onboarding_confirm_screen.dart
  → lib/screens/create_card/create_card_confirm_screen.dart
```

**Code changes:**
- Remove "onboarding" references in class names
- Keep all functionality identical initially
- Update imports across the app

#### Step 2: Update Language

**In each screen, update:**
- Headline text
- Subtitle text
- Placeholder examples
- Button labels (if needed)

See Language Simplification table above.

#### Step 3: Remove Old Add Flows from Deck Screen

**In `deck_screen.dart`:**

Remove methods:
- `_openAddFlow()` — replaced with direct navigation to `CreateCardGoalScreen`
- `_openTemplateBrowser()` — deleted
- `_showAddCardSheet()` — deleted
- `_mostRecentGoal()` — no longer needed (every creation starts from goal screen)

Remove widgets:
- `_AddMethodSheet` — deleted
- `_TemplateBrowserSheet` — deleted
- `_TemplateRow` — deleted
- `_AddCardSheet` — deleted

**Update floating action button:**
```dart
FloatingActionButton(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateCardGoalScreen(),
      ),
    );
  },
  child: const Icon(Icons.add),
)
```

**Update empty state button:**
```dart
FilledButton.icon(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreateCardGoalScreen(),
      ),
    );
  },
  icon: const Icon(Icons.add),
  label: const Text('Add a card'),
)
```

#### Step 4: Update Voice Input Flow

**Current:** Voice input opens add card sheet with prefilled action

**New:** Voice input opens goal screen with prefilled goal

**In `deck_screen.dart`, update `_openVoiceInput()`:**

```dart
Future<void> _openVoiceInput() async {
  final transcription = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const VoiceInputSheet(),
  );

  if (transcription != null && transcription.isNotEmpty && mounted) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateCardGoalScreen(
          prefilledGoal: transcription,
        ),
      ),
    );
  }
}
```

**Update `CreateCardGoalScreen` to accept optional `prefilledGoal`:**

```dart
class CreateCardGoalScreen extends StatefulWidget {
  const CreateCardGoalScreen({super.key, this.prefilledGoal});

  final String? prefilledGoal;

  @override
  State<CreateCardGoalScreen> createState() => _CreateCardGoalScreenState();
}

class _CreateCardGoalScreenState extends State<CreateCardGoalScreen> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.prefilledGoal != null) {
      _controller.text = widget.prefilledGoal!;
    }
  }
  // ... rest of implementation
}
```

#### Step 5: Update Welcome Screen

**In `welcome_screen.dart`:**

Update navigation to use new screen names:
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => const CreateCardGoalScreen(),
  ),
);
```

#### Step 6: Delete Unused Files

**Remove:**
- `lib/data/templates.dart` (template definitions)
- Any imports of templates across the codebase

**Test:**
- App compiles without errors
- First-time onboarding works (welcome → create card flow)
- Adding cards from deck works (+ button → create card flow)
- Voice input prefills goal field correctly
- No references to old template/sheet code remain

---

### Phase 6.2 — AI Suggestions

**Goal:** Add "I'm stuck" and "Make this smaller" buttons with OpenAI integration

#### Step 1: Add OpenAI API Service

**New file:** `lib/services/ai_service.dart`

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AIService {
  static const _apiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const _baseUrl = 'https://api.openai.com/v1/chat/completions';

  // Check if user has consented to AI suggestions
  static Future<bool> hasConsent() async {
    final prefs = SharedPreferencesAsync();
    return await prefs.getBool('aiSuggestionsEnabled') ?? false;
  }

  // Request consent (first-time only)
  static Future<bool> requestConsent(BuildContext context) async {
    final prefs = SharedPreferencesAsync();
    final hasAsked = await prefs.getBool('hasAskedAIConsent') ?? false;

    if (hasAsked) {
      return await hasConsent();
    }

    // Show consent dialog
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enable AI Suggestions?'),
        content: const Text(
          'AI suggestions will send your text to OpenAI to generate ideas. '
          'Your data is not stored or used for training.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Don't allow"),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    await prefs.setBool('hasAskedAIConsent', true);
    if (result == true) {
      await prefs.setBool('aiSuggestionsEnabled', true);
    }

    return result ?? false;
  }

  // Generate first step suggestions from goal
  static Future<List<String>> generateFirstSteps(String goal) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content': 'You help people break down overwhelming tasks into tiny first steps.',
          },
          {
            'role': 'user',
            'content': '''A user wants to work on: "$goal"

Generate 3 tiny first steps they could take to start this task. Each step should:
- Take 2 minutes or less
- Be concrete and specific
- Start with a verb
- Feel doable even when overwhelmed

Format as a JSON array of strings. Example: ["Open the document", "Set a 2-minute timer", "Write one sentence"]''',
          },
        ],
        'max_tokens': 100,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('AI service error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final content = data['choices'][0]['message']['content'];

    // Parse JSON array from response
    final suggestions = (jsonDecode(content) as List).cast<String>();
    return suggestions.take(3).toList();
  }

  // Break down an action into smaller step
  static Future<String> makeSmaller(String action) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content': 'You help people break down tasks into smaller, more manageable steps.',
          },
          {
            'role': 'user',
            'content': '''A user wrote this first step: "$action"

This feels too big for them. Suggest ONE smaller, more concrete first step that takes 2 minutes or less and requires minimal decision-making.

Format as a single string, not a list. Start with a verb. Be specific.''',
          },
        ],
        'max_tokens': 50,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('AI service error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'].trim();
  }
}
```

#### Step 2: Update Action Screen with AI Buttons

**In `create_card_action_screen.dart`:**

Add state variables:
```dart
class _CreateCardActionScreenState extends State<CreateCardActionScreen> {
  final _controller = TextEditingController();
  bool _loadingSuggestions = false;
  List<String>? _suggestions;
  String? _smallerSuggestion;
  bool _loadingSmaller = false;

  // ... existing code
```

Add "I'm stuck – show ideas" button:
```dart
// Below TextField, before Spacer
if (!_loadingSuggestions && _suggestions == null)
  Padding(
    padding: const EdgeInsets.only(top: AppSpacing.xs),
    child: TextButton(
      onPressed: _showAISuggestions,
      child: const Text("I'm stuck – show ideas"),
    ),
  ),

if (_loadingSuggestions)
  const Padding(
    padding: EdgeInsets.only(top: AppSpacing.sm),
    child: Center(
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  ),

if (_suggestions != null)
  Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _suggestions!.map((suggestion) {
        return ActionChip(
          label: Text(suggestion),
          onPressed: () {
            setState(() {
              _controller.text = suggestion;
              _suggestions = null; // Hide after selection
            });
          },
        );
      }).toList(),
    ),
  ),
```

Add "Make this smaller" button:
```dart
// Below TextField and AI suggestions
if (_controller.text.trim().isNotEmpty && !_loadingSmaller)
  Padding(
    padding: const EdgeInsets.only(top: AppSpacing.xs),
    child: TextButton(
      onPressed: _makeSmaller,
      child: const Text('Make this smaller'),
    ),
  ),

if (_loadingSmaller)
  const Padding(
    padding: EdgeInsets.only(top: AppSpacing.sm),
    child: Center(
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  ),

if (_smallerSuggestion != null)
  Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: ActionChip(
      label: Text(_smallerSuggestion!),
      onPressed: () {
        setState(() {
          _controller.text = _smallerSuggestion!;
          _smallerSuggestion = null;
        });
      },
    ),
  ),
```

Add methods:
```dart
Future<void> _showAISuggestions() async {
  // Check/request consent
  final hasConsent = await AIService.requestConsent(context);
  if (!hasConsent) return;

  setState(() => _loadingSuggestions = true);

  try {
    final suggestions = await AIService.generateFirstSteps(widget.goal);
    if (mounted) {
      setState(() {
        _suggestions = suggestions;
        _loadingSuggestions = false;
      });
    }
  } catch (e) {
    if (mounted) {
      setState(() => _loadingSuggestions = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not load suggestions. Please try again.'),
        ),
      );
    }
  }
}

Future<void> _makeSmaller() async {
  final hasConsent = await AIService.requestConsent(context);
  if (!hasConsent) return;

  setState(() => _loadingSmaller = true);

  try {
    final smaller = await AIService.makeSmaller(_controller.text.trim());
    if (mounted) {
      setState(() {
        _smallerSuggestion = smaller;
        _loadingSmaller = false;
      });
    }
  } catch (e) {
    if (mounted) {
      setState(() => _loadingSmaller = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not generate suggestion. Please try again.'),
        ),
      );
    }
  }
}
```

#### Step 3: Add Settings Toggle

**In `settings_screen.dart`:**

Add AI suggestions toggle below Fresh Start toggle:
```dart
// After Fresh Start toggle
const SizedBox(height: AppSpacing.md),
const Divider(color: AppColors.border),
const SizedBox(height: AppSpacing.md),

// AI Suggestions section
const Text('AI Assistance', style: AppTextStyles.label),
const SizedBox(height: AppSpacing.sm),

SwitchListTile(
  title: const Text('AI Suggestions'),
  subtitle: const Text(
    'Get ideas when you're stuck creating tasks. Sends text to OpenAI.',
    style: AppTextStyles.bodyMuted,
  ),
  value: _aiSuggestionsEnabled,
  onChanged: (value) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setBool('aiSuggestionsEnabled', value);
    setState(() => _aiSuggestionsEnabled = value);
  },
),
```

Add state variable:
```dart
bool _aiSuggestionsEnabled = false;

@override
void initState() {
  super.initState();
  _loadSettings();
}

Future<void> _loadSettings() async {
  final prefs = SharedPreferencesAsync();
  final aiEnabled = await prefs.getBool('aiSuggestionsEnabled') ?? false;
  setState(() => _aiSuggestionsEnabled = aiEnabled);
}
```

#### Step 4: Add API Key Management

**Option 1: Environment Variable (Recommended for MVP)**

Add to `.env` file (not checked into git):
```
OPENAI_API_KEY=sk-...
```

Load in `main.dart`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  // ... rest of main
}
```

Build with key:
```bash
flutter run --dart-define=OPENAI_API_KEY=$OPENAI_API_KEY
```

**Option 2: User-Provided Key (More Complex)**

Add settings field for users to input their own API key (secure storage with `flutter_secure_storage`).

**Recommendation:** Start with Option 1 for testing, evaluate cost, then decide if user-provided keys are needed.

#### Step 5: Add Dependencies

**In `pubspec.yaml`:**
```yaml
dependencies:
  http: ^1.2.0                      # HTTP client for API calls
  flutter_dotenv: ^5.1.0            # Environment variable loading
```

#### Step 6: Update Privacy Policy

**Add disclosure:**
- AI suggestions send goal/action text to OpenAI API
- Data not stored by OpenAI (per API policy for non-training endpoints)
- User can disable in Settings
- Optional: Link to OpenAI's privacy policy

---

## Files Changed Summary

### New Files
```
lib/screens/create_card/
  ├── create_card_goal_screen.dart       # Renamed from onboarding_goal_screen
  ├── create_card_action_screen.dart     # Renamed from onboarding_action_screen
  └── create_card_confirm_screen.dart    # Renamed from onboarding_confirm_screen

lib/services/
  └── ai_service.dart                    # OpenAI API integration
```

### Modified Files
```
lib/screens/deck/deck_screen.dart
  - Remove: _openAddFlow, template browser, add card sheet
  - Update: + button → navigate to CreateCardGoalScreen
  - Update: voice input → prefills goal screen

lib/screens/welcome/welcome_screen.dart
  - Update: navigation to CreateCardGoalScreen

lib/screens/settings/settings_screen.dart
  - Add: AI suggestions toggle

lib/app.dart
  - Update: imports (onboarding → create_card)

pubspec.yaml
  - Add: http, flutter_dotenv dependencies

.gitignore
  - Add: .env (to protect API key)
```

### Deleted Files
```
lib/screens/onboarding/                  # Folder renamed to create_card/
  (files moved, not deleted)

lib/data/templates.dart                  # No longer needed
```

---

## Cost & Rate Limiting

**OpenAI API Costs (gpt-4o-mini):**
- Input: $0.150 / 1M tokens (~$0.0001 per request)
- Output: $0.600 / 1M tokens (~$0.0001 per response)
- **Estimated cost per card creation with AI:** $0.0002

**Usage scenarios:**
- 100 cards/month with AI = $0.02/month
- 1000 cards/month with AI = $0.20/month

**Rate limiting:**
- No hard limits needed initially
- Monitor usage via OpenAI dashboard
- Add per-user cooldown if abuse detected (e.g., max 10 AI calls/hour)

**Recommendation:** Start without rate limiting, add if needed.

---

## Migration Path

### For Existing Users

**No breaking changes:**
- Cards created with old flow still work
- Templates deleted but users weren't attached to them (they were defaults)
- Voice input flow changes but improves UX (prefills goal instead of action)

**What users will notice:**
- + button goes straight to goal screen (faster)
- No more template browser (simpler)
- Optional: AI suggestions if they enable them

**Communication:**
- No announcement needed (it's a UX refinement, not a feature removal)
- Optional: In-app tooltip on first + button tap: "New simplified flow! Just answer two quick questions to start."

---

## Privacy & Legal

### Privacy Policy Updates

**Add disclosure:**

> **AI-Powered Suggestions (Optional)**
>
> If you enable AI suggestions in Settings, the text you write when creating tasks (goal and action descriptions) will be sent to OpenAI's API to generate personalized suggestions.
>
> - We use OpenAI's API with zero data retention (your data is not stored or used for training).
> - You can disable AI suggestions at any time in Settings.
> - Disabling AI suggestions does not affect any other features.
>
> For more information, see [OpenAI's API Data Usage Policy](https://openai.com/policies/api-data-usage-policies).

**Location:** Add to app's privacy policy (in Settings screen or external link)

### User Consent Flow

1. **First AI button tap:** Show consent dialog
2. **User accepts:** Set `aiSuggestionsEnabled = true`, fire API call
3. **User declines:** Set flag to "asked but declined", disable AI buttons
4. **Later enable via Settings:** Can toggle on without re-consent (already informed)

---

## Open Questions

1. **Voice input gesture:** Should we keep voice input as a separate "Voice planning" button (current), or add a microphone icon to the goal screen itself? Separate button is clearer but adds UI clutter.

2. **API key management:** Environment variable (dev holds key) vs. user-provided key (each user brings their own API key)? Former is simpler, latter scales better.

3. **Offline AI suggestions:** Should we cache common suggestions locally (e.g., "Open the document", "Set a timer") and show those when offline? Adds complexity but improves reliability.

4. **Suggestion quality:** Should we add a thumbs up/down feedback mechanism to improve prompts over time? Useful but adds complexity.

5. **Cost cap:** Should we set a monthly budget cap per user (e.g., 50 AI calls/month) to prevent runaway costs? Probably not needed initially given low per-call cost.

---

## Success Metrics

**Adoption:**
- % of users who enable AI suggestions within first week
- % of card creations that use AI suggestions
- Average time spent on action screen (should decrease with AI help)

**Quality:**
- % of AI suggestions that users select (vs. typing manually)
- User retention after first AI-assisted card creation

**Performance:**
- Average AI response time (target: <2 seconds)
- API error rate (target: <1%)

**Business:**
- Total monthly OpenAI API cost
- Cost per active user per month

---

## Next Steps

After Phase 6 completion, consider:

1. **Ring Timer Visualization** (from V2 feedback) — Add circular progress ring to timer screen
2. **Mini Celebration** (from V2 feedback) — Add confetti/haptic burst on timer completion
3. **Cached AI Suggestions** — Offline fallback with common suggestions
4. **AI Suggestion Feedback** — Thumbs up/down to improve prompts
5. **Voice-to-Card Direct** — Skip goal screen if transcription is clear enough (advanced)

---

*End of Roadmap*
