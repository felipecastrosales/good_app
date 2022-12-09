import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/data/storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:good_app/data/storage/local_secure_storage.dart';

import '../../../fixtures/mocks/mock_flutter_secure_storage.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late LocalSecureStorage localSecureStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    localSecureStorage = FlutterSecureStorageLocalStorageImpl(
      instance: mockFlutterSecureStorage,
    );
  });

  group('Should call in FlutterSecureStorageLocalStorageImpl the method', () {
    test('clear', () async {
      when(() => localSecureStorage.clear()).thenAnswer((_) async => true);
      final result = await localSecureStorage.clear();
      expect(() => result, returnsNormally);
    });

    test('contains', () async {
      when(
        () => localSecureStorage.contains(any(named: 'key')),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorage.contains('key');
      expect(() => result, returnsNormally);
    });

    test('read', () async {
      when(
        () => localSecureStorage.read(any(named: 'key')),
      ).thenAnswer((_) async => 'value');
      final result = await localSecureStorage.read('key');
      expect(() => result, returnsNormally);
    });

    test('remove', () async {
      when(
        () => localSecureStorage.remove(any(named: 'key')),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorage.remove('key');
      expect(() => result, returnsNormally);
    });

    test('write', () async {
      when(
        () => localSecureStorage.write(
          any(named: 'key'),
          any(named: 'value'),
        ),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorage.write('key', 'value');
      expect(() => result, returnsNormally);
    });
  });

  const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'clear') {
      return true;
    } else if (methodCall.method == 'containsKey') {
      return true;
    } else if (methodCall.method == 'read') {
      return 'value';
    } else if (methodCall.method == 'write') {
      return true;
    } else if (methodCall.method == 'remove') {
      return true;
    } else if (methodCall.method == 'write') {
      return true;
    }
    return null;
  });
}
