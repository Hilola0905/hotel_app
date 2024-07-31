import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

import '../../route.dart';


class AttractionItem extends StatelessWidget {
  const AttractionItem({super.key, required this.attractionModel, required this.funk});
  final AttractionModel attractionModel;
  final VoidCallback funk;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, RouteNames.attractionDetailRoute,arguments: attractionModel);
      },
      child: Container(
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
                    child: Image.network(attractionModel.images[0],width: 100.w,height: 90,fit: BoxFit.cover,)
                ),
                Positioned(child: SizedBox(
                  width: 35,
                  height: 35,
                  child: IconButton(onPressed: (){
                    funk.call();
                  }, icon:  Icon(Icons.favorite,color: attractionModel.isFavourite==true ? Colors.red : Colors.white,),),
                )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 4.w,top: 4.h),
                  child: Text(
                    attractionModel.attractionName,
                    style: AppTextStyle.interLight.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(attractionModel.locationModel.latitude, attractionModel.locationModel.longitude));
                    }, icon: const Icon(Icons.location_pin,color: Colors.orange,),
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      attractionModel.locationModel.city,
                      style: AppTextStyle.interLight.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
