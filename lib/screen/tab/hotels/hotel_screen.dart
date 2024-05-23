import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/tab/hotels/widgets/hotel_item.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
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
        title: Center(child: Text("All Hotels",style: AppTextStyle.interMedium.copyWith(
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
              ...List.generate(15, (index) => const HotelItem() ),
            ],
          ),
        )
    );
  }
}
