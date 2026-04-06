import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../data/database.dart';
import '../../data/models/card_model.dart';
import '../../data/models/session_model.dart';
import '../../routes.dart';
import '../../theme.dart';
import '../deck/deck_screen.dart';
import 'celebration_screen.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.card});

  final CardModel card;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late int _secondsRemaining;
  Timer? _ticker;
  Timer? _fadeTimer;
  bool _isRunning = true;
  bool _isCompleting = false;
  late final String _sessionId;
  late final int _startedAt;

  // Pulse dot animation
  late final AnimationController _pulseController;
  late final Animation<double> _pulseOpacity;

  // Timer digit fade animation (1.0 → 0.1 after 5s, back to 1.0 at 10s remaining)
  late final AnimationController _timerOpacityController;
  late final Animation<double> _timerOpacity;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.card.durationSeconds;
    _sessionId = const Uuid().v4();
    _startedAt = DateTime.now().millisecondsSinceEpoch;

    WakelockPlus.enable();
    WidgetsBinding.instance.addObserver(this);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseOpacity = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _timerOpacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _timerOpacity = Tween<double>(begin: 1.0, end: 0.1).animate(
      CurvedAnimation(parent: _timerOpacityController, curve: Curves.easeInOut),
    );

    _startTicker();
    _scheduleFade();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _fadeTimer?.cancel();
    _pulseController.dispose();
    _timerOpacityController.dispose();
    WakelockPlus.disable();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) _pause();
  }

  /// Schedules the 5-second delayed fade to 10% opacity.
  void _scheduleFade() {
    _fadeTimer?.cancel();
    _fadeTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && _isRunning) {
        _timerOpacityController.forward();
      }
    });
  }

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          // Snap back to full opacity at 10s remaining
          if (_secondsRemaining <= 10) {
            _timerOpacityController.reverse();
          }
        } else {
          _ticker?.cancel();
          _isRunning = false;
          _handleComplete();
        }
      });
    });
  }

  void _pause() {
    _fadeTimer?.cancel();
    _ticker?.cancel();
    _timerOpacityController.reverse(); // Reset to full opacity while paused
    _pulseController.stop();
    if (mounted) setState(() => _isRunning = false);
  }

  void _resume() {
    _pulseController.repeat(reverse: true);
    setState(() => _isRunning = true);
    _startTicker();
    _scheduleFade(); // Fresh 5s delay on resume
  }

  void _togglePause() {
    if (_isRunning) {
      _pause();
    } else {
      _resume();
    }
  }

  int get _elapsedSeconds =>
      widget.card.durationSeconds - _secondsRemaining;

  Future<void> _handleExitEarly() async {
    _fadeTimer?.cancel();
    _ticker?.cancel();
    final elapsed = _elapsedSeconds;
    await _saveSession(isPartial: true, elapsedSeconds: elapsed);
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushAndRemoveUntil(fadeRoute(const DeckScreen()), (route) => false);
  }

  Future<void> _handleComplete() async {
    if (_isCompleting) return;
    _isCompleting = true;
    _fadeTimer?.cancel();
    _ticker?.cancel();
    _pulseController.stop();

    final elapsed = _elapsedSeconds;
    await _saveSession(isPartial: false, elapsedSeconds: elapsed);

    await HapticFeedback.mediumImpact();

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      fadeRoute(
        CelebrationScreen(
          card: widget.card,
          elapsedSeconds: elapsed,
          extraTimeSeconds: 0,
        ),
      ),
      (route) => false,
    );
  }

  Future<void> _saveSession({
    required bool isPartial,
    required int elapsedSeconds,
  }) async {
    try {
      final db = await getDatabase();
      final session = SessionModel(
        id: _sessionId,
        cardId: widget.card.id,
        startedAt: _startedAt,
        completedAt: _startedAt + (elapsedSeconds * 1000),
        baseDurationSeconds: widget.card.durationSeconds,
        extraTimeSeconds: 0,
        isPartial: isPartial,
      );
      await db.insert('sessions', session.toMap());
    } catch (_) {
      // Silently fail — session loss is non-critical
    }
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Buttons are the only exits
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _buildTimerBody()),
              _buildActionButtons(),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerBody() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              widget.card.actionLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.timerLabel,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            label: 'Time remaining: ${_formatTime(_secondsRemaining)}',
            child: AnimatedBuilder(
              animation: _timerOpacity,
              builder: (context, child) => Opacity(
                opacity: _timerOpacity.value,
                child: child,
              ),
              child: Text(
                _formatTime(_secondsRemaining),
                style: AppTextStyles.timerDisplay,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Pulse dot + pause button — thematically paired
          Column(
            children: [
              FadeTransition(
                opacity: _pulseOpacity,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: _togglePause,
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow, size: 18),
                label: Text(_isRunning ? 'Pause' : 'Resume'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textMuted,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    const buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    const buttonTextStyle = AppTextStyles.button;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Exit Early
          OutlinedButton(
            onPressed: _handleExitEarly,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textMuted,
              side: const BorderSide(color: AppColors.border),
              padding: buttonPadding,
              textStyle: buttonTextStyle,
            ),
            child: const Text('Exit Early'),
          ),
          // Complete
          FilledButton.icon(
            onPressed: _isCompleting ? null : _handleComplete,
            style: FilledButton.styleFrom(
              padding: buttonPadding,
              textStyle: buttonTextStyle,
            ),
            icon: const Icon(Icons.check),
            label: const Text('Complete'),
          ),
        ],
      ),
    );
  }
}

