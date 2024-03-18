import 'package:dio/dio.dart';
import 'package:project/consts.dart';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();
  final _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (bearerToken != null) {
      headers["Authorization"] = "Bearer $bearerToken";
    }

    _dio.options.headers = headers;
  }

  Future<Response?> post(Map data) async {
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
