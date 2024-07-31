import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/restaurant/widgets/retaurant_item.dart';

import '../../../utils/style/app_text_style.dart';
import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_event.dart';
import '../../bloc/all_data/all_data_state.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.teal,
        systemOverlayStyle:  const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light
        ),
        title: Center(child: Text("All Restaurant",style: AppTextStyle.interMedium.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600
        ),)),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),),

        ),
        body: BlocConsumer<AllDataBloc, AllDataState>(
          builder: (BuildContext context, AllDataState state) {
            return  RefreshIndicator(
              onRefresh: () async {
                context.read<AllDataBloc>().add(AllDataByApiEvent());
              },
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                child:
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  children: [
                    ...List.generate(
                        state.restaurants.length,
                            (index) => RestaurantItem(restaurantModel: state.restaurants[index],
                              funk: () {
                                if(state.restaurants[index].isFavourite==true){
                                  state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: false);
                                  setState(() {});
                                  context.read<AllDataBloc>().add(DeleteDataEvent(state.restaurants[index].restaurantId));
                                }
                                else{
                                  state.restaurants[index]= state.restaurants[index].copyWith(isFavourite: true);
                                  setState(() {});
                                  context.read<AllDataBloc>().add(AddDataEvent(dataId: state.restaurants[index].restaurantId, name: 'restaurant'));
                                }
                              },
                            )),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, AllDataState state) {  },
        )
    );
  }
}
