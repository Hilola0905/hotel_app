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



class AllDataBloc extends Bloc<AllDataEvent, AllDataState> {
  AllDataBloc() :
        super(
          const  AllDataState(
              errorMessage: "",
              formsStatus: FormsStatus.pure,
              statusMessage: "", restaurants: [], hotels: [], attractions: [])) {
    on<AllDataByLocalEvent>(_allDataByLocal);
    on<AllDataByApiEvent>(_allDataByApi);
    on<AddDataEvent>(_add);
    on<DeleteDataEvent>(_delete);
    on<FilterDataEvent>(_filterByApi);
    on<SearchDataEvent>(_searchByApi);
    on<BookingAttractionEvent>(_bookingAttraction);
    on<BookingHotelEvent>( _bookingHotel);
    on<BookingRestaurantEvent>(_bookingRestaurant);
  }


  _allDataByApi(AllDataByApiEvent event,  emit ) async {
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
  _filterByApi(FilterDataEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.filterHotel(country: event.country, city: event.city, stateProvince : event.province);
    NetworkResponse networkResponseRestaurant= await ApiProvider.filterRestaurant(country: event.country, city: event.city, stateProvince : event.province);
    NetworkResponse networkResponseAttraction= await ApiProvider.filterAttraction(country: event.country, city: event.city, stateProvince : event.province);
    final  allTasks = await LocalDatabase.getAllTasks();
    List<HotelModel> hotels=(networkResponseHotel.data as List? ?? []).map((e) => HotelModel.fromJson(e)).toList();
    List<AttractionModel> attractions=(networkResponseAttraction.data as List? ?? []).map((e) => AttractionModel.fromJson(e)).toList();
    List<RestaurantModel> restaurant=(networkResponseRestaurant.data as List? ?? []).map((e) => RestaurantModel.fromJson(e)).toList();
    print(hotels);
    print(attractions);
    print(restaurant);
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
  _searchByApi(SearchDataEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.searchHotel(name: event.title);
    NetworkResponse networkResponseRestaurant= await ApiProvider.searchRestaurant(name: event.title);
    NetworkResponse networkResponseAttraction= await ApiProvider.searchAttraction(name: event.title);
    List<HotelModel> hotels=[];
    List<AttractionModel> attractions=[];
    List<RestaurantModel> restaurant=[];
    final  allTasks = await LocalDatabase.getAllTasks();
    if(networkResponseHotel.errorText.isEmpty){
       hotels=(networkResponseHotel.data as List? ?? []).map((e) => HotelModel.fromJson(e)).toList();
    }
    if(networkResponseAttraction.errorText==""){
      attractions=(networkResponseAttraction.data as List? ?? []).map((e) => AttractionModel.fromJson(e)).toList();
    }
    if(networkResponseRestaurant.errorText==""){
       restaurant=(networkResponseRestaurant.data as List? ?? []).map((e) => RestaurantModel.fromJson(e)).toList();
    }
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
  _bookingHotel(BookingHotelEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.bookingHotel(
        numberOfPeople: event.numberOfPeople,
        id: event.id,
        willArrive: event.willArrive,
        willLeave: event.willLeave
    );

    if(networkResponseHotel.errorText==""){
      emit(
          state.copyWidth(
            formsStatus:  FormsStatus.success,
            attractions : null,
            hotels : null,
            restaurants: null,
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
  _bookingRestaurant(BookingRestaurantEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.bookingRestaurant(
        numberOfPeople: event.numberOfPeople,
        id: event.id,
        willArrive: event.willArrive,
        willLeave: event.willLeave
    );

    if(networkResponseHotel.errorText==""){
      emit(
          state.copyWidth(
            formsStatus:  FormsStatus.success,
            attractions : null,
            hotels : null,
            restaurants: null,
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
  _bookingAttraction(BookingAttractionEvent event,  emit ) async {
    emit(state.copyWidth(formsStatus:  FormsStatus.loading,));
    NetworkResponse networkResponseHotel= await ApiProvider.bookingAttraction(
        numberOfPeople: event.numberOfPeople,
        id: event.id,
        willArrive: event.willArrive,
        willLeave: event.willLeave
    );

    if(networkResponseHotel.errorText==""){
      emit(
          state.copyWidth(
            formsStatus:  FormsStatus.success,
            attractions : null,
            hotels : null,
            restaurants: null,
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
  _delete(DeleteDataEvent event,  emit ) async {
    int id=0;
   var data= await LocalDatabase.getAllTasks();
   for(DataModel i in data){
     if(i.modelId==event.id){
       id=i.id ?? 0;
     }
   }
   int deleteId= await   LocalDatabase.deleteTask(id);
   debugPrint(deleteId.toString());
    emit(state.copyWidth(
      formsStatus: FormsStatus.success,
    ));
  }
  _allDataByLocal(AllDataByLocalEvent event,  emit ) async {
     LocalDatabase.getAllTasks();
     emit(state.copyWidth(
         formsStatus: FormsStatus.success
     ));
  }
  _add(AddDataEvent event,  emit ) async {
    DataModel data=DataModel(id: null, name: event.name, modelId: event.dataId);
    LocalDatabase.insertTask(data);
    emit(state.copyWidth(
        formsStatus: FormsStatus.success
    ));
  }
}
