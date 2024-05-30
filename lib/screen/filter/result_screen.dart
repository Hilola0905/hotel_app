import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/data/model/filter/filter.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import '../../../bloc/all_data/all_data_bloc.dart';
import '../../../bloc/all_data/all_data_event.dart';
import '../../../bloc/all_data/all_data_state.dart';
import '../../utils/style/app_text_style.dart';
import '../atraksion/widget/atraksion_item.dart';
import '../hotels/widgets/hotel_item.dart';
import '../restaurant/widgets/retaurant_item.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.filter});
  final FilterItemModel1 filter;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}


class _ResultScreenState extends State<ResultScreen> {
  int activeIndex=0;
  @override
  void initState() {
     _init();
    super.initState();
  }

  _init() async{
    Future.value(const Duration(seconds: 2));
    context.read<AllDataBloc>().add(FilterDataEvent(
      city: widget.filter.city,
      country: widget.filter.country,
      province: widget.filter.province,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocConsumer<AllDataBloc, AllDataState>(
        builder: (BuildContext context, AllDataState state) {
          if(state.formsStatus==FormsStatus.error){
            return Center(
              child: Text("Data topilmadi",style: AppTextStyle.interBold,),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
                context.read<AllDataBloc>().add(AllDataByApiEvent());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
                child: Column(
                  children: [
                    SizedBox(height: 30.h,),
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
                                  if(state.hotels.isEmpty){
                                    return Center(
                                      child: Text("Data topilmadi",style: AppTextStyle.interBold,),
                                    );
                                  }
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
                                  if(state.restaurants.length==0){
                                    return Center(
                                      child: Text("Data topilmadi",style: AppTextStyle.interBold,),
                                    );
                                  }
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
                                if(activeIndex==2){
                                  if(state.hotels.isEmpty){
                                    return Center(
                                      child: Text("Data topilmadi",style: AppTextStyle.interBold,),
                                    );
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
                                return SizedBox();
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
        listener: (BuildContext context, AllDataState state) {

        },
      ),
    );
  }
}
