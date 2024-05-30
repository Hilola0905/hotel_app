import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import 'package:hotel_app/data/model/restaurant/restaurant_model.dart';
import 'package:hotel_app/screen/widgets/favourite_icon.dart';
import '../../../bloc/all_data/all_data_bloc.dart';
import '../../../bloc/all_data/all_data_event.dart';
import '../../../bloc/all_data/all_data_state.dart';
import '../../../data/model/hotel/hotel_model.dart';
import '../../../utils/style/app_text_style.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
        title: Center(
          child: Text("All The Favourite Place",style: AppTextStyle.interBold.copyWith(
              fontSize: 22
          ),),
        ),
      ),
      body: BlocConsumer<AllDataBloc, AllDataState>(
        builder: (BuildContext context, AllDataState state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<AllDataBloc>().add(AllDataByApiEvent());
            },
            child: ListView(
              children: [
                SizedBox(height: 20.h,),
               ...List.generate(state.hotels.length, (index) {
                 HotelModel hotel=state.hotels[index];
                 if(state.hotels[index].isFavourite==true){
                   return FavouriteIcon(imageUrl: hotel.images[0], title: hotel.hotelName, rate: hotel.rating, funk: () {  }, funkMap: () {  }, isFavourite: hotel.isFavourite, city: hotel.locationModel.city,);
                 }
                 return const SizedBox();
               }),
               ...List.generate(state.restaurants.length, (index) {
                 RestaurantModel restaurant=state.restaurants[index];
                 if(restaurant.isFavourite==true){
                   return  FavouriteIcon(imageUrl: restaurant.images[0], title: restaurant.restaurantName, rate: restaurant.rating, funk: (){}, funkMap: (){}, isFavourite: restaurant.isFavourite, city: "");
                 }
                 return const SizedBox();
               }),
                ...List.generate(state.attractions.length, (index) {
                  AttractionModel attraction=state.attractions[index];
                  if(attraction.isFavourite==true){
                    return FavouriteIcon(imageUrl: attraction.images[0], title: attraction.attractionName, rate: attraction.rating, funk: (){}, funkMap: (){}, isFavourite: attraction.isFavourite, city: "");
                  }
                  return const SizedBox();
                })

              ],
            ),
          );
        },
        listener: (BuildContext context, AllDataState state) {  },
      ),
    );
  }
}
