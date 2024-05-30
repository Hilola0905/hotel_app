import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/hotels/widgets/hotel_item.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_event.dart';
import '../../bloc/all_data/all_data_state.dart';
import '../../data/model/hotel/hotel_model.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.cyan.withOpacity(0.2),
        systemOverlayStyle:  const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
        title: Center(child: Text("All Hotels",style: AppTextStyle.interMedium.copyWith(
          fontSize: 18.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600
        ),)),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: Colors.black,),),
      ),
        body: BlocConsumer<AllDataBloc, AllDataState>(
    builder: (BuildContext context, AllDataState state) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<AllDataBloc>().add(AllDataByApiEvent());
        },
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
          child:
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              ...List.generate(
                  state.hotels.length,
                      (index) => HotelItem(hotelModel: state.hotels[index], funk: () {
                        List<HotelModel> hotels=state.hotels;
                        if(state.hotels[index].isFavourite==true){
                          state.hotels[index]= state.hotels[index].copyWith(isFavourite: false);
                          setState(() {
                          });
                          context.read<AllDataBloc>().add(DeleteDataEvent(state.hotels[index].hotelId));
                        }else{
                          state.hotels[index] = state.hotels[index].copyWith(isFavourite: true);
                          setState(() {});
                          context.read<AllDataBloc>().add(AddDataEvent(dataId: state.hotels[index].hotelId, name: 'hotel'));
                        }
                      },)),
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
