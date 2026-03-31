# Voice Input Feature - Setup & Testing Guide

## Installation Steps

1. **Install Dependencies**
   ```bash
   cd "/Users/evanneff/Library/CloudStorage/GoogleDrive-neff.evank@gmail.com/My Drive/School/Winter 26/590R/MicroDeckApp"
   flutter pub get
   flutter clean
   ```

2. **Test on Physical Device**
   Voice recognition requires a physical device. Emulators may not support speech-to-text.

   For iOS:
   ```bash
   flutter run -d <your-iphone-device-id>
   ```

   For Android:
   ```bash
   flutter run -d <your-android-device-id>
   ```

## What Was Implemented

### New Files
- `/lib/services/voice_service.dart` - Voice recording service with permission handling
- `/lib/screens/deck/widgets/voice_input_sheet.dart` - Voice input UI
- `/ai/implementation_summary_voice_input.md` - Detailed implementation docs

### Modified Files
- `pubspec.yaml` - Added speech_to_text and permission_handler dependencies
- `lib/services/app_logger.dart` - Added voice service logger
- `android/app/src/main/AndroidManifest.xml` - Added RECORD_AUDIO permission
- `ios/Runner/Info.plist` - Added microphone and speech recognition permissions
- `lib/screens/deck/deck_screen.dart` - Integrated voice input into add card flow

## User Flow

### Option 1: From FAB Button
1. User taps the (+) FAB button on deck screen
2. "Add new card" sheet appears with two options:
   - Voice input (microphone icon)
   - Manual entry (edit icon)
3. User taps "Voice input"
4. Voice recording sheet opens (see recording flow below)

### Option 2: From Fresh Start Mode
1. User is in Fresh Start mode (daily refresh)
2. User taps "Voice planning" button
3. Voice recording sheet opens directly (see recording flow below)

### Voice Recording Flow
1. **Permission Check** (first time only):
   - If permission granted: start recording immediately
   - If permission denied: show dialog with "Open Settings" button

2. **Recording Screen**:
   - Shows "What's on your mind today? (30 seconds)"
   - Displays large pulsing microphone icon
   - Shows countdown timer (e.g., "30 s remaining")
   - Has [Stop] button to end early
   - Updates transcription in real-time

3. **After Recording** (auto-stops at 30s or user taps Stop):
   - Shows "Your transcription" screen
   - Transcribed text appears in editable text field
   - User can edit the text if needed
   - Two buttons:
     - [Discard] - Cancel and close
     - [Create cards from this] - Continue to card creation

4. **Card Creation**:
   - Opens standard "New card" sheet
   - Transcription is pre-filled in the "Action" field
   - User can edit goal, action, duration
   - Taps [Save] to create the card

## Testing Checklist

### Permissions
- [ ] First time opening voice input requests microphone permission
- [ ] Accepting permission allows recording to start
- [ ] Denying permission shows alert dialog
- [ ] "Open Settings" button in alert opens device settings
- [ ] After granting permission in settings, voice input works on next attempt
- [ ] iOS: Both microphone and speech recognition permissions are requested
- [ ] Android: RECORD_AUDIO permission is requested

### Voice Recording
- [ ] Microphone icon pulses during recording
- [ ] Countdown timer starts at 30 and counts down
- [ ] Speaking produces real-time transcription (partial results appear)
- [ ] [Stop] button ends recording early
- [ ] Recording auto-stops at 0 seconds
- [ ] Multiple recordings work (permission only requested once)

### Transcription View
- [ ] Transcribed text appears in text field
- [ ] Text field is editable (user can fix errors)
- [ ] Empty transcription disables "Create cards from this" button
- [ ] [Discard] closes sheet without further action
- [ ] [Create cards from this] opens add card sheet with text pre-filled

### Card Creation
- [ ] Transcription appears in "Action" field of add card sheet
- [ ] User can edit goal, action, and duration
- [ ] [Save] creates card successfully
- [ ] Card appears in deck list
- [ ] Voice input works from both FAB and Fresh Start mode

### Edge Cases
- [ ] Very quiet speaking still produces transcription
- [ ] Background noise doesn't crash the app
- [ ] Speaking non-English (if device supports it) works
- [ ] Rapidly opening/closing voice input doesn't crash
- [ ] Recording during phone call handles gracefully
- [ ] Low battery warning doesn't interrupt recording
- [ ] Rotating device during recording doesn't crash

### UI/UX
- [ ] Pulsing animation is smooth (not choppy)
- [ ] Sheet has rounded corners matching app design
- [ ] Colors match app theme (dark mode)
- [ ] Text is readable on all screens
- [ ] Buttons are easy to tap (44pt touch targets)
- [ ] No visual glitches during transitions

## Known Issues & Limitations

1. **Speech recognition quality varies by device**
   - Older devices may have poor accuracy
   - Some accents may not be well-recognized
   - Background noise can degrade quality

2. **Requires internet on some platforms**
   - Android often uses cloud-based recognition
   - iOS may work offline but accuracy varies

3. **30-second limit is fixed**
   - Cannot be adjusted by user (intentional for Phase 5.1)
   - Future versions may allow customization

4. **Single language support**
   - Uses device's default language
   - No in-app language selection (yet)

5. **Manual card creation only**
   - Phase 5.1 does NOT include AI card generation
   - User must manually create cards from transcription
   - Phase 5.2+ will add AI features

## Troubleshooting

### "Could not start voice recording" error
- Check device has microphone
- Ensure permissions are granted
- Restart app and try again
- Check device volume/mute settings

### No transcription appears
- Speak louder or closer to microphone
- Check internet connection (required on some devices)
- Try restarting the device
- Verify language settings match your speech

### App crashes on permission request
- Check Info.plist (iOS) has both permission descriptions
- Check AndroidManifest.xml has RECORD_AUDIO permission
- Clean and rebuild: `flutter clean && flutter pub get`

### Permission dialog doesn't show
- Permission may have been denied previously
- Manually enable in device Settings > App > Permissions

## Next Steps

After successful testing:
1. Update `ai/changelog.md` with voice input feature
2. Mark tasks complete in Phase 5.1 roadmap
3. Consider user feedback for Phase 5.2 AI integration
4. Test on multiple devices (iOS and Android)
5. Get user feedback on transcription accuracy

## Phase 5.2 Planning

Future AI features to add:
- Automatic parsing of transcription into multiple cards
- Intelligent goal/action separation
- Context-aware suggestions
- Multi-language support
- Offline transcription option
