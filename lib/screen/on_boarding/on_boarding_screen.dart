import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:news_info/constant/text_style_constant.dart';
import 'package:news_info/screen/on_boarding/provider/on_boarding_provider.dart';
import 'package:news_info/widgets/bottom_navbar_widget.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key});

  void _onIntroEnd(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).completeOnBoarding().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BottomNavbarWidget()),
      );
    });
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(assetName, width: width);
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyleConstant.onBoardingTittle(context) ?? const TextStyle(),
      bodyTextStyle: TextStyleConstant.onBoardingBody(context) ?? const TextStyle(),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.background,
      imagePadding: EdgeInsets.zero,
      bodyFlex: 2,
      imageFlex: 4,
      bodyAlignment: Alignment.topCenter,
      imageAlignment: Alignment.bottomCenter,
    );

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).colorScheme.background,
      pages: [
        PageViewModel(
          title: "News Portals",
          body: "Read news from different sources",
          image: _buildImage('assets/image/on_boarding/page_1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Search",
          body: "Find categories according to your interests.",
          image: _buildImage('assets/image/on_boarding/page_2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Bookmarks",
          body: "Save favorite articles.",
          image: _buildImage('assets/image/on_boarding/page_3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "AI Chat Bot",
          body: "Ask your questions.",
          image: _buildImage('assets/image/on_boarding/page_4.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.outline),
      skip: Text('Skip', style: TextStyleConstant.onBoardingFooter(context) ?? const TextStyle()),
      next: Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.outline,),
      done: Text('Done', style: TextStyleConstant.onBoardingFooter(context) ?? const TextStyle()),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Theme.of(context).colorScheme.onInverseSurface,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
