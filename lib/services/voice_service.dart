import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'app_logger.dart';

/// Service for handling voice input using speech-to-text recognition.
///
/// Manages microphone permissions and provides speech recognition with
/// configurable duration and result callbacks.
class VoiceService {
  VoiceService._();

  static final VoiceService instance = VoiceService._();

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _initialized = false;

  /// Check if microphone permission is granted.
  Future<bool> hasPermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted;
  }

  /// Request microphone permission from the user.
  ///
  /// Returns true if permission is granted, false otherwise.
  Future<bool> requestPermission() async {
    voiceLog.info('Requesting microphone permission');
    final status = await Permission.microphone.request();
    voiceLog.info('Microphone permission status: ${status.name}');
    return status.isGranted;
  }

  /// Check if permission is permanently denied (user needs to go to settings).
  Future<bool> isPermissionPermanentlyDenied() async {
    final status = await Permission.microphone.status;
    return status.isPermanentlyDenied;
  }

  /// Initialize the speech recognition service.
  ///
  /// Returns true if initialization succeeds, false otherwise.
  Future<bool> _initialize() async {
    if (_initialized) return true;

    try {
      voiceLog.info('Initializing speech recognition');
      _initialized = await _speech.initialize(
        onError: (error) => voiceLog.severe('Speech error: ${error.errorMsg}'),
        onStatus: (status) => voiceLog.info('Speech status: $status'),
      );
      voiceLog.info('Speech recognition initialized: $_initialized');
      return _initialized;
    } catch (e) {
      voiceLog.severe('Failed to initialize speech recognition', e);
      return false;
    }
  }

  /// Start listening for speech input.
  ///
  /// [maxDuration]: Maximum recording duration (defaults to 30 seconds)
  /// [onResult]: Callback invoked with the transcribed text as the user speaks
  /// [onComplete]: Optional callback invoked when listening stops
  ///
  /// Returns true if listening started successfully, false otherwise.
  Future<bool> startListening({
    Duration maxDuration = const Duration(seconds: 30),
    required void Function(String text) onResult,
    void Function()? onComplete,
  }) async {
    try {
      // Ensure initialized
      if (!await _initialize()) {
        voiceLog.warning('Cannot start listening: initialization failed');
        return false;
      }

      if (!_speech.isAvailable) {
        voiceLog.warning('Cannot start listening: speech not available');
        return false;
      }

      voiceLog.info('Starting to listen (max duration: ${maxDuration.inSeconds}s)');

      await _speech.listen(
        onResult: (result) {
          voiceLog.info('Speech result: ${result.recognizedWords}');
          onResult(result.recognizedWords);
        },
        listenFor: maxDuration,
        pauseFor: const Duration(seconds: 5),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        ),
      );

      return true;
    } catch (e) {
      voiceLog.severe('Failed to start listening', e);
      return false;
    }
  }

  /// Stop listening for speech input.
  Future<void> stopListening() async {
    try {
      voiceLog.info('Stopping listening');
      await _speech.stop();
    } catch (e) {
      voiceLog.severe('Failed to stop listening', e);
    }
  }

  /// Check if currently listening.
  bool get isListening => _speech.isListening;

  /// Clean up resources.
  Future<void> dispose() async {
    await _speech.cancel();
  }
}
