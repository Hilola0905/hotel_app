import 'package:equatable/equatable.dart';

abstract class AllDataEvent extends Equatable {}
class AllDataByApiEvent extends AllDataEvent{
  AllDataByApiEvent();
  @override
  List<Object?> get props => [];
}
class AllDataByLocalEvent extends AllDataEvent{
  AllDataByLocalEvent();
  @override
  List<Object?> get props => [];
}
class AddDataEvent extends AllDataEvent{
  final String dataId;
  final String name;
  AddDataEvent({
    required this.dataId,
    required this.name
});
  @override
  List<Object?> get props => [
        dataId.hashCode,
        name.hashCode
  ];
}
class BookingHotelEvent extends AllDataEvent{
  final String numberOfPeople;
  final String id;
  final String willArrive;
  final String willLeave;
  BookingHotelEvent({
    required  this.numberOfPeople,
    required  this.id,
    required  this.willArrive,
    required  this.willLeave,
});
  @override
  List<Object?> get props => [
    DateTime.november.hashCode
  ];
}
class BookingRestaurantEvent extends AllDataEvent{
  final String numberOfPeople;
  final String id;
  final String willArrive;
  final String willLeave;
  BookingRestaurantEvent({
    required  this.numberOfPeople,
    required  this.id,
    required  this.willArrive,
    required  this.willLeave,
  });
  @override
  List<Object?> get props => [
    DateTime.november.hashCode
  ];
}
class BookingAttractionEvent extends AllDataEvent{
  final String numberOfPeople;
  final String id;
  final String willArrive;
  final String willLeave;
  BookingAttractionEvent({
    required  this.numberOfPeople,
    required  this.id,
    required  this.willArrive,
    required  this.willLeave,
  });
  @override
  List<Object?> get props => [
    DateTime.november.hashCode
  ];
}
class DeleteDataEvent extends AllDataEvent{
  final String id;
  DeleteDataEvent(this.id);
  @override
  List<Object?> get props => [
    id.hashCode,
  ];
}
class FilterDataEvent extends AllDataEvent{
  final String? country;
  final String? city;
  final String? province;
  FilterDataEvent({this.country,this.city,this.province});
  @override
  List<Object?> get props => [
    city.hashCode,
    country.hashCode,
    province.hashCode
  ];
}
class SearchDataEvent extends AllDataEvent{
  final String title;
  SearchDataEvent(this.title);
  @override
  List<Object?> get props => [
    title.hashCode,
  ];
}
