import 'package:flutter/foundation.dart';
import 'package:news_info/helper/shared_pref_helper.dart';

class OnBoardingProvider with ChangeNotifier {
  Future<void> completeOnBoarding() async {
    await SharedPrefHelper.setFirstTime(false);
    notifyListeners();
  }
}
