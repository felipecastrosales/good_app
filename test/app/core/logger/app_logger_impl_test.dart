import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/logger/app_logger_impl.dart';

import '../../../fixtures/mocks/mock_app_logger.dart';

void main() async {
  late AppLogger appLoggerImpl;
  late MockAppLogger mockAppLogger;

  setUp(() {
    appLoggerImpl = AppLoggerImpl();
    mockAppLogger = MockAppLogger();
  });

  group('Should call in AppLoggerImpl the method', () {
    test('debug', () async {
      when(
        () => mockAppLogger.debug(any()),
      ).thenAnswer((_) async => true);
      void debug(message, [error, StackTrace? stackTrace]) =>
          appLoggerImpl.debug(message, error, stackTrace);
      final result = debug('debug message');
      expect(() => result, returnsNormally);
    });

    test('error', () async {
      when(
        () => mockAppLogger.error(any()),
      ).thenAnswer((_) async => true);
      void error(message, [error, StackTrace? stackTrace]) =>
          appLoggerImpl.error(message, error, stackTrace);
      final result = error('error message');
      expect(() => result, returnsNormally);
    });

    test('info', () async {
      when(
        () => mockAppLogger.info(any()),
      ).thenAnswer((_) async => true);
      void info(message, [error, StackTrace? stackTrace]) =>
          appLoggerImpl.info(message, error, stackTrace);
      final result = info('info message');
      expect(() => result, returnsNormally);
    });

    test('warning', () async {
      when(
        () => mockAppLogger.warning(any()),
      ).thenAnswer((_) async => true);
      void warning(message, [error, StackTrace? stackTrace]) =>
          appLoggerImpl.warning(message, error, stackTrace);
      final result = warning('warning message');
      expect(() => result, returnsNormally);
    });

    test('append', () async {
      when(
        () => mockAppLogger.append(any()),
      ).thenAnswer((_) async => true);
      void append(message) => appLoggerImpl.append(message);
      final result = append('append message');
      expect(() => result, returnsNormally);
    });

    test('closeAppend', () async {
      when(
        () => mockAppLogger.closeAppend(),
      ).thenAnswer((_) async => true);
      void closeAppend() => appLoggerImpl.closeAppend();
      final result = closeAppend();
      expect(() => result, returnsNormally);
    });
  });
}
