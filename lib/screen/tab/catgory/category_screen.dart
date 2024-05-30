import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_app/screen/hotels/widgets/hotel_item.dart';
import 'package:hotel_app/screen/restaurant/widgets/retaurant_item.dart';
import 'package:hotel_app/utils/images/app_images.dart';
import '../../../bloc/all_data/all_data_bloc.dart';
import '../../../bloc/all_data/all_data_event.dart';
import '../../../bloc/all_data/all_data_state.dart';
import '../../../data/model/filter/filter.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/style/app_text_style.dart';
import '../../../utils/utility_function.dart';
import '../../atraksion/widget/atraksion_item.dart';
import '../../route.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController search=TextEditingController();
  int activeIndex=0;
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
        elevation: 0,
        title: Center(
          child: Text("All The Best Place",style: AppTextStyle.interBold.copyWith(
              fontSize: 22
          ),),
        ),
      ),
      body: BlocConsumer<AllDataBloc, AllDataState>(
        builder: (BuildContext context, AllDataState state) {
          return RefreshIndicator(
            onRefresh: () async {
              if(search.text.isNotEmpty){
                context.read<AllDataBloc>().add(SearchDataEvent(search.text));
              }
              else{
                context.read<AllDataBloc>().add(AllDataByApiEvent());
              }

            },
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                child: Column(
                  children: [
                   SizedBox(
                   height: 70.h,
                   child: Row(
                     children: [
                       Expanded(
                         flex: 6,
                         child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8),
                               color: AppColors.white,
                               boxShadow: [
                                 BoxShadow(
                                   blurRadius: 62,
                                   offset: const Offset(0, 4),
                                   color: AppColors.c99ABC6.withOpacity(0.18),
                                 )
                               ]),
                           child: TextFormField(
                             controller: search,
                             decoration: InputDecoration(
                               hintText: "Search",
                               hintStyle: AppTextStyle.interBold.copyWith(
                                   color: AppColors.cAAA6B9, fontSize: 12.w,
                               fontWeight: FontWeight.w400),
                               contentPadding: EdgeInsets.symmetric(
                                   vertical: 8.h, horizontal: 7.w),
                                 suffixIcon: IconButton(
                                 onPressed: () {
                                   context.read<AllDataBloc>().add(SearchDataEvent(search.text));
                                   setState(() {

                                   });
                                 },
                                 icon: const Icon(Icons.search),
                               ),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(16),
                                 borderSide: BorderSide.none,
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         width: 15.w,
                       ),
                       Expanded(
                         flex: 1,
                         child: TextButton(
                           style: TextButton.styleFrom(
                               backgroundColor: AppColors.cFCA34D,
                               padding: EdgeInsets.symmetric(
                                   horizontal: 8.w, vertical: 8.h),
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8))),
                           onPressed: (){
                             if(activeIndex==0){
                               Navigator.pushNamed(context, RouteNames.filterRoute,
                                   arguments: FilterItemModel(country: getCountryHotel(state.hotels), city:getCityHotel(state.hotels), province: getProvinceHotel(state.hotels)));
                             }
                             if(activeIndex==1){
                               Navigator.pushNamed(context, RouteNames.filterRoute,
                                   arguments: FilterItemModel(
                               country: getCountryAttraction(state.attractions),
                             city:getCityAttraction(state.attractions),
                             province: getProvinceAttraction(state.attractions)
                             ));

                             }
                           },
                           child:  SvgPicture.asset(AppImages.filter),
                         ),
                       )
                     ],
                   ),
                 ),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                                  activeIndex=0;
                                  setState(() {

                                  });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: activeIndex==0 ? Colors.cyan : Colors.cyan.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 8.w),
                            child: Text("Hotels",style: AppTextStyle.interRegular,),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            activeIndex=1;
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:activeIndex==1 ? Colors.cyan : Colors.cyan.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 8.w),
                            child: Text("Restaurant",style: AppTextStyle.interRegular,),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            activeIndex=2;
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:activeIndex==2 ? Colors.cyan : Colors.cyan.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 8.w),
                            child: Text("Attraction",style: AppTextStyle.interRegular,),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(
                    height: 800,
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        ...List.generate(
                          activeIndex==2 ?
                            state.attractions.length :(activeIndex==1 ? state.restaurants.length : state.hotels.length),
                                (index) {
                            if(activeIndex==0){
                              return HotelItem(hotelModel: state.hotels[index], funk: () {
                                if(state.hotels[index].isFavourite==true){
                                  state.hotels[index]= state.hotels[index].copyWith(isFavourite: false);
                                  setState(() {
                                  });
                                  context.read<AllDataBloc>().add(DeleteDataEvent(state.hotels[index].hotelId));
                                }else{
                                  state.hotels[index] = state.hotels[index].copyWith(isFavourite: true);
                                  setState(() {});
                                  context.read<AllDataBloc>().add(AddDataEvent(dataId: state.hotels[index].hotelId, name: 'hotel'));
                                }
                              },);
                            }
                            if(activeIndex==1){
                              return RestaurantItem(restaurantModel: state.restaurants[index],funk: () {
                                if(state.restaurants[index].isFavourite==true){
                                  state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: false);
                                  setState(() {});
                                  context.read<AllDataBloc>().add(DeleteDataEvent(state.hotels[index].hotelId));
                                }else{
                                  state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: true);
                                  setState(() {});
                                  context.read<AllDataBloc>().add(AddDataEvent(dataId: state.hotels[index].hotelId, name: 'restaurant'));
                                }
                              },);
                            }
                                return AttractionItem(attractionModel: state.attractions[index],funk: () {
                                  if(state.attractions[index].isFavourite==true){
                                    state.attractions[index]= state.attractions[index].copyWith(isFavourite: false);
                                    setState(() {
                                    });
                                    context.read<AllDataBloc>().add(DeleteDataEvent(state.attractions[index].attractionId));
                                  }else{
                                    state.attractions[index]= state.attractions[index].copyWith(isFavourite: true);
                                    setState(() {});
                                    context.read<AllDataBloc>().add(AddDataEvent(dataId: state.attractions[index].attractionId, name: 'attraction'));
                                  }
                                });
                                }
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, AllDataState state) {  },
      ),
    );
  }
}




