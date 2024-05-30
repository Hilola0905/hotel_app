import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/atraksion/widget/atraksion_item.dart';
import '../../../utils/style/app_text_style.dart';
import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_event.dart';
import '../../bloc/all_data/all_data_state.dart';


class AttractionScreen extends StatefulWidget {
  const AttractionScreen({super.key});

  @override
  State<AttractionScreen> createState() => _AttractionScreenState();
}

class _AttractionScreenState extends State<AttractionScreen> {
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
        title: Center(child: Text("All Attraction",style: AppTextStyle.interMedium.copyWith(
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
          return  RefreshIndicator(
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
                      state.attractions.length,
                          (index) => AttractionItem(attractionModel: state.attractions[index],funk: () {
                            if(state.attractions[index].isFavourite==true){
                              state.attractions[index]= state.attractions[index].copyWith(isFavourite: false);
                              setState(() {
                              });
                              context.read<AllDataBloc>().add(DeleteDataEvent(state.attractions[index].attractionId));
                            }else{
                              print(state.attractions[index].isFavourite);
                              state.attractions[index]= state.attractions[index].copyWith(isFavourite: true);
                              setState(() {});
                              context.read<AllDataBloc>().add(AddDataEvent(dataId: state.attractions[index].attractionId, name: 'attraction'));
                            }
                          })
                  ),
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
