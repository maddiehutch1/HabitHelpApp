class SessionModel {
  const SessionModel({
    required this.id,
    required this.cardId,
    required this.startedAt,
    required this.baseDurationSeconds,
    this.completedAt,
    this.extraTimeSeconds = 0,
  });

  final String id;
  final String cardId;
  final int startedAt;
  final int? completedAt;
  final int baseDurationSeconds;
  final int extraTimeSeconds;

  /// Total duration = base + extra time
  int get totalDurationSeconds => baseDurationSeconds + extraTimeSeconds;

  /// Whether the session was completed
  bool get isCompleted => completedAt != null;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'cardId': cardId,
      'startedAt': startedAt,
      'completedAt': completedAt,
      'baseDurationSeconds': baseDurationSeconds,
      'extraTimeSeconds': extraTimeSeconds,
    };
  }

  factory SessionModel.fromMap(Map<String, Object?> map) {
    return SessionModel(
      id: map['id'] as String,
      cardId: map['cardId'] as String,
      startedAt: map['startedAt'] as int,
      completedAt: map['completedAt'] as int?,
      baseDurationSeconds: map['baseDurationSeconds'] as int,
      extraTimeSeconds: map['extraTimeSeconds'] as int? ?? 0,
    );
  }
}
