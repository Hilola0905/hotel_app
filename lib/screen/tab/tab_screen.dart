import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/tab/atraksion/atraksion_screen.dart';
import 'package:hotel_app/screen/tab/hotels/hotel_screen.dart';
import 'package:hotel_app/screen/tab/restaurant/restaurant_screen.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import '../../bloc/bottom/bottom_bloc.dart';
import '../../bloc/bottom/bottom_event.dart';
import '../../bloc/bottom/bottom_state.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  List<Widget> screens = [
  const HotelScreen(),
  const RestaurantScreen(),
  const  AtraksionScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBloc,BottomState>(
      builder: (BuildContext context,BottomState state){
        return Scaffold(
          body: screens[state.index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) {
              context.read<BottomBloc>().add(BottomEvent(index: index));
            },
            selectedFontSize: 12.sp,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.orange.withOpacity(0.5),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel_class,color: Colors.orangeAccent,),
                label: "Hotel",
                activeIcon: Icon(Icons.hotel_class,color: Colors.orange,),

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_sharp,color: Colors.orangeAccent),
                label: "Restaurant",
                activeIcon: Icon(Icons.restaurant_menu_sharp,color: Colors.orange),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_parking_outlined,color: Colors.orangeAccent),
                label: "Atraksion",
                activeIcon: Icon(Icons.local_parking_outlined,color: Colors.orange),
              ),

            ],
          ),
        );
      },
    );

  }
}
