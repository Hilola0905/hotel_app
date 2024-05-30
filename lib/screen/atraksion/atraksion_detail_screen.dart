import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/style/app_text_style.dart';
import '../route.dart';
import '../widgets/rounted_bottom.dart';


class AttractionDetailScreen extends StatefulWidget {
  const AttractionDetailScreen({super.key, required this.attractionModel});
 final AttractionModel attractionModel;
  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}
int activeIndex=0;
class _AttractionDetailScreenState extends State<AttractionDetailScreen> {

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
          child: Text(widget.attractionModel.attractionName,style: AppTextStyle.interBold.copyWith(
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
                          child: Image.network(widget.attractionModel.images[activeIndex],fit: BoxFit.cover,),

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
                                if(activeIndex<widget.attractionModel.images.length-1){
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
                        Navigator.pushNamed(context, RouteNames.mapRoute,arguments: LatLng(widget.attractionModel.locationModel.latitude, widget.attractionModel.locationModel.longitude));
                      }, icon: const Icon(Icons.location_on_sharp)),
                      Text("${widget.attractionModel.locationModel.stateProvince} , ${widget.attractionModel.locationModel.city} , ${widget.attractionModel.locationModel.country}",
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){
                        Uri uri = Uri.parse(widget.attractionModel.websiteUrl);
                        launchUrl(uri);
                      },
                          child:const Icon(Icons.language)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ...List.generate(5, (index) {
                            int a=getDouble(widget.attractionModel.rating);
                            return  Image.asset(AppImages.img3,width: 18,height: 18,
                              color: a>=widget.attractionModel.rating ? Colors.red : Colors.grey,
                            );
                          }),
                          SizedBox(width: 4.w,),
                          Text(widget.attractionModel.rating.toString(),style: AppTextStyle.interBold,)
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
                      Uri uri = Uri.parse("tel:${widget.attractionModel.contactNumber.replaceAll("(", "").replaceAll(")", "")}");
                      launchUrl(uri);
                    }, icon: const Icon(Icons.phone),padding: EdgeInsets.zero,),
                    SizedBox(width: 5.w,),
                    Text(widget.attractionModel.contactNumber,style: AppTextStyle.interMedium.copyWith(

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
                            text: widget.attractionModel.description,
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
                    Navigator.pushNamed(context, RouteNames.bookingRoute,arguments: widget.attractionModel.attractionId);
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