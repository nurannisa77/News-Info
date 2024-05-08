import 'package:flutter/material.dart';
import 'package:news_info/constant/asset_constant.dart';
import 'package:news_info/constant/color_constant.dart';
import 'package:news_info/constant/list_portal_constant.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/constant/text_style_constant.dart';
import 'package:news_info/screen/home/news_instructions_text_widget.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';
import 'package:provider/provider.dart';

class NewsPortalScreen extends StatefulWidget {
  const NewsPortalScreen({Key? key}) : super(key: key);

  @override
  _NewsPortalScreenState createState() => _NewsPortalScreenState();
}

class _NewsPortalScreenState extends State<NewsPortalScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsPortalProvider>(context, listen: false).fetchNewsPortal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetConstant.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NewsInstructionText(),
                Expanded(
                  child: Consumer<NewsPortalProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (provider.hasError()) {
                        return Center(
                          child: Text(provider.getErrorMessage()!),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 24.0,
                              mainAxisSpacing: 31.0,
                            ),
                            itemCount: provider.newsPortal!.endpoints?.length ?? 0,
                            itemBuilder: (context, index) {
                              final endpoint = provider.newsPortal!.endpoints?[index];
                              final portalName = endpoint?.name ?? "";
                              final paths = endpoint?.paths;
                              return GestureDetector(
                                onTap: () {
                                  if (paths != null && paths.isNotEmpty) {
                                    provider.setSelectedPath(paths[0]);
                                    Navigator.pushNamed(context, NameRoutes.newsRoute);
                                  }
                                },
                                child: Container(
                                  height: 82,
                                  width: 82,
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ListPortalConstant.portalLogo(portalName),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
