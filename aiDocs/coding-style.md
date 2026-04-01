## Code Style

- Keep files small and single-responsibility. One screen per file.
- Use named loggers from `lib/services/app_logger.dart` — `appLog`, `cardRepoLog`, `scheduleRepoLog`, `notificationLog`, `voiceLog`. Log all non-trivial state changes and CRUD operations.
- No raw `debugPrint` or `print` in app code (the `setupLogging()` sink handles output).
- `flutter analyze` must pass clean before considering any task done.
- No over-engineering, no premature abstractions, no legacy-compatibility shims.
- Avoid adding dependencies unless necessary — check `aiDocs/architecture.md` first.