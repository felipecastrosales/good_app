import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/errors/failures/not_found.dart';
import 'package:good_app/app/core/errors/failures/password_wrong.dart';
import 'package:good_app/features/login/domain/entities/user.dart';
import 'package:good_app/features/login/domain/repositories/login_repository.dart';
import 'package:good_app/features/login/domain/usecases/do_login.dart';

var tUser = User(
  bornDate: faker.date.dateTime(),
  email: email,
  name: faker.person.name(),
  imageUrl: faker.image.image(),
);

var email = faker.internet.email();
var password = faker.internet.password();

class MockDoLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRepository doLoginRepository = MockDoLoginRepository();
  DoLogin doLogin = DoLogin(loginRepository: doLoginRepository);

  test('Should login', () async {
    when(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).thenAnswer(
      (_) async => Right(tUser),
    );

    var result = await doLogin(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    expect(result, isA<Right>());
    expect(result, Right(tUser));

    verify(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });

  test('Should get wrong password error when logging in', () async {
    when(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).thenAnswer(
      (_) async => Left(
        PasswordWrongFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    expect(result, isA<Left>());
    expect(
      result,
      Left(PasswordWrongFailure()),
    );

    verify(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });

  test('Should get not found error when logging in', () async {
    when(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).thenAnswer(
      (_) async => Left(
        NotFoundFailure(),
      ),
    );

    var result = await doLogin(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    expect(result, isA<Left>());
    expect(
      result,
      Left(NotFoundFailure()),
    );

    verify(
      () => doLoginRepository.login(
        email: email,
        password: password,
      ),
    ).called(1);

    verifyNoMoreInteractions(doLoginRepository);
  });
}
