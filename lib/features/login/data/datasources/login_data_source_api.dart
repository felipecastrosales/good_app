import 'package:dartz/dartz.dart';

import 'package:good_app/app/core/errors/default/default_error.dart';
import 'package:good_app/app/core/errors/failures/unknown.dart';
import 'package:good_app/app/core/logger/app_logger.dart';
import 'package:good_app/app/core/rest_client/rest_client.dart';
import 'package:good_app/data/constants/constants_api.dart';
import 'package:good_app/features/login/data/mapper/auth_mapper.dart';
import 'package:good_app/features/login/data/models/auth_model.dart';

import 'login_data_source.dart';

class LoginDataSourceApi implements LoginDataSource {
  LoginDataSourceApi({
    required RestClient restClient,
    required AuthMapper authMapper,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  final RestClient _restClient;
  final AppLogger _log;

  @override
  Future<Either<DefaultError, AuthModel>> call({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _restClient.post(
        ConstantsApi.auth,
        data: {
          'username': username,
          'password': password,
        },
      );
      final auth = AuthModel.fromJson(response.data);
      return Right(auth);
    } catch (e, s) {
      _log.error(e.toString(), e, s);
      return Left(
        DefaultError.unknown(
          title: 'UnknownFailure',
          message: 'Unknown error on LoginDataSourceApi',
          cause: UnknownFailure(),
        ),
      );
    }
  }
}
