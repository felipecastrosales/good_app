import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/not_found.dart';
import 'package:good_app/app/core/errors/failures/password_wrong.dart';
import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';
import 'package:good_app/features/login/domain/usecases/do_login.dart';

import '../../../../fixtures/models/user_fixtures.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRepository loginRepository = MockLoginRepository();
  DoLogin doLogin = DoLogin(loginRepository: loginRepository);

  final user = UserFixtures();
  final username = user.username;
  final password = user.password;

  test('Should login', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => Right(user.tUser),
    );

    var result = await doLogin(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    expect(result, isA<Right>());
    expect(result, Right(user.tUser));

    verify(
      () => loginRepository.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get wrong password error when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => Left(
        PasswordWrongFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(PasswordWrongFailure()));

    verify(
      () => loginRepository.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get not found error when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => Left(
        NotFoundFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(NotFoundFailure()));

    verify(
      () => loginRepository.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get server failure when logging in', () async {
    when(
      () => loginRepository.call(
        username: any(named: 'username'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => Left(
        ServerFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: username,
        password: password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(ServerFailure()));

    verify(
      () => loginRepository.call(
        username: username,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });
}
