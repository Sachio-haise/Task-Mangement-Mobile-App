import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/auth/components/auth_button.dart';
import 'package:flutter_application_1/views/auth/components/auth_text_field.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  bool _btnDisabled = true;
  @override
  void initState() {
    super.initState();
    emailTextController.addListener(_checkInputs);
    passwordTextController.addListener(_checkInputs);
  }

  void _checkInputs() {
    setState(() {
      _btnDisabled = emailTextController.text.isEmpty ||
          passwordTextController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Container(
              color: AppColors.primaryColor.withOpacity(0.8),
              padding: const EdgeInsets.only(
                top: 160,
              ),
              child: Column(
                children: [
                  _buildTopSide(textTheme),
                  40.h,
                  _buildMainSection(textTheme)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildMainSection(TextTheme textTheme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.h,
            Row(
              children: [
                15.w,
                Text(
                  AppString.titleOfEmailField,
                  style: textTheme.displayMedium?.copyWith(
                    color: AppColors.primaryColor.withOpacity(0.8),
                  ),
                ),
                5.w,
                Icon(
                  Icons.email,
                  color: AppColors.primaryColor.withOpacity(0.8),
                )
              ],
            ),
            Obx(() => AuthTextField(
                  controller: emailTextController,
                  errorMessage: _authController.validationErrors['username'],
                )),
            40.h,
            Row(
              children: [
                15.w,
                Text(
                  AppString.titleOfPasswordField,
                  style: textTheme.displayMedium?.copyWith(
                    color: AppColors.primaryColor.withOpacity(0.8),
                  ),
                ),
                5.w,
                Icon(
                  Icons.key,
                  color: AppColors.primaryColor.withOpacity(0.8),
                )
              ],
            ),
            Obx(() => AuthTextField(
                  controller: passwordTextController,
                  isForPwd: true,
                  errorMessage:
                      _authController.validationErrors['password'] ?? null,
                )),
            20.h,
            const Align(
              alignment: Alignment.centerRight,
              child: Text(AppString.forgetPasswordString,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor)),
            ),
            25.h,
            Obx(() {
              return AuthButton(
                label: AppString.registerString,
                onPressed: () async {
                  final responseData = await _authController.login(
                      email: emailTextController.text,
                      password: passwordTextController.text);
                  if (responseData != null) {
                    emailTextController.clear();
                    passwordTextController.clear();
                  }
                },
                loading: _authController.isLoading.value,
                disabled: _btnDisabled,
              );
            }),
            25.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign up",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopSide(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 100,
              child: Divider(thickness: 2),
            ),
            10.w,
            const Text(AppString.loginString,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w300)),
            10.w,
            const SizedBox(
              width: 100,
              child: Divider(thickness: 2),
            ),
          ],
        ),
        20.h,
        Text(
          AppString.welcomeLoginString,
          style: textTheme.displayMedium,
        )
      ],
    );
  }
}
