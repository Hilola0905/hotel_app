import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/style/app_text_style.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key, required this.imageUrl, required this.title, required this.rate, required this.funk, required this.funkMap, required this.isFavourite, required this.city});
  final String imageUrl;
  final String title;
  final double rate;
  final VoidCallback funk;
  final VoidCallback funkMap;
  final bool isFavourite;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),

      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15.w),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 4,
                blurRadius: 8
            )

       ]
      ),
        child: Row(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.w),bottomLeft: Radius.circular(15.w)),
                      child: Image.network(imageUrl,fit: BoxFit.cover,)),
                ),
                Positioned(child: Container(
                  width: 35,
                  height: 35,
                  child: IconButton(onPressed: (){
                    funk.call();
                  }, icon:  Icon(Icons.favorite,color: isFavourite==true ? Colors.red : Colors.white,),),
                ))
              ],
            ),
          SizedBox(width: 10.w,),
          Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
          Text(
          title.length>11 ? title.substring(0,11) : title,
            style: AppTextStyle.interLight.copyWith(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 15.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 2.w,),
                      Text(
                        rate.toString(),
                        style: AppTextStyle.interLight.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const  SizedBox(
                      width: 4,
                      height: 4,
                      child: Icon(Icons.star,color: Colors.orange,weight: 12,)),
                ],
              ),
              SizedBox(width: 65.w,),
              IconButton(onPressed: (){
              }, icon: const Icon(Icons.location_pin,color: Colors.orange,),
                padding: EdgeInsets.zero,
              ),
            ],
          ),

        ],
      )
          ],
      )

    );
  }
}
