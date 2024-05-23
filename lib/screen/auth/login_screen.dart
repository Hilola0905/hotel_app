import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
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
          body:SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log In",
                    style: AppTextStyle.interBold.copyWith(
                      color: Colors.blue,
                      fontSize: 32.w,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8.w)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.google),
                          const  SizedBox(width:20),
                          Text(
                            "Google",
                            style: AppTextStyle.interLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 4,
                        child: const Divider(),
                      ),
                      const  SizedBox(width:10),
                      Text("or",
                          style: TextStyle(
                              color: const Color(0xff486484), fontSize: 18.w)),
                      const  SizedBox(width:10),
                      SizedBox(
                        width: width / 4,
                        child: const Divider(),
                      ),
                    ],
                  ),
                  MyTextFieldWidget(
                    keyBoardType: TextInputType.text,
                    controller: emailController,
                    hintText: "Email",
                  ),
                  MyTextFieldWidget(
                    isObscureText: true,
                    keyBoardType: TextInputType.text,
                    controller: passwordController,
                    hintText: "Password",
                  ),
                  const  SizedBox(height: 20,),
                  Center(
                    child: SizedBox(
                      width: width * 0.8,
                      height: 46.h,
                      child: RoundedButton(
                        text: "Get Started Now",
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context, RouteNames.tabRoute, (route) => false);
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
          )),
    );
  }
}
