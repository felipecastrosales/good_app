import 'package:flutter_test/flutter_test.dart';

import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';

import '../../../fixtures/mocks/mock_app_logger.dart';

void main() async {
  late MockLogger logger;
  late AppLogger appLogger;

  setUp(() {
    logger = MockLogger();
    appLogger = AppLoggerImpl(logger: logger);
  });

  group('Should call in AppLogger the method', () {
    test('debug', () async {
      final result = appLogger.debug('debug message');
      expect(() => result, returnsNormally);
    });

    test('error', () async {
      final result = appLogger.error('error message');
      expect(() => result, returnsNormally);
    });

    test('info', () async {
      final result = appLogger.info('info message');
      expect(() => result, returnsNormally);
    });

    test('warning', () async {
      final result = appLogger.warning('warning message');
      expect(() => result, returnsNormally);
    });

    test('append', () async {
      final result = appLogger.append('append message');
      expect(() => result, returnsNormally);
    });

    test('closeAppend', () async {
      final result = appLogger.closeAppend();
      expect(() => result, returnsNormally);
    });
  });
}
