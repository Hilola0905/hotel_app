import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/images/app_images.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteNames.restaurantDetailRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border :Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const  [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: Offset(8,8),
                  color: Colors.grey
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                child: Image.asset(AppImages.img1,width: double.infinity,height: 100,fit: BoxFit.cover,)
            ),
            Text("Restaurant",style: AppTextStyle.interMedium.copyWith(
              color: Colors.redAccent,
              fontSize: 12.sp,
            ),),
            SizedBox(height: 4.h,),
          ],
        ),
      ),
    );
  }
}
