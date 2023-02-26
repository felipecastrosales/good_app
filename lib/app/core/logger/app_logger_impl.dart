import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'app_logger.dart';

@Injectable(as: AppLogger)
class AppLoggerImpl implements AppLogger {
  AppLoggerImpl({
    required Logger logger,
  }) : _logger = logger;

  final Logger _logger;
  var messages = <String>[];

  @override
  void debug(message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  @override
  void error(message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  @override
  void info(message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  @override
  void warning(message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);

  @override
  void append(message) {
    messages.add(message);
  }

  @override
  void closeAppend() {
    info(messages.join('\n'));
    messages = [];
  }
}
