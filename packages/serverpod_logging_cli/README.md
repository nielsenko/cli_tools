# serverpod_logging_cli

A [`cli_tools`](https://pub.dev/packages/cli_tools) `Logger` implementation
backed by the [`serverpod_logging`](https://pub.dev/packages/serverpod_logging)
`LogWriter` architecture. It renders scoped logs and progress to the terminal
while letting output fan out to any number of backends (terminal, file,
database, …) via `LogWriter` / `MultiLogWriter`.

## Usage

```dart
import 'package:serverpod_logging_cli/serverpod_logging_cli.dart';

final logger = ServerpodCliLogger(StdOutLogWriter());

logger.info('Server starting');
await logger.progress('Migrating', () async => true);

await logger.flush();
```

`progressStream` is modelled as a parent operation with one nested
sub-operation per stream event - each a real, independently-timed scope - so
the structure stays meaningful for non-terminal writers (a database writer
records the parent span plus a child span per event).
