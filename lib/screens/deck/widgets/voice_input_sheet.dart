import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/app_logger.dart';
import '../../../services/voice_service.dart';
import '../../../theme.dart';

/// Bottom sheet for voice input recording and transcription.
///
/// Phase 5.1 (Manual card creation, no AI):
/// - Records up to 30 seconds of voice input
/// - Displays transcription in editable text area
/// - User manually creates cards from the transcription
class VoiceInputSheet extends StatefulWidget {
  const VoiceInputSheet({super.key});

  @override
  State<VoiceInputSheet> createState() => _VoiceInputSheetState();
}

class _VoiceInputSheetState extends State<VoiceInputSheet>
    with SingleTickerProviderStateMixin {
  final VoiceService _voiceService = VoiceService.instance;
  final TextEditingController _transcriptionController =
      TextEditingController();

  bool _isRecording = false;
  bool _hasRecorded = false;
  int _remainingSeconds = 30;
  Timer? _timer;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _requestPermissionAndStart();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _transcriptionController.dispose();
    if (_isRecording) {
      _voiceService.stopListening();
    }
    super.dispose();
  }

  Future<void> _requestPermissionAndStart() async {
    // Check if permission is already granted
    if (await _voiceService.hasPermission()) {
      _startRecording();
      return;
    }

    // Check if permanently denied
    if (await _voiceService.isPermissionPermanentlyDenied()) {
      _showPermissionDeniedDialog();
      return;
    }

    // Request permission
    final granted = await _voiceService.requestPermission();
    if (granted) {
      _startRecording();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Microphone Access Required',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'Voice input requires microphone access. Please grant permission in your device settings.',
          style: TextStyle(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Close the voice input sheet too
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final nav = Navigator.of(context);
              nav.pop();
              await openAppSettings();
              if (mounted) {
                nav.pop(); // Close the voice input sheet
              }
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {
    appLog.info('Starting voice recording');
    _pulseController.repeat(reverse: true);

    final success = await _voiceService.startListening(
      maxDuration: const Duration(seconds: 30),
      onResult: (text) {
        if (mounted) {
          setState(() {
            _transcriptionController.text = text;
          });
        }
      },
    );

    if (!success) {
      appLog.warning('Failed to start voice recording');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not start voice recording. Please try again.'),
          ),
        );
        Navigator.of(context).pop();
      }
      return;
    }

    setState(() {
      _isRecording = true;
      _remainingSeconds = 30;
    });

    // Start countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        _stopRecording();
      }
    });
  }

  Future<void> _stopRecording() async {
    appLog.info('Stopping voice recording');
    _timer?.cancel();
    _pulseController.stop();
    await _voiceService.stopListening();

    if (mounted) {
      setState(() {
        _isRecording = false;
        _hasRecorded = true;
      });
    }
  }

  void _discard() {
    Navigator.of(context).pop();
  }

  void _createCards() {
    // Phase 5.1: Return the transcription text for manual card creation
    // The parent screen will handle showing the add card flow
    Navigator.of(context).pop(_transcriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.md + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isRecording) _buildRecordingView(),
          if (_hasRecorded) _buildTranscriptionView(),
        ],
      ),
    );
  }

  Widget _buildRecordingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "What's on your mind today?",
          style: AppTextStyles.sheetTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          '(30 seconds)',
          style: AppTextStyles.bodyMuted,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        // Pulsing microphone icon
        Center(
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textPrimary.withValues(
                    alpha: 0.1 + (_pulseController.value * 0.15),
                  ),
                ),
                child: Icon(
                  Icons.mic,
                  size: 60,
                  color: AppColors.textPrimary.withValues(
                    alpha: 0.6 + (_pulseController.value * 0.4),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '$_remainingSeconds s remaining',
          style: AppTextStyles.label.copyWith(
            fontSize: 14,
            color: AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _stopRecording,
            child: const Text('Stop'),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
      ],
    );
  }

  Widget _buildTranscriptionView() {
    final hasText = _transcriptionController.text.trim().isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Your transcription', style: AppTextStyles.sheetTitle),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _transcriptionController,
          maxLines: 8,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hasText ? null : 'Your transcription will appear here...',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textPrimary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: _discard,
                child: const Text('Discard'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: hasText ? _createCards : null,
                child: const Text('Create cards from this'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
      ],
    );
  }
}
