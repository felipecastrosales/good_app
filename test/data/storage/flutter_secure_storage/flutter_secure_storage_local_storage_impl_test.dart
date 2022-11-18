import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/data/data.dart';

import '../../../fixtures/fixtures.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'deleteAll') {
      return true;
    }
    return null;
  });

  late LocalSecureStorage localSecureStorageImpl;
  late MockLocalSecureStorage mockLocalSecureStorage;

  setUp(() {
    localSecureStorageImpl = FlutterSecureStorageLocalStorageImpl();
    mockLocalSecureStorage = MockLocalSecureStorage();
  });

  test('should call clear method from LocalSecureStorage', () async {
    // arrange
    when(() => mockLocalSecureStorage.clear()).thenAnswer((_) async => true);
    // act
    final result = await localSecureStorageImpl.clear();
    // assert
    expect(() => result, returnsNormally);
    verify(() => mockLocalSecureStorage.clear()).called(1);
  });

  group('Should call on FlutterSecureStorageLocalStorageImpl', () {
    test('clear', () async {
      await localSecureStorageImpl.clear();
      verify(() => mockLocalSecureStorage.clear()).called(1);
    });

    test('contains', () async {
      await localSecureStorageImpl.contains('key');
      verify(() => mockLocalSecureStorage.contains('key')).called(1);
    });

    test('read', () async {
      await localSecureStorageImpl.read('key');
      verify(() => mockLocalSecureStorage.read('key')).called(1);
    });

    test('remove', () async {
      await localSecureStorageImpl.remove('key');
      verify(() => mockLocalSecureStorage.remove('key')).called(1);
    });

    test('write', () async {
      await localSecureStorageImpl.write('key', 'value');
      verify(() => mockLocalSecureStorage.write('key', 'value')).called(1);
    });
  });
}
