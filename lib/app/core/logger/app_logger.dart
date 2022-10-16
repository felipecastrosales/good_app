abstract class AppLogger {
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void append(dynamic message);
  void closeAppend();
}
