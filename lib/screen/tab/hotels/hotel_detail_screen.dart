import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/tab/hotels/widgets/room_item.dart';

import '../../../utils/images/app_images.dart';
import '../../../utils/style/app_text_style.dart';
import '../restaurant/widgets/foot_item.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}
int activeIndex=0;

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  List<String> pictures=[
    AppImages.img,
    AppImages.img2,
    AppImages.img1,
  ];
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
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: ClipRRect(
                    child: Image.asset(pictures[activeIndex],fit: BoxFit.cover,),

                  ),
                ),
                Positioned(
                    bottom: 5,
                    right: 5,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          if(activeIndex>0){
                            activeIndex--;
                            setState(() {

                            });
                          }
                        }, icon: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back))),

                        IconButton(onPressed: (){
                          if(activeIndex<2){
                            activeIndex++;
                            setState(() {

                            });
                          }
                        }, icon: Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward_rounded))),
                      ],
                    )
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: RichText(
                      text: TextSpan(
                          text: "",
                          style: AppTextStyle.interMedium.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),
                          children: [
                            TextSpan(
                                text: "Grant Hotel",
                                style: AppTextStyle.interMedium.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(AppImages.img3,width: 24,height: 24,) ,
                        Image.asset(AppImages.img3,width: 24,height: 24,),
                        Image.asset(AppImages.img3,width: 24,height: 24,),
                        Image.asset(AppImages.img3,width: 24,height: 24,),
                        Image.asset(AppImages.img3,width: 24,height: 24,color: Colors.grey,),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: RichText(
                      text: TextSpan(
                          text: "description : \n",
                          style: AppTextStyle.interMedium.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500
                          ),
                          children: [
                            TextSpan(
                              text: "A restaurant is a place where you can eat a meal and pay for it. In restaurants, your food is usually served to you at your table by a waiter or waitress. The restaurant serves breakfast, lunch, and dinner. The food at the restaurant was good and the waiters were polite.",
                              style: AppTextStyle.interMedium.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal
                              ),

                            )
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  SizedBox(
                      height: 160,
                      width: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(10, (index) => const  RoomItem())
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
