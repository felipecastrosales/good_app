import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_error.freezed.dart';

@freezed
class DefaultError with _$DefaultError {
  const factory DefaultError.info({
    String? title,
    String? message,
  }) = _Info;

  const factory DefaultError.warning({
    String? title,
    String? message,
    Exception? cause,
  }) = _Warning;

  const factory DefaultError.fatal({
    String? title,
    String? message,
    Exception? cause,
  }) = _Fatal;

  const factory DefaultError.unknown({
    String? title,
    String? message,
    Exception? cause,
  }) = _Unknown;

  const factory DefaultError.notFound({
    String? title,
    String? message,
    Exception? cause,
  }) = _NotFound;

  const factory DefaultError.server({
    String? title,
    String? message,
    Exception? cause,
  }) = _Server;

  const factory DefaultError.passwordWrong({
    String? title,
    String? message,
    Exception? cause,
  }) = _PasswordWrong;
}
