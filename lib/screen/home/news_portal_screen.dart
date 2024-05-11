import 'package:flutter/material.dart';
import 'package:news_info/constant/asset_constant.dart';
import 'package:news_info/constant/list_portal_constant.dart';
import 'package:news_info/constant/names_route_constant.dart';
import 'package:news_info/screen/home/news_instructions_text_widget.dart';
import 'package:news_info/screen/home/provider/news_portal_provider.dart';
import 'package:provider/provider.dart';

class NewsPortalScreen extends StatelessWidget {
  const NewsPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetConstant.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NewsInstructionText(),
                Expanded(
                  child: Consumer<NewsPortalProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        Provider.of<NewsPortalProvider>(context, listen: false)
                            .getNewsPortal();
                        return const Center(child: CircularProgressIndicator());
                      } else if (provider.hasError()) {
                        return Center(
                          child: Text(provider.getErrorMessage()!),
                        );
                      } else {
                        return _buildPortalGrid(provider, context);
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

  Widget _buildPortalGrid(NewsPortalProvider provider, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 31.0,
      ),
      itemCount: provider.newsPortal?.endpoints?.length ?? 0,
      itemBuilder: (context, index) {
        final portalName = provider.getPortalNameAtIndex(index);
        final paths = provider.getPathsAtIndex(index);
        return GestureDetector(
          onTap: () {
            if (paths != null && paths.isNotEmpty) {
              provider.setSelectedPath(paths[0]);
              Navigator.pushNamed(
                context,
                NameRoutes.newsRoute,
              );
            }
          },
          child: Container(
            height: 82,
            width: 82,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
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
    );
  }
}
