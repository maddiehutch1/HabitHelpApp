# Voice Input Feature Implementation Summary

**Date:** 2026-03-28
**Phase:** 5.1 - Daily Refresh (Manual card creation, no AI)

## Overview
Implemented voice input functionality that allows users to record voice notes and transcribe them into text for manual card creation. This is Phase 5.1, which focuses on voice capture and transcription without AI-powered card generation.

## Files Created

### 1. `/lib/services/voice_service.dart`
A service class that handles:
- Speech-to-text recognition using the `speech_to_text` package
- Microphone permission requests via `permission_handler`
- Recording management with configurable duration (default: 30 seconds)
- Real-time transcription callbacks
- Proper error handling and logging

Key methods:
- `hasPermission()` - Check if microphone permission is granted
- `requestPermission()` - Request microphone permission from user
- `isPermissionPermanentlyDenied()` - Check if user needs to go to settings
- `startListening()` - Start recording with callback for results
- `stopListening()` - Stop recording
- `isListening` - Check if currently recording

### 2. `/lib/screens/deck/widgets/voice_input_sheet.dart`
A bottom sheet modal UI component that provides:
- Initial recording screen with:
  - "What's on your mind today?" prompt
  - Large pulsing microphone icon during recording
  - Countdown timer showing remaining seconds
  - [Stop] button to end recording early

- Post-recording screen with:
  - Editable text area showing transcription
  - [Discard] button to cancel
  - [Create cards from this] button to proceed

Features:
- Automatic permission request on first use
- Permission denied dialog with [Open Settings] option
- Smooth animation for microphone icon pulse
- Real-time transcription updates
- Returns transcription text to parent for manual card creation

## Files Modified

### 1. `/pubspec.yaml`
Added dependencies:
```yaml
speech_to_text: ^7.0.0
permission_handler: ^11.3.1
```

### 2. `/lib/services/app_logger.dart`
Added voice service logger:
```dart
final Logger voiceLog = Logger('VoiceService');
```

### 3. `/android/app/src/main/AndroidManifest.xml`
Added required Android permissions:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

### 4. `/ios/Runner/Info.plist`
Added required iOS permission descriptions:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Micro-Deck needs access to your microphone to record voice notes for creating habit cards.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Micro-Deck needs access to speech recognition to transcribe your voice notes into text.</string>
```

### 5. `/lib/screens/deck/deck_screen.dart`
Integrated voice input into the main deck screen:
- Added import for `VoiceInputSheet`
- Created `_AddMethodSheet` widget showing choice between voice input and manual entry
- Added `_openVoiceInput()` method to handle voice recording flow
- Split `_openAddFlow()` to show method selection sheet first
- Added `_openTemplateBrowser()` for manual entry path
- Created `_MethodOption` widget for consistent method selection UI

The add card flow now works as follows:
1. User taps FAB (+) button
2. Sheet shows two options: "Voice input" or "Manual entry"
3. If voice input selected:
   - Opens voice recording sheet
   - Records up to 30 seconds
   - Shows transcription in editable text area
   - Returns transcription to deck screen
   - Opens add card sheet with transcription pre-filled in action field
4. If manual entry selected:
   - Opens existing template browser sheet

## Usage Flow

1. **User taps FAB (+) button** on deck screen
2. **Add method sheet appears** with two options:
   - Voice input (microphone icon)
   - Manual entry (edit icon)
3. **User selects "Voice input"**
4. **Permission check** (first time only):
   - If granted: proceed to recording
   - If denied: show dialog with [Cancel] and [Open Settings]
5. **Recording screen shows**:
   - Prompt: "What's on your mind today? (30 seconds)"
   - Pulsing microphone icon
   - Countdown timer
   - [Stop] button
6. **User speaks** (or taps Stop early)
7. **Transcription screen shows**:
   - Transcribed text in editable text field
   - [Discard] button
   - [Create cards from this] button
8. **User taps "Create cards from this"**
9. **Add card sheet appears** with transcription pre-filled in the action field
10. **User manually creates card** from the transcription (Phase 5.1 is manual only)

## Technical Details

### Permission Handling
- Permissions requested on first voice input tap, not on app launch
- iOS requires both microphone and speech recognition permissions
- Android requires RECORD_AUDIO permission
- Graceful handling of denied permissions with option to open settings
- Checks for permanently denied status to guide user appropriately

### Speech Recognition
- Uses `speech_to_text` package v7.0.0
- Supports up to 30 seconds of continuous recording
- Provides real-time partial results
- Confirmation mode for better accuracy
- 5-second pause detection
- Handles errors gracefully with logging

### UI/UX
- Pulsing animation on microphone icon (1.2s cycle)
- Countdown timer for user awareness
- Editable transcription field (users can correct errors)
- Follows existing app theme and design patterns
- Consistent with other bottom sheet modals in the app
- Accessible with proper semantics

## Phase 5.1 Notes

This implementation is for **Phase 5.1: Manual card creation**. The flow intentionally does NOT include:
- AI-powered card generation
- Automatic parsing of transcription into multiple cards
- Intelligent goal/action separation

The user receives the transcription and must manually:
- Review and edit the text
- Create cards one at a time from the content
- Fill in goal and action fields themselves

Phase 5.2+ will add AI features for automatic card generation from transcriptions.

## Testing Checklist

Before marking this complete, test:
- [ ] Permissions request on first use (iOS & Android)
- [ ] Permission denied flow with settings redirect
- [ ] Voice recording starts and shows pulsing icon
- [ ] Countdown timer counts down from 30 seconds
- [ ] Stop button ends recording early
- [ ] Transcription appears in text field
- [ ] Transcription is editable
- [ ] Discard button closes sheet without action
- [ ] "Create cards from this" opens add card sheet with text pre-filled
- [ ] Empty transcriptions don't enable "Create cards" button
- [ ] Manual entry path still works (template browser)
- [ ] Voice input icon and description are clear
- [ ] App doesn't crash on permission denial
- [ ] Speech recognition works in noisy environments

## Next Steps

Run these commands to complete the setup:
```bash
cd "/Users/evanneff/Library/CloudStorage/GoogleDrive-neff.evank@gmail.com/My Drive/School/Winter 26/590R/MicroDeckApp"
flutter pub get
flutter clean
flutter run
```

Then test the voice input feature on a physical device (speech recognition requires a real device, not just an emulator).

## Known Limitations

1. Speech recognition requires device capability (won't work on all emulators)
2. Requires internet connection on some platforms for cloud-based recognition
3. Transcription accuracy depends on device, microphone quality, and accent
4. No support for languages other than device default (can be added later)
5. 30-second limit is hardcoded (intentional for Phase 5.1)

## Future Enhancements (Phase 5.2+)

- AI-powered card generation from transcription
- Support for multiple languages
- Offline speech recognition option
- Voice commands for direct actions
- Audio playback of recording
- Save recordings for later processing
