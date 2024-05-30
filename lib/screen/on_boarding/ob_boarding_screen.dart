import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/screen/on_boarding/pages/boarding_page_one.dart';
import 'package:hotel_app/screen/on_boarding/pages/boarding_page_three.dart';
import 'package:hotel_app/screen/on_boarding/pages/boarding_page_two.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import '../../data/local/storage_repository.dart';
import '../route.dart';



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light
      ),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {},
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BoardingPageOne(),
                  BoardingPageTwo(),
                  BoardingPageThree(),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                if (activeIndex == 2) {
                  StorageRepository.setBool(
                    key: "is_new_user",
                    value: true,
                  ).then(
                        (value) {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.firstRoute);
                    },
                  );
                } else {
                  activeIndex += 1;
                  controller.animateToPage(
                    activeIndex,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear,
                  );
                }
              },
              child: Text("Next",style: AppTextStyle.interMedium.copyWith(
                fontSize: 18,
                color: Colors.blue
              ),),
            )
          ],
        ),
      ),
    );
  }
}

