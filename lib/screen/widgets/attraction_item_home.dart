import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import '../../utils/style/app_text_style.dart';
import '../route.dart';

class AttractionItemHome extends StatelessWidget {
  const AttractionItemHome({super.key, required this.attractionModel, required this.funk, });
  final AttractionModel attractionModel;
  final VoidCallback funk;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RouteNames.attractionDetailRoute,arguments: attractionModel);
            },
            child: Container(
              width: 140,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10.w),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
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
                          child: Image.network(attractionModel.images[0],width: 130.w,height: 120.h,fit: BoxFit.cover,)
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 4.w,top: 4.h),
                                child: Text(
                                  attractionModel.rating.toString(),
                                  style: AppTextStyle.interLight.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
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
                            Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(attractionModel.locationModel.latitude, attractionModel.locationModel.longitude));
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
          ),
        ],
      ),
    );
  }
}
