import 'package:isolated_object/isolated_object.dart';

import 'log_types.dart';

/// A [LogWriter] that runs a wrapped writer on a dedicated isolate.
///
/// Not a high-throughput sink. Every operation is copied across the isolate
/// boundary, so payloads must be sendable.
class IsolatedLogWriter extends IsolatedObject<LogWriter> implements LogWriter {
  /// Creates an [IsolatedLogWriter] that runs the writer produced by
  /// [factory] on a dedicated isolate.
  IsolatedLogWriter(super.factory);

  @override
  Future<void> log(LogEntry entry) async {
    try {
      await evaluate((w) => w.log(entry));
    } catch (_) {} // best effort
  }

  @override
  Future<void> openScope(LogScope scope) => evaluate((w) => w.openScope(scope));

  @override
  Future<void> closeScope(
    LogScope scope, {
    required bool success,
    required Duration duration,
    Object? error,
    StackTrace? stackTrace,
  }) async {
    await evaluate(
      (w) => w.closeScope(
        scope,
        success: success,
        duration: duration,
        error: error,
        stackTrace: stackTrace,
      ),
    );
  }
}
