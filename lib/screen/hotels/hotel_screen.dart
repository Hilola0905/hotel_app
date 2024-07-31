import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/hotels/widgets/hotel_item.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_event.dart';
import '../../bloc/all_data/all_data_state.dart';


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
        backgroundColor: Colors.teal,
        systemOverlayStyle:  const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
        ),
        title: Center(child: Text("All Hotels",style: AppTextStyle.interMedium.copyWith(
          fontSize: 16.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),)),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        padding: EdgeInsets.zero,
        ),
      ),
        body: BlocConsumer<AllDataBloc, AllDataState>(
          builder: (BuildContext context, AllDataState state) {
          return RefreshIndicator(
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
                  state.hotels.length-2,
                      (index) => HotelItem(hotelModel: state.hotels[index], funk: () {
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
