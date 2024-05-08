import 'package:flutter/foundation.dart';
import 'package:news_info/model/get_list_news_portal_response_model.dart';
import 'package:news_info/service/list_news_portal_service.dart';

class NewsPortalProvider extends ChangeNotifier {
  GetListNewsPortalResponseModel? _newsPortal;
  String? _errorMessage;
  Path? _selectedPath;

  bool get isLoading => _newsPortal == null && _errorMessage == null;

  String? getErrorMessage() {
    return _errorMessage;
  }

  bool hasError() {
    return _errorMessage != null;
  }

  GetListNewsPortalResponseModel? get newsPortal => _newsPortal;
  String? get errorMessage => _errorMessage;
  Path? get selectedPath => _selectedPath;
  String? get selectedPathName => _selectedPath?.name;

  Future<void> fetchNewsPortal() async {
    try {
      NewsPortalService newsPortalService = NewsPortalService();
      _newsPortal = await newsPortalService.getListNewsPortals();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch news portal: $e';
    } finally {
      notifyListeners();
    }
  }

  void setSelectedPath(Path path) {
    _selectedPath = path;
    notifyListeners();
  }

  List<String> getPathsNames() {
    List<String> pathsNames = [];
    _newsPortal?.endpoints?.forEach((endpoint) {
      endpoint.paths?.forEach((path) {
        pathsNames.add(path.name ?? '');
      });
    });
    return pathsNames;
  }
}
