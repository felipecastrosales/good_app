import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/app.dart';
import 'package:good_app/features/features.dart';

import '../../../../fixtures/fixtures.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRepository loginRepository = MockLoginRepository();
  DoLogin doLogin = DoLogin(loginRepository: loginRepository);

  final user = UserFixtures();

  test('Should login', () async {
    when(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Right(user.tUser),
    );

    var result = await doLogin(
      LoginParams(
        username: user.username,
        password: user.password,
      ),
    );

    expect(result, isA<Right>());
    expect(result, Right(user.tUser));

    verify(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get wrong password error when logging in', () async {
    when(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Left(
        PasswordWrongFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: user.username,
        password: user.password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(PasswordWrongFailure()));

    verify(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get not found error when logging in', () async {
    when(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Left(
        NotFoundFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: user.username,
        password: user.password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(NotFoundFailure()));

    verify(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });

  test('Should get server error when logging in', () async {
    when(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Left(
        ServerFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        username: user.username,
        password: user.password,
      ),
    );

    expect(result, isA<Left>());
    expect(result, Left(ServerFailure()));

    verify(
      () => loginRepository.login(
        username: user.username,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(loginRepository);
  });
}
