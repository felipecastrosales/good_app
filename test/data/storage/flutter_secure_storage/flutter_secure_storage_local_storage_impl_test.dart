import 'package:flutter_test/flutter_test.dart';

import 'package:good_app/data/data.dart';
import 'package:mocktail/mocktail.dart';

import '../local_secure_storage_test.dart';

void main() {
  late LocalSecureStorage localSecureStorageImpl;
  late MockLocalSecureStorage mockLocalSecureStorage;

  setUp(() {
    localSecureStorageImpl = FlutterSecureStorageLocalStorageImpl();
    mockLocalSecureStorage = MockLocalSecureStorage();
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
