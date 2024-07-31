import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_app/data/model/attraction/attraction_model.dart';
import 'package:hotel_app/data/model/hotel/hotel_model.dart';
import 'package:hotel_app/data/model/restaurant/restaurant_model.dart';
import 'package:hotel_app/screen/atraksion/atraksion_screen.dart';
import 'package:hotel_app/screen/auth/register_screen.dart';
import 'package:hotel_app/screen/booking/all_booking_screen.dart';
import 'package:hotel_app/screen/booking/booking_screen.dart';
import 'package:hotel_app/screen/filter/filter_screen.dart';
import 'package:hotel_app/screen/filter/result_screen.dart';
import 'package:hotel_app/screen/hotels/hotel_screen.dart';
import 'package:hotel_app/screen/map/map_screen.dart';
import 'package:hotel_app/screen/on_boarding/first.dart';
import 'package:hotel_app/screen/restaurant/restaurant_detail_screen.dart';
import 'package:hotel_app/screen/restaurant/restaurant_screen.dart';
import 'package:hotel_app/screen/splash/splash_screen.dart';
import 'package:hotel_app/screen/tab/profile/edit_profile_screen.dart';
import 'package:hotel_app/screen/tab/tab_screen.dart';
import '../data/model/filter/filter.dart';
import 'atraksion/atraksion_detail_screen.dart';
import 'auth/login_screen.dart';
import 'hotels/hotel_detail_screen.dart';
import 'no_internet/no_internet_screen.dart';
import 'on_boarding/ob_boarding_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());
      case RouteNames.noInternetRoute:
        return navigate(NoInternetScreen(
            onInternetComeBack: settings.arguments as VoidCallback));
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
    case RouteNames.register:
        return navigate(const RegisterScreen());
    case RouteNames.loginScreen:
        return navigate(const LoginScreen());
    case RouteNames.tabRoute:
        return navigate(const TabScreen());
        case RouteNames.hotelDetailRoute:
        return navigate( HotelDetailScreen(hotelModel: settings.arguments as HotelModel,));
        case RouteNames.attractionDetailRoute:
        return navigate(AttractionDetailScreen(attractionModel: settings.arguments as AttractionModel,));
        case RouteNames.restaurantDetailRoute:
        return navigate( RestaurantDetailScreen(restaurantModel: settings.arguments as RestaurantModel,));
      case RouteNames.firstRoute:
        return navigate(const FirstScreen());
        case RouteNames.hotelRoute:
        return navigate(const HotelScreen());
        case RouteNames.restaurantRoute:
        return navigate(const RestaurantScreen());
        case RouteNames.attractionRoute:
        return navigate(const AttractionScreen());
        case RouteNames.filterRoute:
        return navigate( FilterScreen(filters: settings.arguments as FilterItemModel,));
      case RouteNames.mapRoute:
        return navigate( GoogleMapsScreen(latLng: settings.arguments as LatLng));
        case RouteNames.resultRoute:
        return navigate( ResultScreen(filter: settings.arguments as FilterItemModel1));
        case RouteNames.editProfileRoute:
        return navigate(  const EditProfileScreen());
        case RouteNames.bookingRoute:
        return navigate( BookingScreen(funk: settings.arguments as String,));
        case RouteNames.allBookingRoute:
        return navigate( const AllBookingScreen());

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}


class RouteNames {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String tabRoute = "/tab_route";
  static const String hotelRoute = "/hotel_route";
  static const String resultRoute = "/result_route";
  static const String mapRoute = "/map_route";
  static const String restaurantRoute = "/restaurant_route";
  static const String attractionRoute = "/attraction_route";
  static const String register = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String hotelDetailRoute = "/hotel_detail_route";
  static const String restaurantDetailRoute = "/restaurant_detail_route";
  static const String attractionDetailRoute = "/atraksion_detail_route";
  static const String onBoardingRoute = "/on_boarding_route";
  static const String firstRoute = "/first_route";
  static const String filterRoute = "/filter_route";
  static const String bookingRoute = "/booking_route";
  static const String taskRoute = "/task_route";
  static const String allBookingRoute = "/all_booking_route";
  static const String editProfileRoute = "/edit_profile_route";
}
