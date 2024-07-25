import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/user_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/helper/custom_btn.dart';
import 'package:flutter_application_1/helper/custom_text_field.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/auth/login/login_view.dart';
import 'package:flutter_application_1/views/auth/user/components/back_button.dart';
import 'package:flutter_application_1/views/auth/user/components/forgot_pwd_app_bar.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final UserController _userController = Get.put(UserController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? condition = '';
  bool _emailBtnDisabled = true;
  bool _pwdBtnDisabled = true;
  String? _code;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkInputs);
    passwordController.addListener(_checkInputs);
    confirmPasswordController.addListener(_checkInputs);
  }

  void _checkInputs() {
    setState(() {
      _emailBtnDisabled = emailController.text.isEmpty;
      _pwdBtnDisabled = passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty ||
          passwordController.text != confirmPasswordController.text ||
          passwordController.text.length < 8 ||
          confirmPasswordController.text.length < 8;
    });
  }

  void _changeCondition(String msg) {
    setState(() {
      condition = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: const ForgotPwdAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              80.h,
              if (condition == '')
                _buildEmailSendMethod(textTheme, _userController,
                    emailController, _emailBtnDisabled, _changeCondition)
              else if (condition == "mailed")
                _buildCodeVerifySection(context, _userController)
              else if (condition == "checked")
                _buildNewCredentialsSection(
                    textTheme, passwordController, confirmPasswordController)
              else if (condition == "updated")
                _passwordUpdatedSection()
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordUpdatedSection() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                AppString.passwordString,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                AppString.updatedString,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              15.h,
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
                size: 80,
              ),
              15.h,
              const Text(
                AppString.yourPwdHasBeenupdatedString,
                style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
              ),
              20.h,
              CustomBtn(
                label: AppString.loginString,
                onPressed: () => {
                  _changeCondition(''),
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  )
                },
                disabled: false,
                textColor: Colors.white,
                color: AppColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewCredentialsSection(
      TextTheme textTheme,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    return SizedBox(
      width: double.infinity,
      height: 480,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Icon(
                Icons.lock_reset,
                color: AppColors.primaryColor,
                size: 60,
              ),
              10.h,
              const Text(
                AppString.newCredentialsString,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                AppString.identityVerifiedString,
                style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
              ),
              const Text(
                AppString.setYourNewPasswordString,
                style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
              ),
              25.h,
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
              Obx(() {
                return CustomTextField(
                  controller: passwordController,
                  isForPwd: true,
                  errorMessage: _userController.validationErrors['password'],
                );
              }),
              15.h,
              Row(
                children: [
                  15.w,
                  Text(
                    AppString.titleOfRetypePasswordField,
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
              Obx(() {
                return CustomTextField(
                  controller: confirmPasswordController,
                  isForPwd: true,
                  errorMessage: _userController.validationErrors['password'],
                );
              }),
              15.h,
              CustomBtn(
                  label: "Update",
                  onPressed: () async {
                    final responseData = await _userController.resetPassword(
                        email: emailController.text,
                        code: _code!,
                        password: passwordController.text);
                    if (responseData != null) {
                      setState(() {
                        _changeCondition(responseData);
                      });
                    }
                  },
                  color: AppColors.primaryColor,
                  textColor: Colors.white,
                  disabled: _pwdBtnDisabled || _userController.isLoading.value),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeVerifySection(
      BuildContext context, UserController _userController) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Icon(
                Icons.mail,
                color: AppColors.primaryColor,
                size: 70,
              ),
              10.h,
              const Text(
                AppString.pleaseCheckCodeString,
                style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
              ),
              Text(
                emailController.text,
                style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              25.h,
              Obx(() {
                return PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      // Handle changes her
                      _userController.validationErrors['code'] = '';
                    },
                    onCompleted: (value) async {
                      // Handle completion here
                      print("Completed: $value");

                      final responseData = await _userController.checkCode(
                          code: value, username: emailController.text);

                      print(responseData);
                      if (responseData != null) {
                        setState(() {
                          _code = value;
                          condition = responseData;
                        });
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      activeColor:
                          _userController.validationErrors['code'] != ''
                              ? Colors.red
                              : Colors.blue,
                      inactiveColor: Colors.grey,
                      selectedColor: Colors.blue,
                      errorBorderColor:
                          _userController.validationErrors['code'] != ''
                              ? Colors.red
                              : Colors.grey, // Conditional error color
                    ));
              }),
              10.h,
              GestureDetector(
                onTap: () async {
                  final responseData = await _userController.forgetPassword(
                      email: emailController.text);
                  if (responseData != null) {
                    setState(() {
                      _changeCondition(responseData);
                    });
                  }
                  print("condition: $condition");
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(AppString.resendCodeString,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor)),
                ),
              ),
              15.h,
              GoBackButton(
                  onPressed: () =>
                      {_changeCondition(''), emailController.clear()})
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildEmailSendMethod(
      TextTheme textTheme,
      UserController _userController,
      TextEditingController emailController,
      bool _btnDisabled,
      Function(String) _conditionChange) {
    return SizedBox(
      width: double.infinity,
      height: 410,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Icon(
                CupertinoIcons.lock_shield,
                color: AppColors.primaryColor,
                size: 60,
              ),
              10.h,
              const Text(
                AppString.forgetLabelString,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                AppString.pwdLabelString,
                style: TextStyle(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                AppString.provideYourEmailString,
                style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
              ),
              const Text(
                AppString.toResetPwdString,
                style: TextStyle(fontSize: 15, color: AppColors.primaryColor),
              ),
              15.h,
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
              Obx(() {
                return CustomTextField(
                  controller: emailController,
                  errorMessage: _userController.validationErrors['username'],
                );
              }),
              5.h,
              Obx(() {
                return CustomBtn(
                    label: "Send Email",
                    onPressed: () async {
                      final responseData = await _userController.forgetPassword(
                          email: emailController.text);
                      if (responseData != null) {
                        setState(() {
                          _conditionChange(responseData);
                        });
                      }
                      print("condition: $condition");
                    },
                    loading: _userController.isLoading.value,
                    color: AppColors.primaryColor,
                    textColor: Colors.white,
                    disabled: _btnDisabled || _userController.isLoading.value);
              })
            ],
          ),
        ),
      ),
    );
  }
}
