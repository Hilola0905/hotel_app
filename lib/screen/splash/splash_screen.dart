
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/local/storage_repository.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/screen_utils.dart';
import '../route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    _init();
    super.initState();
  }
  _init() async {
    await Future.delayed(
      const Duration(seconds: 6),
    );
    bool isNewUser = StorageRepository.getBool(key: "is_new_user");
    if (isNewUser) {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    }
    else {
      Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
    }
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
          child: Lottie.asset(
              AppImages.splashLottie
          )),
    );
  }
}
