import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/data/local/storage_repository.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/images/app_images.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const  SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                AppImages.img4,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 40,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Ink(
                         padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RouteNames.register);
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 35.w),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: Colors.white)
                              ),
                              child: Text("Sign up",style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                        Ink(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RouteNames.loginScreen);
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 35.w),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Text("Sign in",style: AppTextStyle.interMedium.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                  fontSize: 16
                              ),
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    TextButton(
                         onPressed: (){
                           StorageRepository.setBool(key: "isEnter3", value: true);
                           Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
                         }
                        , child: Text("Continue to Guest",style: AppTextStyle.interMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                       decoration: TextDecoration.underline,
                       decorationColor: Colors.white,
                       decorationThickness: 1.0,
                    ),

                    ),

                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
