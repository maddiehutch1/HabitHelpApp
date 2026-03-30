import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:micro_deck/screens/create_card/create_card_goal_screen.dart';
import 'package:micro_deck/screens/create_card/create_card_action_screen.dart';

Widget _wrap(Widget child) => ProviderScope(child: MaterialApp(home: child));

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('CreateCardGoalScreen', () {
    testWidgets('renders goal prompt text', (tester) async {
      await tester.pumpWidget(_wrap(const CreateCardGoalScreen()));
      expect(find.textContaining('big and difficult'), findsOneWidget);
    });

    testWidgets('Next button is disabled when text field is empty', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const CreateCardGoalScreen()));
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Next button enables after typing in goal field', (
      tester,
    ) async {
      await tester.pumpWidget(_wrap(const CreateCardGoalScreen()));
      await tester.enterText(find.byType(TextField), 'Run more often');
      await tester.pump();

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('text field accepts input', (tester) async {
      await tester.pumpWidget(_wrap(const CreateCardGoalScreen()));
      await tester.enterText(find.byType(TextField), 'Sleep better');
      await tester.pump();
      expect(find.text('Sleep better'), findsOneWidget);
    });
  });

  group('CreateCardActionScreen', () {
    testWidgets('renders action prompt text', (tester) async {
      await tester.pumpWidget(
        _wrap(const CreateCardActionScreen(goal: 'Run more often')),
      );
      expect(find.textContaining('tiny'), findsOneWidget);
    });

    testWidgets('shows goal label as context', (tester) async {
      await tester.pumpWidget(
        _wrap(const CreateCardActionScreen(goal: 'Run more often')),
      );
      expect(find.text('Run more often'), findsOneWidget);
    });

    testWidgets('primary button is disabled when action field is empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(const CreateCardActionScreen(goal: 'Run more often')),
      );
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('primary button enables after typing action', (tester) async {
      await tester.pumpWidget(
        _wrap(const CreateCardActionScreen(goal: 'Run more often')),
      );
      await tester.enterText(find.byType(TextField), 'Put on my running shoes');
      await tester.pump();

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });
  });
}
