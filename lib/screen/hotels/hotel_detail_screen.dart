import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/bloc/all_data/all_data_bloc.dart';
import 'package:hotel_app/bloc/all_data/all_data_event.dart';
import 'package:hotel_app/data/model/hotel/hotel_model.dart';
import 'package:hotel_app/screen/widgets/rounted_bottom.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/style/app_text_style.dart';
import '../route.dart';


class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key, required this.hotelModel});
  final HotelModel hotelModel;

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}
int activeIndex=0;

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
        title: Center(
          child: Text(widget.hotelModel.hotelName,style: AppTextStyle.interBold.copyWith(
           fontSize: 20.w
          ),),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back,color: Colors.black,),),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 660.h,
            width: double.infinity,
            child: ListView(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(widget.hotelModel.images[activeIndex],fit: BoxFit.cover,),

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
                                if(activeIndex<widget.hotelModel.images.length-1){
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(widget.hotelModel.locationModel.latitude, widget.hotelModel.locationModel.longitude));

                      }, icon: const Icon(Icons.location_on_sharp)),
                      Text("${widget.hotelModel.locationModel.stateProvince} , ${widget.hotelModel.locationModel.city} , ${widget.hotelModel.locationModel.country}",
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){
                        Uri uri = Uri.parse(widget.hotelModel.websiteUrl);
                        launchUrl(uri);
                      },
               child:Icon(Icons.language)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...List.generate(5, (index) {
                            int a=getDouble(widget.hotelModel.rating);
                             return  Image.asset(AppImages.img3,width: 18,height: 18,
                              color: a>=widget.hotelModel.rating ? Colors.red : Colors.grey,
                            );
                          }),
                          SizedBox(width: 4.w,),
                          Text(widget.hotelModel.rating.toString(),style: AppTextStyle.interBold,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h,),
                Row(
                  children: [
                    SizedBox(width: 20.h,),
                    IconButton(onPressed: (){
                      Uri uri = Uri.parse("tel:${widget.hotelModel.contactNumber.replaceAll("(", "").replaceAll(")", "")}");
                      launchUrl(uri);
                    }, icon: const Icon(Icons.phone),padding: EdgeInsets.zero,),
                    SizedBox(width: 5.w,),
                    Text(widget.hotelModel.contactNumber,style: AppTextStyle.interMedium.copyWith(

                    ),)
                  ],
                ),
                SizedBox(height: 4.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: RichText(
                    text: TextSpan(
                        text: "Description : \n\n",
                        style: AppTextStyle.interMedium.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          TextSpan(
                            text: widget.hotelModel.description,
                            style: AppTextStyle.interMedium.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal
                            ),

                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 4.h,),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 46.h,
              child: RoundedButton(
                text: "booking",
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.bookingRoute,arguments: widget.hotelModel.hotelId);
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int getDouble(double son){
  for(int i=1;i<=5;i++){
    if(son<i){
      return i;
    }
  }
  return 5;
}