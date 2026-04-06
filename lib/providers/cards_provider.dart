import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/card_model.dart';
import '../data/repositories/card_repository.dart';

class CardsNotifier extends Notifier<List<CardModel>> {
  final _repo = CardRepository();

  @override
  List<CardModel> build() => [];

  Future<void> loadCards() async {
    state = await _repo.getAllCards();
  }

  Future<void> addCard(CardModel card) async {
    await _repo.insertCard(card);
    await loadCards();
  }

  Future<void> deleteCard(String id) async {
    await _repo.deleteCard(id);
    await loadCards();
  }

  Future<void> deferCard(String id) async {
    // Remove optimistically so Dismissible doesn't find the item still in tree
    state = state.where((c) => c.id != id).toList();
    await _repo.deferCard(id);
    await loadCards();
  }

  Future<void> archiveCard(String id) async {
    state = state.where((c) => c.id != id).toList();
    await _repo.archiveCard(id);
    await loadCards();
  }

  Future<void> completeCard(String id) async {
    state = state.where((c) => c.id != id).toList();
    await _repo.completeCard(id);
    await loadCards();
  }

  Future<List<CardModel>> getCompletedCards() async {
    return _repo.getCompletedCards();
  }

  Future<void> updateCard(
    String id, {
    String? goalLabel,
    String? actionLabel,
  }) async {
    await _repo.updateCard(id, goalLabel: goalLabel, actionLabel: actionLabel);
    await loadCards();
  }

  Future<Set<String>> getGoalLabelsWithRecentSessions({int days = 7}) async {
    return _repo.getGoalLabelsWithRecentSessions(days: days);
  }

  Future<void> restoreCard(String id) async {
    await _repo.restoreCard(id);
    await loadCards();
  }

  Future<int> getActiveCardCount() async {
    return _repo.getActiveCardCount();
  }

  Future<int> getArchivedCardCount() async {
    return _repo.getArchivedCardCount();
  }

  Future<void> archiveAllActiveCards(int archivedDate) async {
    await _repo.archiveAllActiveCards(archivedDate);
    await loadCards();
  }
}

final cardsProvider = NotifierProvider<CardsNotifier, List<CardModel>>(
  CardsNotifier.new,
);
