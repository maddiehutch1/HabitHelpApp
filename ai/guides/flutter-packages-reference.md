# Flutter Packages Reference — Micro-Deck MVP
*Fetched live from pub.dev and api.flutter.dev — February 2026*
*Use these verified versions and APIs during implementation. Do not guess.*

---

## 1. HapticFeedback (Flutter SDK built-in)
**Source:** `flutter/services` — no package install needed
**Import:** `import 'package:flutter/services.dart';`

### Verified static methods (all return `Future<void>`):
```dart
HapticFeedback.lightImpact()        // light collision feel
HapticFeedback.mediumImpact()       // medium collision feel  ← use for Silent Pulse
HapticFeedback.heavyImpact()        // heavy collision feel
HapticFeedback.selectionClick()     // discrete selection change
HapticFeedback.successNotification() // task completed successfully ← also consider this
HapticFeedback.errorNotification()  // task failed
HapticFeedback.warningNotification() // warning
HapticFeedback.vibrate()            // short vibration
```

**Decision for MVP:** Use `HapticFeedback.mediumImpact()` or `HapticFeedback.successNotification()` for timer completion. Test both on device — `successNotification()` may feel more semantically correct for "you started."

**Note:** No external package needed. This is zero-dependency.

---

## 2. wakelock_plus `^1.4.0`
**Publisher:** fluttercommunity.dev
**Platforms:** Android ✅ iOS ✅ (also Linux, macOS, Windows, Web)
**Install:** `flutter pub add wakelock_plus`
**Import:** `import 'package:wakelock_plus/wakelock_plus.dart';`

### Verified API:
```dart
// Enable — keep screen on
WakelockPlus.enable();

// Disable — let screen sleep normally
WakelockPlus.disable();

// Toggle with bool
WakelockPlus.toggle(enable: true);

// Check current state
bool isEnabled = await WakelockPlus.enabled;
```

### Usage pattern for timer screen:
```dart
// In timer widget initState or when timer starts:
WakelockPlus.enable();

// When timer completes or user exits:
WakelockPlus.disable();
```

### Important notes:
- Call `WidgetsFlutterBinding.ensureInitialized()` in `main()` before any wakelock calls
- Enable/disable per-widget, not globally in `main()` — OS can release the wakelock externally
- No special permissions required on any platform
- Requires Flutter SDK >= 3.22.0, Dart SDK >= 3.4.0

---

## 3. shared_preferences `^2.5.4`
**Publisher:** flutter.dev (official Flutter team)
**Platforms:** Android ✅ iOS ✅ (also Linux, macOS, Windows, Web)
**Install:** `flutter pub add shared_preferences`
**Import:** `import 'package:shared_preferences/shared_preferences.dart';`

### Use for MVP: `SharedPreferencesAsync` (preferred new API as of 2.3.0)
The legacy `SharedPreferences.getInstance()` is being deprecated. Use the async API for new code.

```dart
final prefs = SharedPreferencesAsync();

// Write
await prefs.setString('key', 'value');
await prefs.setBool('hasCompletedOnboarding', true);

// Read
final String? value = await prefs.getString('key');
final bool? done = await prefs.getBool('hasCompletedOnboarding');

// Remove
await prefs.remove('key');
```

### What to store in shared_preferences for MVP:
- `hasCompletedOnboarding` (bool) — controls Welcome screen display
- Simple flags only — NOT card data (use sqflite for structured data)

### Storage location:
- iOS: NSUserDefaults
- Android: DataStore Preferences (default) or SharedPreferences

---

## 4. sqflite `^2.4.2`
**Publisher:** tekartik.com
**Platforms:** Android ✅ iOS ✅ macOS ✅
**Install:** `flutter pub add sqflite` (also add `path`: `flutter pub add path`)
**Import:** `import 'package:sqflite/sqflite.dart'; import 'package:path/path.dart';`

