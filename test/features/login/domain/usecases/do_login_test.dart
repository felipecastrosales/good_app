import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/not_found.dart';
import 'package:good_app/app/core/errors/failures/password_wrong.dart';
import 'package:good_app/app/core/errors/failures/server.dart';
import 'package:good_app/features/login/domain/entities/user.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';
import 'package:good_app/features/login/domain/usecases/do_login.dart';

import '../../../../fixtures/models/user_fixtures.dart';

var tUser = User(
  bornDate: faker.date.dateTime(),
  email: email,
  name: faker.person.name(),
  imageUrl: faker.image.image(),
);

var email = faker.internet.email();
var password = faker.internet.password();

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
