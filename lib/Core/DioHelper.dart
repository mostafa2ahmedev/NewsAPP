import 'package:dio/dio.dart';

class DioHelper {
  static late final Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String endPoint, required Map<String, dynamic> query}) async {
    return await dio.get(
      endPoint,
      queryParameters: query,
      options: Options(
        headers: {'X-Api-Key': '97360b8f217244bda95e08e851bb28a0'},
      ),
    );
  }
}
