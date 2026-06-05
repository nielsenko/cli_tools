/// A cli_tools `Logger` bridge for the serverpod_logging architecture.
///
/// This package sits on top of `serverpod_logging` (the dependency-free core)
/// and `cli_tools` (the CLI toolkit), wiring the two together. Keeping it in
/// its own package means the logging core never takes on the cli_tools
/// dependency, and the cli_tools toolkit never learns about serverpod.
library;

export 'src/serverpod_cli_logger.dart';
export 'src/std_out_log_writer.dart';
