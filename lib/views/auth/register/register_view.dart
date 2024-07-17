import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/auth/components/auth_button.dart';
import 'package:flutter_application_1/views/auth/components/auth_text_field.dart';
import 'package:flutter_application_1/views/auth/login/login_view.dart';
import 'package:flutter_application_1/views/home/home_view.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();
  bool _btnDisabled = true;

  @override
  void initState() {
    super.initState();
    firstNameTextController.addListener(_checkInputs);
    lastNameTextController.addListener(_checkInputs);
    emailTextController.addListener(_checkInputs);
    passwordTextController.addListener(_checkInputs);
  }

  void _checkInputs() {
    setState(() {
      _btnDisabled = firstNameTextController.text.isEmpty ||
          lastNameTextController.text.isEmpty ||
          emailTextController.text.isEmpty ||
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
                top: 100,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              70.h,
              Row(
                children: [
                  15.w,
                  Text(
                    AppString.titleOffirstNameField,
                    style: textTheme.displayMedium?.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.8),
                    ),
                  ),
                  5.w,
                  Icon(
                    Icons.person,
                    color: AppColors.primaryColor.withOpacity(0.8),
                  )
                ],
              ),
              Obx(() => AuthTextField(
                    controller: firstNameTextController,
                    errorMessage: _authController.validationErrors['firstName'],
                  )),
              10.h,
              Row(
                children: [
                  15.w,
                  Text(
                    AppString.titleOflastNameField,
                    style: textTheme.displayMedium?.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.8),
                    ),
                  ),
                  5.w,
                  Icon(
                    Icons.person,
                    color: AppColors.primaryColor.withOpacity(0.8),
                  )
                ],
              ),
              Obx(() => AuthTextField(
                    controller: lastNameTextController,
                    errorMessage: _authController.validationErrors['lastName'],
                  )),
              10.h,
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
              10.h,
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
              25.h,
              Obx(() {
                return AuthButton(
                  label: AppString.registerString,
                  onPressed: () async {
                    final responseData = await _authController.register(
                        email: emailTextController.text,
                        firstName: firstNameTextController.text,
                        lastName: lastNameTextController.text,
                        password: passwordTextController.text);
                    if (responseData != null) {
                      firstNameTextController.clear();
                      lastNameTextController.clear();
                      emailTextController.clear();
                      passwordTextController.clear();
                      Get.toNamed('/');
                    }
                  },
                  loading: _authController.isLoading.value,
                  disabled: _btnDisabled,
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      _authController.validationErrors.forEach((key, value) =>
                          _authController.validationErrors[key] = '');
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const LoginView()));
                    },
                    child: const Text("Login",
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
              width: 90,
              child: Divider(thickness: 2),
            ),
            10.w,
            const Text(AppString.registerString,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w300)),
            10.w,
            const SizedBox(
              width: 90,
              child: Divider(thickness: 2),
            ),
          ],
        ),
        20.h,
        Text(
          AppString.welcomeRegisterString,
          style: textTheme.displayMedium,
        )
      ],
    );
  }
}
