import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

import '../../bloc/all_data/all_data_bloc.dart';
import '../../bloc/all_data/all_data_event.dart';
import '../../bloc/all_data/all_data_state.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/contacts/app_contacts.dart';
import '../widgets/date_time_widget.dart';
import '../widgets/my_text_form_feilt.dart';
import '../widgets/rounted_bottom.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.funk});
  final String funk;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController countController=TextEditingController();
  String startedDate = "";
  String endedDate = "";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocConsumer<AllDataBloc, AllDataState>(
        builder: (BuildContext context, AllDataState state) {
          return  Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h,horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  "Booking",
                  style: AppTextStyle.interBold.copyWith(
                    color: AppColors.blue1,
                    fontSize: 24.w,
                  ),
                ),
                const SizedBox(height: 40,),
                MyTextFieldWidget(
                  keyBoardType: TextInputType.number,
                  controller: countController,
                  hintText: "People count",
                  regExp: AppConstants.phoneRegExp,
                ),
                const SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "start",
                        ),
                        SizedBox(width: 10.h),
                        DatePickerItem(
                          onSelectionDate: (String value) {
                            startedDate = value;
                            setState(() {});
                          },
                          dateType: 'start date',
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("finish",),
                        SizedBox(width: 10.h),
                        DatePickerItem(
                            onSelectionDate: (value) {
                              endedDate = value;
                              setState(() {});
                            },
                            dateType: "finish date"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40,),
                Center(
                  child: SizedBox(
                    width: double.infinity*0.8 ,
                    height: 46.h,
                    child: RoundedButton(
                        text: "Booking",
                        onTap: (){
                 context.read<AllDataBloc>().add(BookingHotelEvent(
                   numberOfPeople: countController.text, id:
                    widget.funk, willArrive: startedDate, willLeave: endedDate));
                         }

                    ),
                  ),
                ),
              ],
            ),
          );
        }, listener: (BuildContext context, AllDataState state) {
          if(state.formsStatus==FormsStatus.success){
            Fluttertoast.showToast(
                msg: "place booking",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
          }
      },),

    );
  }
}
