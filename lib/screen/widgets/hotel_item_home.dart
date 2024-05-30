import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/hotel/hotel_model.dart';
import '../../utils/style/app_text_style.dart';
import '../route.dart';

class HotelItemHome extends StatelessWidget {
  const HotelItemHome({super.key, required this.hotelModel, required this.funk, });
  final HotelModel hotelModel;
  final VoidCallback funk;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteNames.hotelDetailRoute,arguments: hotelModel);
      },
      child: Container(
        width: 130,
        height: 105,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: Colors.cyan.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius:  BorderRadius.only(topLeft: Radius.circular(10.w),topRight: Radius.circular(10.w)),
                    child: Image.network(hotelModel.images[0],width: 130.w,height: 120,fit: BoxFit.cover,)
                ),
                Positioned(child: Container(
                     width: 35,
                     height: 35,
                  child: IconButton(onPressed: (){
                   funk.call();
                  }, icon:  Icon(Icons.favorite,color: hotelModel.isFavourite==true ? Colors.red : Colors.white,),),
                ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: 4.w,top: 4.h),
                  child: Text(
                    hotelModel.hotelName,
                    style: AppTextStyle.interLight.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                    ),
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 4.w,top: 4.h),
                          child: Text(
                            hotelModel.rating.toString(),
                            style: AppTextStyle.interLight.copyWith(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const  SizedBox(
                            width: 4,
                            height: 4,
                            child: Icon(Icons.star,color: Colors.orange,weight: 12,))
                      ],
                    ),
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(hotelModel.locationModel.latitude, hotelModel.locationModel.longitude));
                    }, icon: const Icon(Icons.location_pin,color: Colors.orange,),
                    padding: EdgeInsets.zero,
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
