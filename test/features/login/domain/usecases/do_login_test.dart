import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/features/login/domain/entities/auth_entity.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';
import 'package:good_app/features/login/domain/usecases/do_login.dart';

import '../../../../fixtures/models/user_fixtures.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRepository loginRepository = MockLoginRepository();
  DoLogin doLogin = DoLogin(repository: loginRepository);

  final user = UserFixtures();
  final realUsername = user.realUsername;
  final realPassword = user.realPassword;

  test('Should login', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      // TODO: View this
      (_) async => const Right(
        AuthEntity(
          accessToken: '',
          refreshToken: '',
          expiresIn: 0,
        ),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: realUsername,
        password: realPassword,
      ),
    );

    expect(result, isA<Right>());
    // TODO: Fix this
    // expect(result, Right(user.tUser));

    verify(
      () => loginRepository.call(
        username: realUsername,
        password: realPassword,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get WrongPassword error when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Left(
        DefaultError.passwordWrong(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: realUsername,
        password: realPassword,
      ),
    );

    expect(result, isA<Left>());
    expect(result, const Left(DefaultError.passwordWrong()));

    verify(
      () => loginRepository.call(
        username: realUsername,
        password: realPassword,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get NotFound error when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Left(
        DefaultError.notFound(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: realUsername,
        password: realPassword,
      ),
    );

    expect(result, isA<Left>());
    expect(result, const Left(DefaultError.notFound()));

    verify(
      () => loginRepository.call(
        username: realUsername,
        password: realPassword,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get ServerFailure error when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Left(
        DefaultError.server(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: realUsername,
        password: realPassword,
      ),
    );

    expect(result, isA<Left>());
    expect(result, const Left(DefaultError.server()));

    verify(
      () => loginRepository.call(
        username: realUsername,
        password: realPassword,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });
}
