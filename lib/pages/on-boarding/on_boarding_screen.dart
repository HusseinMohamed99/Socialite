import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialite/model/onboarding_model.dart';
import 'package:socialite/pages/on-boarding/on_board_screen.dart';

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
    _controller = PageController(initialPage: 0);
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
  const OnBoardingItems(
      {super.key,
      required this.index,
      required this.currentIndex,
      required this.controller});
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
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contents[index].title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
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
                  padding: const EdgeInsets.only(bottom: 30.0),
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
                  height: 60,
                  width: 80,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: IconButton(
                    icon: Icon(
                      currentIndex == contents.length - 1
                          ? Icons.arrow_forward
                          : Icons.arrow_forward,
                      color: Colors.black54,
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
                        duration: const Duration(milliseconds: 2),
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
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.amber : Colors.grey,
      ),
    );
  }
}
