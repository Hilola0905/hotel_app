
import 'package:equatable/equatable.dart';
import '../../data/model/attraction/attraction_model.dart';
import '../../data/model/hotel/hotel_model.dart';
import '../../data/model/response/form_status.dart';
import '../../data/model/restaurant/restaurant_model.dart';
class AllDataState extends Equatable {

  final FormsStatus formsStatus;
  final List<AttractionModel> attractions;
  final List<HotelModel> hotels;
  final List<RestaurantModel> restaurants;
  final String errorMessage;
  final String statusMessage;

  const AllDataState( {
    required this.errorMessage,
    required this.formsStatus,
    required this.statusMessage,
    required this.restaurants,
    required this.hotels,
    required this.attractions,
  });
  AllDataState copyWidth({
      FormsStatus? formsStatus,
      String? errorMessage,
      String? statusMessage,
      List<AttractionModel>? attractions,
      List<HotelModel>? hotels,
     List<RestaurantModel>? restaurants,
} ){
    return AllDataState(
      errorMessage: errorMessage ?? this.errorMessage,
      formsStatus: formsStatus ?? this.formsStatus,
      statusMessage: statusMessage ?? this.statusMessage,
      restaurants: restaurants ?? this.restaurants,
      hotels: hotels ?? this.hotels,
      attractions: attractions ?? this.attractions
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
    statusMessage,
    errorMessage,
    formsStatus,
    attractions,
    hotels,
    restaurants
  ];

}

