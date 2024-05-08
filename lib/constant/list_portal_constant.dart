import 'package:news_info/constant/asset_constant.dart';

class ListPortalConstant {
  static Map<String, String> listNewsPortalMap = {
    'antara': AssetConstant.portalAntaraLogo,
    'cnbc': AssetConstant.portalCnbcLogo,
    'cnn': AssetConstant.portalCnnLogo,
    'jpnn': AssetConstant.portalJpnnLogo,
    'kumparan': AssetConstant.portalKumparanLogo,
    'merdeka': AssetConstant.portalMerdekaLogo,
    'okezone': AssetConstant.portalOkeZoneLogo,
    'republika': AssetConstant.portalRepublikaLogo,
    'sindonews': AssetConstant.portalSindoLogo,
    'suara': AssetConstant.portalSuaraLogo,
    'tempo': AssetConstant.portalTempoLogo,
    'tribun': AssetConstant.portalTribunLogo,
  };

    static String portalLogo (String portalName) {
    return listNewsPortalMap.containsKey(portalName)
        ? listNewsPortalMap[portalName]!
        :AssetConstant.notFoundImage;
  }
}
