import 'package:dio/dio.dart';

class NewsService {
  static final Dio _dio = Dio();

  static Future<Response> getNews(String? selectedPath) async {
    try {
      final response = await _dio.get(selectedPath ?? '');
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
