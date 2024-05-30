
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import 'package:lottie/lottie.dart';
import '../../data/local/storage_repository.dart';
import '../../utils/colors/app_colors.dart';
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
      const Duration(seconds: 3),
    );
    bool isNewUser = StorageRepository.getBool(key: "is_new_user");
    bool isLoginUser = StorageRepository.getBool(key: "isLogin");
    bool isEnter = StorageRepository.getBool(key: "isEnter3");
    if (isNewUser) {
      if(isLoginUser==true){
        Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
      }
      else{
        if(isEnter==true){
          Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
        }
        else{
          Navigator.pushReplacementNamed(context, RouteNames.firstRoute);

        }
      }
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
          child: SvgPicture.asset(AppImages.touristan)),
    );
  }
}
