import 'dart:convert';

import 'package:mocktail/mocktail.dart';

import 'package:good_app/app/core/rest_client/rest_client_response.dart';

class MockRestClientResponse<T> extends Mock implements RestClientResponse<T> {
  MockRestClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  });

  @override
  final T? data;

  @override
  final int? statusCode;

  @override
  final String? statusMessage;

  @override
  String toString() {
    if (data is Map) {
      return jsonEncode(data);
    }
    return super.toString();
  }
}
