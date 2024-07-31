import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/restaurant/restaurant_model.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.restaurantModel, required this.funk});
  final RestaurantModel restaurantModel;
  final VoidCallback funk;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteNames.restaurantDetailRoute,arguments: restaurantModel);
      },
      child: Container(
        width: 130,
        height: 105,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10.w),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 4,
                  blurRadius: 8
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10.w),topRight: Radius.circular(10.w)),
                    child: Image.network(restaurantModel.images[0],width: 100.w,height: 100.h,fit: BoxFit.fill)
                ),
                Positioned(child: SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(onPressed: (){
                    funk.call();
                  }, icon:  Icon(Icons.favorite,color: restaurantModel.isFavourite==true ? Colors.red : Colors.white,),),
                )),
              ],

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 4.w,top: 4.h),
                  child: Text(
                    restaurantModel.restaurantName,
                    style: AppTextStyle.interLight.copyWith(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                  ),

                ),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(restaurantModel.locationModel.latitude, restaurantModel.locationModel.longitude));
                    }, icon: const Icon(Icons.location_pin,color: Colors.orange,),
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      restaurantModel.locationModel.city,
                      style: AppTextStyle.interLight.copyWith(
                          fontSize: 9.sp,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
