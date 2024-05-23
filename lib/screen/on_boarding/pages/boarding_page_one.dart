
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/style/app_text_style.dart';


class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.img,
          width: 300.w,
          height: 400.h,
        ),
       SizedBox(height: 20.h,),
        Text(
          textAlign: TextAlign.center,
          "You will find many wonderful hotels here",
          style: AppTextStyle.interBold
              .copyWith(color: AppColors.blue1, fontSize: 18.w),
        ),


      ],
    );
  }
}
