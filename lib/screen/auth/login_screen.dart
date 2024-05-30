import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotel_app/bloc/auth/auth_event.dart';
import 'package:hotel_app/bloc/profile/profile_event.dart';
import 'package:hotel_app/utils/contacts/app_contacts.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../data/local/storage_repository.dart';
import '../../data/model/response/form_status.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/size/screen_utils.dart';
import '../../utils/style/app_text_style.dart';
import '../route.dart';
import '../widgets/my_text_form_feilt.dart';
import '../widgets/rounted_bottom.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if(state.formsStatus==FormsStatus.loading){
          return const Center(child:  CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Log In",
                    style: AppTextStyle.interBold.copyWith(
                      color: Colors.blue,
                      fontSize: 32.w,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50,),
                MyTextFieldWidget(
                  keyBoardType: TextInputType.text,
                  controller: emailController,
                  hintText: "Email",
                  regExp: AppConstants.emailRegExp,
                ),
                const SizedBox(height: 10,),
                MyTextFieldWidget(
                  isObscureText: true,
                  keyBoardType: TextInputType.text,
                  controller: passwordController,
                  hintText: "Password",
                  regExp: AppConstants.passwordRegExp,
                ),
                const  SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: width * 0.8,
                    height: 46.h,
                    child: RoundedButton(
                      text: "Get Started Now",
                      onTap: () {
                        if(emailController.text!="" && passwordController.text!=""){
                          context.read<AuthBloc>().add(LoginEvent(emailController.text, passwordController.text));
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "email va passwordni to'liq kiriting",
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
                Text("Don't have an account?",
                    style: AppTextStyle.interSemiBold),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.register);
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
          ),
        );
       },
        listener: (BuildContext context, AuthState state) {
          if (state.formsStatus==FormsStatus.error) {
            passwordController.text="";
            emailController.text="";
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

      ),



      ),
    );
  }
}
