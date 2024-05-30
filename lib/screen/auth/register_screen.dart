
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/bloc/auth/auth_event.dart';
import 'package:hotel_app/data/local/storage_repository.dart';
import 'package:hotel_app/utils/contacts/app_contacts.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../data/model/response/form_status.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/size/screen_utils.dart';
import '../../utils/style/app_text_style.dart';
import '../route.dart';
import '../widgets/my_text_form_feilt.dart';
import '../widgets/rounted_bottom.dart';




class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController verifyPasswordController=TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
              if(state.formsStatus==FormsStatus.unVerify || state.formsStatus==FormsStatus.verifyError){
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.w,horizontal: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Enter Pasword",
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.blue1,
                            fontSize: 24.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h,),
                      Center(
                        child: Text(
                          "A password has been sent to your email address, please enter that password",
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.blue1,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                       SizedBox(height: 50.h,),
                      MyTextFieldWidget(
                        keyBoardType: TextInputType.text,
                        controller: verifyPasswordController,
                        hintText: "enter password",
                        regExp: RegExp(""),
                      ),
                      SizedBox(height: 50.h,),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          height: 46.h,
                          child: RoundedButton(
                            text: "Verify",
                            onTap: (){
                              context.read<AuthBloc>().add(
                                  VerifyRegisterEvent(
                                      emailController.text,
                                      verifyPasswordController.text,
                                  )
                                  );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h,),
                      GestureDetector(
                        onTap: () {
                         context.read<AuthBloc>().add(CheckedInitialEvent());
                        },
                        child: Row(
                          children: [
                            Text(
                              "Register",
                              style: AppTextStyle.interMedium
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            const SizedBox(width: 10,),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.secondaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if(state.formsStatus==FormsStatus.loading){
                return const  Center(child:  CircularProgressIndicator());
              }
              return  SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Register",
                          style: AppTextStyle.interBold.copyWith(
                            color: AppColors.blue1,
                            fontSize: 32.w,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      MyTextFieldWidget(
                        keyBoardType: TextInputType.text,
                        controller: nameController,
                        hintText: "Full  Name",
                        regExp: AppConstants.name,
                      ),
                      MyTextFieldWidget(
                        keyBoardType: TextInputType.text,
                        controller: emailController,
                        hintText: "Email",
                        regExp: AppConstants.emailRegExp,
                      ),
                      MyTextFieldWidget(
                        isObscureText: true,
                        keyBoardType: TextInputType.text,
                        controller: passwordController,
                        hintText: "Password",
                        regExp: AppConstants.passwordRegExp,
                      ),
                      MyTextFieldWidget(
                        isObscureText: true,
                        keyBoardType: TextInputType.text,
                        controller: confirmController,
                        hintText: "Confirm Password",
                        regExp: AppConstants.passwordRegExp,
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          height: 46.h,
                          child: RoundedButton(
                            text: "Register",
                            onTap: (){
                              if(
                              confirmController.text==passwordController.text && passwordController.text!=""
                              ){
                                if(nameController.text!="" && emailController.text!=""){
                                  context.read<AuthBloc>().add(
                                      UnVerifyRegisterEvent(
                                        passwordController.text,
                                        nameController.text,
                                        emailController.text,
                                      ));
                                }
                              }
                             else{
                                Fluttertoast.showToast(
                                    msg: "Ma'lumotlar bo'sh bo'lmasligi va kiriting parollaringiz bir xil bo'lishi zarur",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Text("Already have an account?",
                          style: AppTextStyle.interSemiBold),
                      const SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
                        },
                        child: Row(
                          children: [
                            Text(
                              "LOGIN",
                              style: AppTextStyle.interMedium
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            const SizedBox(width: 10,),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: AppColors.secondaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            listener: (BuildContext context, AuthState state) {
              if (state.formsStatus==FormsStatus.error) {
                Fluttertoast.showToast(
                    msg: state.errorMessage,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              if (state.formsStatus==FormsStatus.verifyError) {
                Fluttertoast.showToast(
                    msg: state.errorMessage,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              if (state.formsStatus==FormsStatus.authenticated)  {
                StorageRepository.setBool(key: "isLogin", value: true);
                context.read<ProfileBloc>().add(CreateUserProfileEvent(state.userModel!));
                Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
              }
            },

          )



    ),
    );
  }
}
