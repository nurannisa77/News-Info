import 'package:dio/dio.dart';
import 'package:news_info/model/get_list_news_portal_response_model.dart';
import 'package:news_info/utils/base_url.dart';

class NewsPortalService {
  final Dio _dio = Dio();

  Future<GetListNewsPortalResponseModel> getListNewsPortals() async {
    try {
      Response response = await _dio.get(BaseUrl.listNewsPortalUrl);
      if (response.statusCode == 200) {
        return GetListNewsPortalResponseModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load news portals. Server responded with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load news portals: $error');
    }
  }
}
