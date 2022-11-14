import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:good_app/app/app.dart';
import 'package:good_app/features/features.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/user_fixtures.dart';

class MockDoLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRepository doLoginRepository = MockDoLoginRepository();
  DoLogin doLogin = DoLogin(loginRepository: doLoginRepository);

  final user = UserFixtures();

  test('Should login', () async {
    when(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Right(user.tUser),
    );

    var result = await doLogin(
      LoginParams(
        email: user.email,
        password: user.password,
      ),
    );

    expect(result, isA<Right>());
    expect(result, Right(user.tUser));

    verify(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });

  test('Should get wrong password error when logging in', () async {
    when(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Left(
        PasswordWrongFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        email: user.email,
        password: user.password,
      ),
    );

    expect(result, isA<Left>());
    expect(
      result,
      Left(PasswordWrongFailure()),
    );

    verify(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });

  test('Should get not found error when logging in', () async {
    when(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).thenAnswer(
      (_) async => Left(
        NotFoundFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        email: user.email,
        password: user.password,
      ),
    );

    expect(result, isA<Left>());
    expect(
      result,
      Left(NotFoundFailure()),
    );

    verify(
      () => doLoginRepository.login(
        email: user.email,
        password: user.password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });
}
