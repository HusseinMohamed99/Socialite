import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialite/model/onboarding_model.dart';
import 'package:socialite/pages/on-boarding/on_board_screen.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  var _controller = PageController();

  @override
  void initState() {
    _controller =
        PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: PageView.builder(
          controller: _controller,
          itemCount: contents.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, index) {
            return OnBoardingItems(
              index: index,
              currentIndex: currentIndex,
              controller: _controller,
            );
          },
        ),
      ),
    );
  }
}

class OnBoardingItems extends StatelessWidget {
  const OnBoardingItems({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.controller,
  });
  final int index;
  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            contents[index].image,
          ),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            ColorManager.titanWithColor.withOpacity(0.9),
            BlendMode.modulate,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(contents[index].title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: AppSize.s20),
                Text(
                  contents[index].description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => BuildDotWidget(
                        index: index,
                        currentIndex: currentIndex,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.m16),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSize.s16),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      currentIndex == contents.length - 1
                          ? Icons.arrow_back
                          : Icons.arrow_forward,
                      color: ColorManager.titanWithColor,
                    ),
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnBoard(),
                          ),
                        );
                      }
                      controller.nextPage(
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.bounceIn,
                      );
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

class BuildDotWidget extends StatelessWidget {
  const BuildDotWidget(
      {super.key, required this.index, required this.currentIndex});
  final int index;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? AppSize.s28 : AppSize.s10,
      margin: const EdgeInsets.only(right: AppMargin.m4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: currentIndex == index
            ? ColorManager.whiteColor
            : ColorManager.greyColor,
      ),
    );
  }
}
