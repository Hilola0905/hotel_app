import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/data/local/storage_repository.dart';
import 'package:hotel_app/data/model/response/form_status.dart';
import 'package:hotel_app/screen/route.dart';
import 'package:hotel_app/utils/size/screen_utils.dart';
import 'package:hotel_app/utils/style/app_text_style.dart';

import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/profile/profile_event.dart';
import '../../../bloc/profile/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLogin=StorageRepository.getBool(key: "isLogin");

  @override
  void initState() {
    Future.microtask(() =>  context.read<ProfileBloc>().add(GetUserProfileEvent()));

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        builder: (BuildContext context, ProfileState state) {
          print(state);
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (
          state.formsStatus == FormsStatus.authenticated || state.formsStatus == FormsStatus.success
          ) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 70.h, horizontal: 20.w),
              child:
              isLogin == true ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {

                      },
                          icon: const Icon(Icons.shopping_basket)),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                          bottom: 10.h,
                          right: 30.w,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),

                              width: 30.w,
                              height: 30.w,
                              child: Center(child: IconButton(onPressed: () {},
                                icon: const Icon(Icons.edit),
                                padding: EdgeInsets.zero,))))
                    ],
                  ),
                  SizedBox(height: 50.h,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.h, horizontal: 20.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.w)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Name : ",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black54
                              ),),
                            Text(state.user!.fullName.length>=20? "${state.user!.fullName.substring(0,20)}.." : state.user!.fullName,
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black
                              ),)
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text("Phone : ",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black54
                              ),),
                            Text(state.user!.phoneNumber,
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black
                              ),)
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text("Email : ",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black54
                              ),),
                            Text(state.user!.email.length>=20 ? "${state.user!.email.substring(0,20)}.." : state.user!.email,
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black
                              ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          StorageRepository.setBool(
                              key: "isLogin", value: false);
                          StorageRepository.setString(
                              key: "access_token", value: "");
                          StorageRepository.setString(
                              key: "refresh_token", value: "");
                          Navigator.pushNamedAndRemoveUntil(
                              context, RouteNames.firstRoute, (route) => false);
                        },
                        borderRadius: BorderRadius.circular(10.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.cyan.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.logout),
                              SizedBox(width: 10.w,),
                              Text("log out",
                                style: AppTextStyle.interMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      InkWell(
                        borderRadius: BorderRadius.circular(10.w),
                        onTap: () {
                          print(StorageRepository.getString(key: "access_token"));
                          Navigator.pushNamed(
                              context, RouteNames.editProfileRoute);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            color: Colors.cyan.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.w),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.edit),
                              SizedBox(width: 10.w,),
                              Text("Edit Profile",
                                style: AppTextStyle.interMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Ink(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: InkWell(
                          onTap: () {
                            StorageRepository.setBool(
                                key: "isEnter3", value: false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteNames.register, (route) => false);
                          },
                          borderRadius: BorderRadius.circular(28),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 35.w),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                    color: Colors.cyan.withOpacity(0.3))
                            ),
                            child: Text("Sign up",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16
                              ),),
                          ),
                        ),
                      ),
                      Ink(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: InkWell(
                          onTap: () {
                            StorageRepository.setBool(
                                key: "isEnter3", value: false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, RouteNames.loginScreen, (
                                route) => false);
                          },
                          borderRadius: BorderRadius.circular(28),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 35.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: Colors.black)
                            ),
                            child: Text("Sign in",
                              style: AppTextStyle.interMedium.copyWith(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container();
        }, listener: (BuildContext context, ProfileState state) {
         if(state.formsStatus==FormsStatus.success){
           print(state);
         }
      },
      )


    );
  }
}
