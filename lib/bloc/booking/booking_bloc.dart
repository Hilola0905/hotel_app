import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/bloc/all_data/all_data_event.dart';
import 'package:hotel_app/bloc/all_data/all_data_state.dart';
import 'package:hotel_app/data/local/local_database.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import 'package:hotel_app/data/model/data_model.dart';
import 'package:hotel_app/data/model/hotel/hotel_model.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import 'package:hotel_app/data/model/response/network_response.dart';
import 'package:hotel_app/data/model/restaurant/restaurant_model.dart';
import 'package:hotel_app/data/network/api_provider.dart';

import 'booking_event.dart';
import 'booking_state.dart';



class AllBookingDataBloc extends Bloc<AllBookingDataEvent, AllBookingDataState> {
  AllBookingDataBloc() :
        super(
          const  AllBookingDataState(
              errorMessage: "",
              formsStatus: FormsStatus.pure,
              statusMessage: "", restaurants: [], hotels: [], attractions: [])) {
    on<AllBookingDataByApiEvent>(_allBookingDataByApi);

  }


  _allBookingDataByApi(AllBookingDataByApiEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.getAllHotel();
    NetworkResponse networkResponseRestaurant= await ApiProvider.getAllRestaurant();
    NetworkResponse networkResponseAttraction= await ApiProvider.getAllAttraction();
    final  allTasks = await LocalDatabase.getAllTasks();
    List<HotelModel> hotels=(networkResponseHotel.data as List? ?? []).map((e) => HotelModel.fromJson(e)).toList();
    List<AttractionModel> attractions=(networkResponseAttraction.data as List? ?? []).map((e) => AttractionModel.fromJson(e)).toList();
    List<RestaurantModel> restaurant=(networkResponseRestaurant.data as List? ?? []).map((e) => RestaurantModel.fromJson(e)).toList();
    for(DataModel i in allTasks){
      if(i.name=="hotel"){
        for(int j=0;j<hotels.length;j++){
          if(i.modelId==hotels[j].hotelId){
            hotels[j]=hotels[j].copyWith(
              isFavourite: true,
            );
          }
        }
      }
      if(i.name=="restaurant"){
        for(int j=0;j<restaurant.length;j++){
          if(i.modelId==restaurant[j].restaurantId){
            restaurant[j]=restaurant[j].copyWith(
              isFavourite: true,
            );
          }
        }

      }
      if(i.name=="attraction"){
        for(int j=0;j<attractions.length;j++){
          if(i.modelId==attractions[j].attractionId){
            attractions[j]=attractions[j].copyWith(
              isFavourite: true,
            );
          }
        }
      }
    }

    if(networkResponseAttraction.errorText=="" && networkResponseRestaurant.errorText=="" && networkResponseHotel.errorText==""){
      emit(
          state.copyWidth(
            formsStatus:  FormsStatus.success,
            attractions : attractions,
            hotels : hotels,
            restaurants: restaurant,
          )
      );
    }
    else{
      emit(
          state.copyWidth(
            formsStatus:  FormsStatus.error, )
      );
    }
  }


}
