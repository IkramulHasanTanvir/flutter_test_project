import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController(text: kDebugMode ? 'emilys' : '');
  final TextEditingController _passwordController = TextEditingController(text: kDebugMode ? 'emilyspass' : '');


  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final LoginController _authController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _globalKey,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 SizedBox(height: 74.h),
                  AuthTitleWidget(
                    title: 'Welcome Back!',
                    subtitle: 'Log in to access your account',
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    labelText: 'User Name',
                    controller: _emailController,
                    hintText: "Enter your username",
                  ),
        
                  SizedBox(height: 8.h),
                  CustomTextField(
                    labelText: 'User Password',
                    controller: _passwordController,
                    hintText: "Password",
                    isPassword: true,
                  ),
        
                  SizedBox(height:44.h),
        
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return  CustomButton(
                        isLoading: controller.isLoading,
                        label: "Log in",
                        onPressed: _onSingUp,
                      );
                    }
                  ),
                  SizedBox(height:44.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSingUp() async{
    if (!_globalKey.currentState!.validate()) return;

    final bool success = await _authController.login(userName: _emailController.text.trim(), password: _passwordController.text);

    if (success) {
      Get.offAllNamed(AppRoutes.bottomNavBar);
    } else {

    }
  }

}
