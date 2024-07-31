import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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


class _HotelDetailScreenState extends State<HotelDetailScreen> {
  final PageController controller = PageController();
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
            SizedBox(
              height: 720.h,
              width: double.infinity,
              child: ListView(
                children: [
                  SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: PageView(
                  controller: controller,
                  onPageChanged: (index) {},
                  children:  [
                    ...List.generate(widget.hotelModel.images.length, (index) =>
                        SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: ClipRRect(
                            child: Image.network(widget.hotelModel.images[index],fit: BoxFit.cover,),
                          ),
                        ),
                    ),
                  ],
                                ),
                ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.hotelModel.hotelName,
                          style: AppTextStyle.interMedium.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                          ),
                          maxLines: 1,
                        ),
                        TextButton(onPressed: (){
                          Uri uri = Uri.parse(widget.hotelModel.websiteUrl);
                          launchUrl(uri);
                        },
                            child:const Icon(Icons.language)),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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

                      IconButton(onPressed: (){
                        Uri uri = Uri.parse("tel:${widget.hotelModel.contactNumber.replaceAll("(", "").replaceAll(")", "")}");
                        launchUrl(uri);
                      }, icon: const Icon(Icons.phone),padding: EdgeInsets.zero,),
                      SizedBox(width: 5.w,),
                      Text(widget.hotelModel.contactNumber,style: AppTextStyle.interMedium.copyWith(

                      ),)
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(widget.hotelModel.locationModel.latitude, widget.hotelModel.locationModel.longitude));

                      },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.location_on_sharp)),
                      Text("${widget.hotelModel.locationModel.stateProvince} , ${widget.hotelModel.locationModel.city} , ${widget.hotelModel.locationModel.country}",
                        maxLines: 3,
                      ),

                    ],
                  ),
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
            const Spacer(),
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
            SizedBox(height: 20.h,),
          ],
        ),
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