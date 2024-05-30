
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotel_app/screen/tab/catgory/category_screen.dart';
import 'package:hotel_app/screen/tab/fourite/fovourite_screen.dart';
import 'package:hotel_app/screen/tab/home/home_screen.dart';
import 'package:hotel_app/screen/tab/profile/profile_screen.dart';

import '../../bloc/bottom/bottom_bloc.dart';
import '../../bloc/bottom/bottom_event.dart';
import '../../bloc/bottom/bottom_state.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../hotels/hotel_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {



  final List<Widget> screens = [
   const  HomeScreen(),
   const  FavouriteScreen(),
   const  CategoryScreen(),
   const  ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBloc, BottomState>(
        builder: (context, state) {
          return Stack(
            children: [
              IndexedStack(
                index: state.index,
                children: screens,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, BottomState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: AppColors.cFF6B2C,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              switch (index) {
                case 0:
                  {
                    context.read<BottomBloc>().add(BottomEvent(index: 0));
                    break;
                  }
                case 1:
                  {
                    context.read<BottomBloc>().add(BottomEvent(index: 1));
                    break;
                  }
                case 2:
                  {
                    context.read<BottomBloc>().add(BottomEvent(index: 2));
                    break;
                  }
                case 3:
                  {
                    context.read<BottomBloc>().add(BottomEvent(index: 3));
                    break;
                  }

              }
            },
            items: [
              const BottomNavigationBarItem(
                activeIcon: Icon(Icons.home,color: AppColors.c0D0140,),
                icon: Icon(Icons.home,color: Colors.grey,),
                label: "",
              ),
              const  BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite,color: AppColors.c0D0140,
                  ),
                icon: Icon(Icons.favorite,),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.category,
                  colorFilter: const ColorFilter.mode(
                  AppColors.c0D0140, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.category,
                  colorFilter: const ColorFilter.mode(
                      Colors.grey, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                label: "",
              ),
             const  BottomNavigationBarItem(
                activeIcon: Icon(Icons.person,color: AppColors.c0D0140,),
                icon:Icon(Icons.person,color: Colors.grey,),
                label: "",
              ),
            ],
          );
        },
      ),
    );
  }

}
