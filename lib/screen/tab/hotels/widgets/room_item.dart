import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/images/app_images.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border :Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                child: Image.asset(AppImages.img,width: 100,height: 100,fit: BoxFit.cover,)
            ),
            Text("Luks",style: AppTextStyle.interMedium.copyWith(
              color: Colors.redAccent,
              fontSize: 12.sp,
            ),),
            SizedBox(height: 4.h,),
            Text("12.00\$",style: AppTextStyle.interMedium.copyWith(
              color: Colors.black54,
              fontSize: 10.sp,
            ),)
          ],
        ),
      ),
    );
  }
}
