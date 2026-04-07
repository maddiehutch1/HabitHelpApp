import '../../services/app_logger.dart';
import '../database.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  Future<void> insertSchedule(ScheduleModel schedule) async {
    final db = await getDatabase();
    await db.insert('schedules', schedule.toMap());
    scheduleRepoLog.info(
      'insertSchedule — id=${schedule.id} cardId=${schedule.cardId}',
    );
  }

  Future<List<ScheduleModel>> getAllActiveSchedules() async {
    final db = await getDatabase();
    final rows = await db.query('schedules', where: 'isActive = 1');
    final schedules = rows.map(ScheduleModel.fromMap).toList();
    scheduleRepoLog.fine('getAllActiveSchedules — ${schedules.length} rows');
    return schedules;
  }

  Future<List<ScheduleModel>> getSchedulesForCard(String cardId) async {
    final db = await getDatabase();
    final rows = await db.query(
      'schedules',
      where: 'cardId = ?',
      whereArgs: [cardId],
    );
    final schedules = rows.map(ScheduleModel.fromMap).toList();
    scheduleRepoLog.fine(
      'getSchedulesForCard — cardId=$cardId found=${schedules.length}',
    );
    return schedules;
  }

  Future<void> deleteSchedule(String id) async {
    final db = await getDatabase();
    await db.delete('schedules', where: 'id = ?', whereArgs: [id]);
    scheduleRepoLog.info('deleteSchedule — id=$id');
  }

  Future<void> updateScheduleActive(String id, {required bool isActive}) async {
    final db = await getDatabase();
    await db.update(
      'schedules',
      {'isActive': isActive ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
    scheduleRepoLog.info('updateScheduleActive — id=$id isActive=$isActive');
  }
}
