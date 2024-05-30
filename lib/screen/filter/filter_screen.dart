import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';
import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_state.dart';
import '../../data/model/filter/filter.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.filters,});
  final FilterItemModel filters;
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int countryIndex=-1;
  int cityIndex=-1;
  int provinceIndex=-1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
      padding:  EdgeInsets.symmetric(vertical: 40.h,horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h,),
          Text(
            "country",style: AppTextStyle.interBold.copyWith(),),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: GridView.count(
              crossAxisCount:3,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
              children: [
                ...List.generate(widget.filters.country.length, (index) => Ink(
                  padding: EdgeInsets.symmetric(vertical: 24.h) ,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                    onTap: (){
                        if(countryIndex==index){
                          countryIndex=-1;
                        }
                        else{
                          countryIndex=index;
                        }
                        setState(() {

                        });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: countryIndex ==index ? Colors.cyan : Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(widget.filters.country[index])),
                    ),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Text(
            "city",style: AppTextStyle.interBold.copyWith(),),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: GridView.count(
              crossAxisCount:3,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
              children: [
                ...List.generate(widget.filters.city.length, (index) => Ink(
                  padding: EdgeInsets.symmetric(vertical: 24.h) ,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: (){
                      if(cityIndex==index){
                        cityIndex=-1;
                      }
                      else{
                        cityIndex=index;
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: cityIndex ==index ? Colors.cyan : Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(widget.filters.city[index])),
                    ),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Text(
            "state province",style: AppTextStyle.interBold.copyWith(),),
          SizedBox(height: 10.h,),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: GridView.count(
              crossAxisCount:3,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.w,
              children: [
                ...List.generate(widget.filters.province.length, (index) => Ink(
                  padding: EdgeInsets.symmetric(vertical: 24.h) ,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: (){
                      if(provinceIndex==index){
                        provinceIndex=-1;
                      }
                      else{
                        provinceIndex=index;
                      }
                      setState(() {

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: provinceIndex ==index ? Colors.cyan :Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(widget.filters.province[index])),
                    ),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          BlocBuilder<AllDataBloc, AllDataState>(
              builder: (BuildContext context, AllDataState state) {
              return    Center(
                  child: InkWell(
                    onTap: (){

                      Navigator.pushReplacementNamed(context, RouteNames.resultRoute,arguments: FilterItemModel1(
                        country: countryIndex==-1 ? "" : widget.filters.country[countryIndex],
                        city: cityIndex==-1? "": widget.filters.city[cityIndex],
                        province: provinceIndex==-1 ? "":widget.filters.province[provinceIndex],
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 25.h,horizontal: 40.w),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text("Filter",style: AppTextStyle.interBlack.copyWith(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                );
              }
          )

        ],
      ),
    ),
    );
  }
}

