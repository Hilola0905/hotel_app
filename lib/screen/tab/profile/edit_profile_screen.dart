import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hotel_app/bloc/profile/profile_event.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/profile/profile_state.dart';
import '../../../data/model/response/form_status.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/contacts/app_contacts.dart';
import '../../../utils/style/app_text_style.dart';
import '../../widgets/date_time_widget.dart';
import '../../widgets/my_text_form_feilt.dart';
import '../../widgets/rounted_bottom.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String startedDate="";
  @override
  void dispose() {
    phoneNumberController.dispose();
    fullNameController.dispose();
    dateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: BlocConsumer<ProfileBloc, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            if (state.formsStatus == FormsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: 70.h,horizontal: 20.w),
              child: Column(
                children: [
                  Text(
              "Update Profile",
              style: AppTextStyle.interBold.copyWith(
                       color: AppColors.blue1,
                      fontSize: 24.w,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.text,
                    controller: phoneNumberController,
                    hintText: "Phone Number",
                    regExp: AppConstants.name,
                  ),
                  const SizedBox(height: 10,),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.text,
                    controller: fullNameController,
                    hintText: "Full Name",
                    regExp: AppConstants.emailRegExp,
                  ),
                  const SizedBox(height: 10,),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.number,
                    controller: cardController,
                    hintText: "card",
                    regExp: AppConstants.textRegExp,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     const Text(
                        "Birth Day",
                      ),
                      SizedBox(width: 20.h),
                      DatePickerItem(
                        onSelectionDate: (String value) {
                          startedDate = value;
                          setState(() {});
                        },
                        dateType: 'select day',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  Center(
                    child: SizedBox(
                      width: double.infinity*0.8 ,
                      height: 46.h,
                      child: RoundedButton(
                        text: "Update",
                        onTap: () async{
                          context.read<ProfileBloc>().add(UpdateUserProfileEvent(
                            phoneNumber: phoneNumberController.text,
                            fullName: fullNameController.text,
                            dateOfBirth: startedDate,
                            card: cardController.text,
                            email:"",
                          ));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
          listener: (BuildContext context, ProfileState state) {

          },
        )

    );
  }
}
