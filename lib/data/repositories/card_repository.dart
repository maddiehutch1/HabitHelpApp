import '../../services/app_logger.dart';
import '../database.dart';
import '../models/card_model.dart';

class CardRepository {
  Future<void> insertCard(CardModel card) async {
    final db = await getDatabase();
    await db.insert('cards', card.toMap());
    cardRepoLog.info('insertCard id=${card.id} action="${card.actionLabel}"');
  }

  Future<List<CardModel>> getAllCards() async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      where: 'isArchived = 0 AND archivedDate IS NULL',
      orderBy: 'sortOrder ASC, createdAt ASC',
    );
    final cards = rows.map(CardModel.fromMap).toList();
    cardRepoLog.fine('getAllCards → ${cards.length} active cards');
    return cards;
  }

  Future<List<CardModel>> getAllArchivedCards() async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      where: 'isArchived = 1',
      orderBy: 'createdAt DESC',
    );
    final cards = rows.map(CardModel.fromMap).toList();
    cardRepoLog.fine('getAllArchivedCards → ${cards.length} archived cards');
    return cards;
  }

  /// Returns cards with archivedDate set (for Fresh Start mode Past Days screen)
  Future<List<CardModel>> getArchivedByDate() async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      where: 'archivedDate IS NOT NULL',
      orderBy: 'archivedDate DESC',
    );
    final cards = rows.map(CardModel.fromMap).toList();
    cardRepoLog.fine(
      'getArchivedByDate → ${cards.length} cards with archivedDate',
    );
    return cards;
  }

  /// Moves a card from past days back to today's deck (for Fresh Start mode)
  Future<void> moveToToday(String id) async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      columns: ['sortOrder'],
      where: 'archivedDate IS NULL',
      orderBy: 'sortOrder DESC',
      limit: 1,
    );
    final maxSort = rows.isEmpty ? 0 : (rows.first['sortOrder'] as int) + 1;
    await db.update(
      'cards',
      {'archivedDate': null, 'sortOrder': maxSort},
      where: 'id = ?',
      whereArgs: [id],
    );
    cardRepoLog.info(
      'moveToToday id=$id → archivedDate=null, sortOrder=$maxSort',
    );
  }

  Future<void> deleteCard(String id) async {
    final db = await getDatabase();
    await db.delete('cards', where: 'id = ?', whereArgs: [id]);
    await db.delete('deferrals', where: 'cardId = ?', whereArgs: [id]);
    await db.delete('schedules', where: 'cardId = ?', whereArgs: [id]);
    cardRepoLog.info(
      'deleteCard id=$id (card + deferrals + schedules removed)',
    );
  }

  Future<void> archiveCard(String id) async {
    final db = await getDatabase();
    await db.update(
      'cards',
      {'isArchived': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    cardRepoLog.info('archiveCard id=$id → isArchived=1');
  }

  Future<void> restoreCard(String id) async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      columns: ['sortOrder'],
      where: 'isArchived = 0',
      orderBy: 'sortOrder DESC',
      limit: 1,
    );
    final maxSort = rows.isEmpty ? 0 : (rows.first['sortOrder'] as int) + 1;
    await db.update(
      'cards',
      {'isArchived': 0, 'sortOrder': maxSort},
      where: 'id = ?',
      whereArgs: [id],
    );
    cardRepoLog.info('restoreCard id=$id → sortOrder=$maxSort');
  }

  /// Moves card to bottom of deck and records a deferral.
  Future<void> deferCard(String id) async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      columns: ['sortOrder'],
      where: 'isArchived = 0',
      orderBy: 'sortOrder DESC',
      limit: 1,
    );
    final maxSort = rows.isEmpty ? 0 : (rows.first['sortOrder'] as int) + 1;
    await db.update(
      'cards',
      {'sortOrder': maxSort},
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.insert('deferrals', {
      'cardId': id,
      'deferredAt': DateTime.now().millisecondsSinceEpoch,
    });
    cardRepoLog.info(
      'deferCard id=$id → moved to sortOrder=$maxSort, deferral recorded',
    );
  }

  /// Returns deferral count for a card in the past [withinMs] milliseconds.
  Future<int> getDeferralCount(String cardId, int withinMs) async {
    final db = await getDatabase();
    final since = DateTime.now().millisecondsSinceEpoch - withinMs;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM deferrals WHERE cardId = ? AND deferredAt >= ?',
      [cardId, since],
    );
    return (result.first['count'] as int? ?? 0);
  }

  /// Marks a card as completed by setting completedAt and isArchived.
  Future<void> completeCard(String id) async {
    final db = await getDatabase();
    final now = DateTime.now().millisecondsSinceEpoch;
    await db.update(
      'cards',
      {'completedAt': now, 'isArchived': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    cardRepoLog.info('completeCard id=$id → completedAt=$now, isArchived=1');
  }

  /// Returns cards that have been explicitly completed (completedAt IS NOT NULL).
  Future<List<CardModel>> getCompletedCards() async {
    final db = await getDatabase();
    final rows = await db.query(
      'cards',
      where: 'completedAt IS NOT NULL',
      orderBy: 'completedAt DESC',
    );
    final cards = rows.map(CardModel.fromMap).toList();
    cardRepoLog.fine('getCompletedCards → ${cards.length} completed cards');
    return cards;
  }

  /// Updates a card's goal and/or action labels.
  Future<void> updateCard(
    String id, {
    String? goalLabel,
    String? actionLabel,
  }) async {
    final db = await getDatabase();
    final updates = <String, Object?>{};
    if (goalLabel != null) updates['goalLabel'] = goalLabel;
    if (actionLabel != null) updates['actionLabel'] = actionLabel;
    if (updates.isEmpty) return;
    await db.update('cards', updates, where: 'id = ?', whereArgs: [id]);
    cardRepoLog.info('updateCard id=$id updates=$updates');
  }

  /// Returns goal labels that have sessions completed in the last [days] days.
  Future<Set<String>> getGoalLabelsWithRecentSessions({int days = 7}) async {
    final db = await getDatabase();
    final since =
        DateTime.now().millisecondsSinceEpoch - (days * 24 * 60 * 60 * 1000);
    final rows = await db.rawQuery(
      '''
      SELECT DISTINCT c.goalLabel FROM cards c
      INNER JOIN sessions s ON c.id = s.cardId
      WHERE s.completedAt >= ? AND c.goalLabel IS NOT NULL AND c.goalLabel != ''
    ''',
      [since],
    );
    final labels = rows
        .map((r) => r['goalLabel'] as String?)
        .where((l) => l != null && l.isNotEmpty)
        .cast<String>()
        .toSet();
    cardRepoLog.fine(
      'getGoalLabelsWithRecentSessions(days=$days) → ${labels.length} labels',
    );
    return labels;
  }

  Future<int> getActiveCardCount() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM cards WHERE isArchived = 0',
    );
    return (result.first['count'] as int? ?? 0);
  }

  /// Returns count of cards with archivedDate set (for Fresh Start mode badge)
  Future<int> getArchivedCardCount() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM cards WHERE archivedDate IS NOT NULL',
    );
    final count = result.first['count'] as int? ?? 0;
    cardRepoLog.fine('getArchivedCardCount → $count cards');
    return count;
  }

  /// Archives all active cards with the given archivedDate (for Fresh Start mode daily rollover)
  Future<void> archiveAllActiveCards(int archivedDate) async {
    final db = await getDatabase();
    await db.update('cards', {
      'archivedDate': archivedDate,
    }, where: 'archivedDate IS NULL');
    cardRepoLog.info(
      'archiveAllActiveCards → all active cards archived with date=$archivedDate',
    );
  }
}
