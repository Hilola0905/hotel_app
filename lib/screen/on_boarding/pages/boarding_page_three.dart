import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/style/app_text_style.dart';

class BoardingPageThree extends StatelessWidget {
  const BoardingPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.img2,
          width: 340.w,
          height: 440.h,
        ),
        SizedBox(height: 20.h,),
        Text(
          textAlign: TextAlign.center,
          "You will experience unforgettable and wonderful moments",
          style: AppTextStyle.interBold
              .copyWith(color: AppColors.blue1, fontSize: 18.w),
        ),

      ],
    );
  }
}
