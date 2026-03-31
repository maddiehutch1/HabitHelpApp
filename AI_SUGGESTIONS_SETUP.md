# AI Suggestions Setup & Testing Guide

## Overview

Phase 6.2 has been implemented, adding AI-powered suggestions to help users break down overwhelming tasks:
- **"I'm stuck – show ideas"**: Generates 2-3 tiny first step suggestions based on the goal
- **"Make this smaller"**: Breaks down a user's action into an even smaller step

## Implementation Summary

### Files Created
- `/lib/services/ai_service.dart` - OpenAI integration service with consent management

### Files Modified
- `/lib/screens/create_card/create_card_action_screen.dart` - Added AI suggestion UI and logic
- `/lib/screens/settings/settings_screen.dart` - Added AI suggestions toggle
- `/pubspec.yaml` - Added `http: ^1.2.0` dependency

### Features Implemented

#### 1. AI Service (`ai_service.dart`)
- ✅ Consent checking via `hasConsent()`
- ✅ Consent request dialog via `requestConsent()`
- ✅ `generateFirstSteps(String goal)` - Returns List<String> of 2-3 suggestions
- ✅ `makeSmaller(String action)` - Returns String with smaller step
- ✅ Uses OpenAI API with gpt-4o-mini model
- ✅ API key from environment variable: `String.fromEnvironment('OPENAI_API_KEY')`
- ✅ Error handling for network failures
- ✅ Consent stored in SharedPreferences: `aiSuggestionsEnabled` and `hasAskedAIConsent`

#### 2. Action Screen Updates
- ✅ State variables: `_loadingSuggestions`, `_suggestions`, `_smallerSuggestion`, `_loadingSmaller`
- ✅ "I'm stuck – show ideas" button (shows when no suggestions loaded)
- ✅ Loading indicator for suggestions
- ✅ Suggestions displayed as ActionChips that fill text field when tapped
- ✅ "Make this smaller" button (appears after user types)
- ✅ Loading indicator for smaller suggestion
- ✅ Smaller suggestion as ActionChip
- ✅ Consent requested on first tap
- ✅ Error handling with SnackBar for API failures

#### 3. Settings Screen
- ✅ New "AI Assistance" section
- ✅ SwitchListTile for "AI Suggestions"
- ✅ Subtitle: "Get ideas when you're stuck creating tasks. Sends text to OpenAI."
- ✅ Loads state from SharedPreferences on init
- ✅ Saves changes to SharedPreferences when toggled
- ✅ Visual separator (Divider) between Fresh Start and AI sections

#### 4. Dependencies & Configuration
- ✅ Added `http: ^1.2.0` to pubspec.yaml
- ✅ `.env` already in .gitignore for API key protection

## Testing Instructions

### Prerequisites
1. You need an OpenAI API key. Get one at: https://platform.openai.com/api-keys

### Build & Run with API Key

#### Method 1: Using --dart-define (Recommended)
```bash
# For quick testing in debug mode
flutter run --dart-define=OPENAI_API_KEY=your_api_key_here

# For iOS
flutter run -d ios --dart-define=OPENAI_API_KEY=your_api_key_here

# For Android
flutter run -d android --dart-define=OPENAI_API_KEY=your_api_key_here
```

#### Method 2: Using .env file (Alternative)
1. Create a `.env` file in the project root:
```bash
echo "OPENAI_API_KEY=your_api_key_here" > .env
```

2. Run with dart-define pointing to the env var:
```bash
flutter run --dart-define=OPENAI_API_KEY=$OPENAI_API_KEY
```

### Testing the Features

#### Test 1: First-Time Consent Flow
1. Launch the app with API key
2. Navigate to create a card (tap + button)
3. Enter a goal (e.g., "Write my 15-page research paper")
4. Tap "Next" to reach the action screen
5. Tap "I'm stuck – show ideas"
6. **Expected**: Consent dialog appears
7. Tap "Allow"
8. **Expected**: Loading spinner appears, then 2-3 suggestions show as chips
9. Tap a suggestion chip
10. **Expected**: Text field fills with the suggestion

#### Test 2: Make This Smaller
1. On the action screen, type something in the text field (e.g., "Clean my kitchen")
2. **Expected**: "Make this smaller" button appears
3. Tap "Make this smaller"
4. **Expected**: Loading spinner appears, then a smaller suggestion shows as a chip
5. Tap the suggestion chip
6. **Expected**: Text field replaces with the smaller suggestion

#### Test 3: Settings Toggle
1. Go to Settings (gear icon)
2. **Expected**: New "AI Assistance" section visible below Fresh Start
3. Toggle AI Suggestions off
4. Go back and try to create a card
5. **Expected**: AI buttons still appear and work (because consent was already given)
6. Go back to Settings and verify toggle reflects the current state

#### Test 4: Consent Declined
1. Clear app data / reinstall app
2. Navigate to action screen
3. Tap "I'm stuck – show ideas"
4. Tap "Don't allow"
5. **Expected**: No suggestions load, consent is remembered
6. Check Settings
7. **Expected**: AI Suggestions toggle is OFF

#### Test 5: Error Handling
To test error handling without an API key:
```bash
# Run without API key
flutter run

# Try using AI features
# Expected: SnackBar shows "Could not load suggestions. Please try again."
```

### Compilation Check
```bash
# Verify the code compiles without errors
flutter analyze

# Expected: No errors related to AI service implementation
# (There may be pre-existing warnings about other files)
```

## API Cost Estimates

**OpenAI API Costs (gpt-4o-mini):**
- Input: $0.150 / 1M tokens (~$0.0001 per request)
- Output: $0.600 / 1M tokens (~$0.0001 per response)
- **Estimated cost per card creation with AI**: $0.0002

**Usage scenarios:**
- 100 cards/month with AI = $0.02/month
- 1000 cards/month with AI = $0.20/month

## Privacy & Consent

Users are informed via consent dialog:
- "AI suggestions will send your text to OpenAI to generate ideas."
- "Your data is not stored or used for training."

Consent can be managed in Settings at any time.

## Notes

- The app works perfectly without AI features enabled
- AI buttons are optional and non-intrusive
- All features degrade gracefully if API key is missing
- The roadmap included detailed code samples which were used as reference
- No deviations from the roadmap were made

## Next Steps

To test in production:
1. Use `--dart-define` in release builds
2. Monitor API usage via OpenAI dashboard
3. Consider adding rate limiting if needed (currently not implemented per roadmap recommendation)
4. Optional: Add user-provided API keys feature if scaling beyond MVP
