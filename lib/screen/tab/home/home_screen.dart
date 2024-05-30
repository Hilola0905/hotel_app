import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/bloc/all_data/all_data_bloc.dart';
import 'package:hotel_app/bloc/all_data/all_data_event.dart';
import 'package:hotel_app/bloc/all_data/all_data_state.dart';
import 'package:hotel_app/data/model/hotel/hotel_model.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/screen/widgets/attraction_item_home.dart';
import 'package:hotel_app/screen/widgets/hotel_item_home.dart';
import 'package:hotel_app/screen/widgets/main_title.dart';
import 'package:hotel_app/screen/widgets/restaurant_item_home.dart';
import 'package:hotel_app/utils/images/app_images.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          child: Text("Let's Find The Best Place",style: AppTextStyle.interBold.copyWith(
             fontSize: 22
          ),),


        ),
      ),
      body: BlocConsumer<AllDataBloc, AllDataState>(
        builder: (BuildContext context, AllDataState state) {
          return  RefreshIndicator(
            onRefresh: () async {
              context.read<AllDataBloc>().add(AllDataByApiEvent());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(AppImages.firstImg,fit: BoxFit.cover,)),
                        ),
                        Positioned(
                          bottom: 0,
                           left: 4,
                            child: Text("Touristan",style: AppTextStyle.interSemiBold.copyWith(
                                   fontSize: 24.sp,
                                  color: Colors.white
                            ),),
                        )
                      ],
                    ),
                    MainTitle(title: "Top Hotel", funk: (){Navigator.pushNamed(context, RouteNames.hotelRoute);}),
                    SizedBox(
                      height: 190,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:  [
                          ...List.generate(state.hotels.length, (index) {
                            return  HotelItemHome(
                              hotelModel: state.hotels[index], funk: () {
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
                            },
                            );
                          })
                        ],
                      ),
                    ),
                    MainTitle(title: "Top Restaurant", funk: (){Navigator.pushNamed(context, RouteNames.restaurantRoute);}),
                    SizedBox(
                      height: 190,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(state.restaurants.length, (index) {
                            return RestaurantItemHome(restaurantModel: state.restaurants[index],  funk: () {
                              if(state.restaurants[index].isFavourite==true){
                                state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: false);
                                setState(() {});
                                context.read<AllDataBloc>().add(DeleteDataEvent(state.restaurants[index].restaurantId));
                              }else{
                                state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: true);
                                setState(() {});
                                context.read<AllDataBloc>().add(AddDataEvent(dataId: state.restaurants[index].restaurantId, name: 'restaurant'));
                              }
                            },);
                          }),
                        ],
                      ),
                    ),
                    MainTitle(title: "Top Attraction", funk: (){Navigator.pushNamed(context, RouteNames.attractionRoute);}),
                    SizedBox(
                      height: 190,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:  [
                          ...List.generate(state.attractions.length, (index) =>
                              AttractionItemHome(attractionModel: state.attractions[index],funk: () {
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
                          }))
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
