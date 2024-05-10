import 'package:flutter/material.dart';
import 'package:opticheck/common/global/global.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResultPageMain extends StatelessWidget {
  ResultPageMain({super.key, required this.pages});
  final _controller = PageController();
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Resultpage_bg), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                // color: Colors.blue,
                child: PageView(
                  controller: _controller,
                  // physics: NeverScrollableScrollPhysics(),

                  // children: [
                  //   ResponsiveLayout(
                  //       mobileBody: ColorblindResultPage(),
                  //       landscapeBody: LandscapeColorblindResultPage()),
                  //   AcuityResultPage(),
                  //   ContrastResultPage(),
                  // ],

                  children: pages,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: pages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: primaryButtonBackgroundColor,
                        dotColor: globalSecondaryColor,
                        spacing: 20,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       // color: Colors.white.withOpacity(0.1),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     height: calculateIconSize(context),
                  //     width: calculateIconSize(context),
                  //     child: Lottie.network(
                  //       'https://lottie.host/38c67b8b-d04d-40ee-b148-20b50486e6a4/0B5rLg1s3l.json',
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
