import 'package:flutter/material.dart';
import 'package:hotel_app/screen/auth/register_screen.dart';
import 'package:hotel_app/screen/splash/splash_screen.dart';
import 'package:hotel_app/screen/tab/atraksion/atraksion_detail_screen.dart';
import 'package:hotel_app/screen/tab/hotels/hotel_detail_screen.dart';
import 'package:hotel_app/screen/tab/restaurant/restaurant_detail_screen.dart';
import 'package:hotel_app/screen/tab/tab_screen.dart';
import 'auth/login_screen.dart';
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
        return navigate(const HotelDetailScreen());
        case RouteNames.atraksionDetailRoute:
        return navigate(const AtraksionDetailScreen());
        case RouteNames.restaurantDetailRoute:
        return navigate(const RestaurantDetailScreen());

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
  static const String register = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String hotelDetailRoute = "/hotel_detail_route";
  static const String restaurantDetailRoute = "/restaurant_detail_route";
  static const String atraksionDetailRoute = "/atraksion_detail_route";
  static const String onBoardingRoute = "/on_boarding_route";
}
