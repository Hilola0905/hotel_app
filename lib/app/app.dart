
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/bloc/all_data/all_data_bloc.dart';
import 'package:hotel_app/bloc/all_data/all_data_event.dart';
import 'package:hotel_app/bloc/auth/auth_bloc.dart';
import 'package:hotel_app/bloc/bottom/bottom_bloc.dart';
import 'package:hotel_app/bloc/profile/profile_event.dart';
import '../bloc/profile/profile_bloc.dart';
import '../screen/route.dart';


class App extends StatelessWidget {
  App({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(providers: [
      BlocProvider(create: (context) => BottomBloc()),
      BlocProvider(create: (context)=>AuthBloc()),
      BlocProvider(create: (context)=>ProfileBloc()),
      BlocProvider(create: (context)=>AllDataBloc()..add(AllDataByApiEvent()))
    ],
        child:ScreenUtilInit(
            designSize: const Size(260, 820),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_ , child) {
              return  MaterialApp(
                theme: ThemeData(
                    useMaterial3: false
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: RouteNames.splashScreen,
                navigatorKey: navigatorKey,
                onGenerateRoute: AppRoutes.generateRoute,
              );
            }
        )
    );
  }

}


