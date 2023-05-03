import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edu_expert/constants/constants.dart';
import 'package:edu_expert/data/model/book_response/book_response_model.dart';

class BookRemoteDatasource {
  final Dio _client;

  const BookRemoteDatasource(this._client);
  Future<BookResponse?> getbook() async {
    try {
      final url = Constants.allBookUrl;

      final result = await _client.get(url);

      if (result.statusCode == 200) {
        return BookResponse.fromJson(result.data);
      }
      return null;
    } catch (error, stacktrace) {
      log('Error on GetBook $error', stackTrace: stacktrace);
      return null;
    }
  }
}
