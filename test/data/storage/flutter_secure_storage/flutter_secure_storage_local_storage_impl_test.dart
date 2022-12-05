import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/data/storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:good_app/data/storage/local_secure_storage.dart';

import '../../../fixtures/mocks/mock_local_secure_storage.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  late LocalSecureStorage localSecureStorageImpl;
  late MockLocalSecureStorage mockLocalSecureStorage;

  setUp(() {
    localSecureStorageImpl = FlutterSecureStorageLocalStorageImpl();
    mockLocalSecureStorage = MockLocalSecureStorage();
  });

  group('Should call in FlutterSecureStorageLocalStorageImpl the method', () {
    test('clear', () async {
      when(() => mockLocalSecureStorage.clear()).thenAnswer((_) async => true);
      final result = await localSecureStorageImpl.clear();
      expect(() => result, returnsNormally);
    });

    test('contains', () async {
      when(
        () => mockLocalSecureStorage.contains(any()),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorageImpl.contains('key');
      expect(() => result, returnsNormally);
    });

    test('read', () async {
      when(
        () => mockLocalSecureStorage.read(any()),
      ).thenAnswer((_) async => 'value');
      final result = await localSecureStorageImpl.read('key');
      expect(() => result, returnsNormally);
    });

    test('remove', () async {
      when(
        () => mockLocalSecureStorage.remove(any()),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorageImpl.remove('key');
      expect(() => result, returnsNormally);
    });

    test('write', () async {
      when(
        () => mockLocalSecureStorage.write(any(), any()),
      ).thenAnswer((_) async => true);
      final result = await localSecureStorageImpl.write('key', 'value');
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