### Opening a database:
```dart
final databasesPath = await getDatabasesPath();
final path = join(databasesPath, 'microdeck.db');

final db = await openDatabase(
  path,
  version: 1,
  onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE cards (
        id TEXT PRIMARY KEY,
        goalLabel TEXT,
        actionLabel TEXT NOT NULL,
        durationSeconds INTEGER NOT NULL DEFAULT 120,
        sortOrder INTEGER NOT NULL DEFAULT 0,
        createdAt INTEGER NOT NULL
      )
    ''');
  },
);
```

### CRUD operations:
```dart
// Insert
await db.insert('cards', {
  'id': uuid,
  'goalLabel': 'Run more often',
  'actionLabel': 'Put on running shoes',
  'durationSeconds': 120,
  'sortOrder': 0,
  'createdAt': DateTime.now().millisecondsSinceEpoch,
});

// Query all
final List<Map<String, Object?>> rows = await db.query(
  'cards',
  orderBy: 'sortOrder ASC, createdAt ASC',
);

// Update
await db.update(
  'cards',
  {'actionLabel': 'New label'},
  where: 'id = ?',
  whereArgs: [cardId],
);

// Delete
await db.delete('cards', where: 'id = ?', whereArgs: [cardId]);
```

### Important notes:
- `DateTime` is NOT a SQLite type — store as `INTEGER` (millisecondsSinceEpoch) ← critical
- `bool` is NOT a SQLite type — store as `INTEGER` (0 or 1)
- DB operations run in a background thread on iOS and Android automatically
- Query results are read-only maps — copy before modifying:
  ```dart
  final mutable = Map<String, Object?>.from(row);
  ```
- Do NOT use the database object inside a transaction — use the `txn` object only

---

## 5. flutter_riverpod `^3.2.1`
**Publisher:** dash-overflow.net (Remi Rousselet)
**Install:** `flutter pub add flutter_riverpod`
**Import:** `import 'package:flutter_riverpod/flutter_riverpod.dart';`
**Full docs:** https://riverpod.dev

### Wrap app in ProviderScope:
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MicroDeckApp()));
}
```

### Define a provider (no codegen — MVP pattern):
```dart
// Notifier provider — no build_runner, no @riverpod annotation
class CardsNotifier extends Notifier<List<CardModel>> {
  @override
  List<CardModel> build() => [];

  Future<void> loadCards() async {
    // load from sqflite, then:
    state = loadedCards;
  }

  Future<void> addCard(CardModel card) async {
    // insert into sqflite, then reload
    await loadCards();
  }

  Future<void> deleteCard(String id) async {
    // delete from sqflite, then reload
    await loadCards();
  }
}

final cardsProvider = NotifierProvider<CardsNotifier, List<CardModel>>(
  CardsNotifier.new,
);
```

### Consume in a widget:
```dart
// Use ConsumerWidget instead of StatelessWidget
class DeckView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardsProvider);
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, i) => CardTile(card: cards[i]),
    );
  }
}

// Use ConsumerStatefulWidget when local state + providers are both needed (e.g. timer)
class TimerScreen extends ConsumerStatefulWidget { /* ... */ }
```

### Notes:
- **Do not use `@riverpod` codegen or `build_runner` in MVP** — `NotifierProvider` without codegen is sufficient and simpler
- Version 3.x supports both codegen (`@riverpod`) and manual (`NotifierProvider`) — use manual for this project
- Full docs at https://riverpod.dev — always check there for current patterns

---

## MVP pubspec.yaml dependencies (verified versions)

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.5.4   # onboarding flag storage
  sqflite: ^2.4.2              # card data storage
  path: ^1.9.0                 # required by sqflite for db path
  wakelock_plus: ^1.4.0        # keep screen on during timer
  flutter_riverpod: ^3.2.1     # state management

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

---

## What we are NOT using (and why)

| Package | Why not |
|---|---|
| `flutter_local_notifications` | Not in MVP — scheduling is post-demo |
| `drift` | Overkill for MVP — sqflite is sufficient |
| `go_router` | Overkill for MVP — Navigator 1.0 is fine for 5 screens |
| `uuid` | Use `DateTime.now().millisecondsSinceEpoch.toString()` for IDs in MVP |
| Any analytics SDK | Explicitly excluded — no telemetry in this product |
