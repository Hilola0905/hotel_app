import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/tab/restaurant/widgets/retaurant_item.dart';

import '../../../utils/style/app_text_style.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        systemOverlayStyle:  const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
        title: Center(child: Text("All Restaurant",style: AppTextStyle.interMedium.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600
        ),)),
      ),
        body: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              ...List.generate(15, (index) => const RestaurantItem()),
            ],
          ),
        )
    );
  }
}
