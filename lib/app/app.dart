
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/bloc/bottom/bottom_bloc.dart';

import '../screen/route.dart';





class App extends StatelessWidget {
  App({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(providers: [
      BlocProvider(create: (context) => BottomBloc()),
    ],
        child:ScreenUtilInit(
            designSize: const Size(260, 820),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
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


