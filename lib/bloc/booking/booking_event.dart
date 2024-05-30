import 'package:equatable/equatable.dart';

abstract class AllBookingDataEvent extends Equatable {}

class AllBookingDataByApiEvent extends AllBookingDataEvent{
  AllBookingDataByApiEvent();
  @override
  List<Object?> get props => [];
}


