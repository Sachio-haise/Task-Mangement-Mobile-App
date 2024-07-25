import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/user_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/helper/custom_btn.dart';
import 'package:flutter_application_1/helper/custom_text_field.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/task/components/task_view_app_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthController authController = Get.find<AuthController>();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController oldPasswordTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  ValueNotifier<File?> file = ValueNotifier<File?>(null);
  final UserController userController = Get.find<UserController>();
  final picker = ImagePicker();
  bool isBtnDisabled = false;
  bool isBtnForPwdDisabled = false;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file.value = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setInputs();
    _validInputForm();
    firstNameTextEditingController.addListener(_validInputForm);
    lastNameTextEditingController.addListener(_validInputForm);
    passwordTextEditingController.addListener(_validInputForm);
    oldPasswordTextEditingController.addListener(_validInputForm);
  }

  void _validInputForm() {
    setState(() {
      isBtnDisabled = firstNameTextEditingController.text.isEmpty ||
          lastNameTextEditingController.text.isEmpty;
      isBtnForPwdDisabled = passwordTextEditingController.text.isEmpty ||
          oldPasswordTextEditingController.text.isEmpty;
    });
  }

  void _setInputs() {
    if (authController.user.value != null) {
      firstNameTextEditingController.text =
          authController.user.value!.firstName;
      lastNameTextEditingController.text = authController.user.value!.lastName;
      emailTextEditingController.text = authController.user.value!.email;
      descriptionTextEditingController.text =
          authController.user.value!.description != null
              ? authController.user.value!.description!
              : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryGradientColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TaskViewAppBar(),

                  // Profile SECTION
                  _profileInfoSection(textTheme),

                  // PASSWORD CHANGE SECTION
                  _passwordChangeSection(textTheme),
                  120.h
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _profileInfoSection(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              child: Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                text: const TextSpan(
                    text: AppString.profileInfoString,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40)),
              ),
            ),
            const SizedBox(
              width: 60,
              child: Divider(
                thickness: 2,
              ),
            ),
          ],
        ),
        30.h,
        Obx(() {
          var user = authController.user.value;
          if (user != null) {
            return Stack(
              children: [
                file.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: SizedBox(
                          width: 145,
                          height: 145,
                          child: Image.file(
                            file.value!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(user.filePath != null
                            ? user.filePath!
                            : "https://cdn-icons-png.flaticon.com/512/5951/5951752.png"),
                      ),
                Positioned(
                    bottom: 5,
                    right: 18,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        width: 25,
                        height: 25,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                    )),
              ],
            );
          } else {
            return const Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/5951/5951752.png"),
              ),
            );
          }
        }),
        60.h,
        Row(
          children: [
            15.w,
            Text(
              AppString.titleOffirstNameField,
              style: textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            5.w,
            const Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
        CustomTextField(
          controller: firstNameTextEditingController,
          errorMessage: null,
          textColor: Colors.white,
        ),
        30.h,
        Row(
          children: [
            15.w,
            Text(
              AppString.titleOflastNameField,
              style: textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            5.w,
            const Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
        CustomTextField(
          controller: lastNameTextEditingController,
          errorMessage: null,
          textColor: Colors.white,
        ),
        30.h,
        Row(
          children: [
            15.w,
            Text(
              "Description",
              style: textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            5.w,
            const Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
        CustomTextField(
          minLines: 2,
          controller: descriptionTextEditingController,
          errorMessage: null,
          textColor: Colors.white,
        ),
        30.h,
        Obx(() {
          return SizedBox(
            width: 160,
            child: CustomBtn(
              disabled: isBtnDisabled || userController.isLoading.value,
              label: AppString.updateCurrentTask,
              loading: userController.isLoading.value,
              onPressed: () async {
                print(isBtnDisabled);
                if (isBtnDisabled) return;
                final responseData = await userController.updateProfile(
                    firstName: firstNameTextEditingController.text,
                    lastName: lastNameTextEditingController.text,
                    description: descriptionTextEditingController.text,
                    file: file.value);
                if (responseData != null) {
                  Fluttertoast.showToast(
                    msg: "Profile Updated Successful!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Something Went Wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  print(responseData);
                }
              },
              color: Colors.white,
              textColor: Colors.black,
            ),
          );
        }),
        50.h,
      ],
    );
  }

  Column _passwordChangeSection(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              child: Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                text: const TextSpan(
                    text: AppString.passwordChangeString,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 28)),
              ),
            ),
            const SizedBox(
              width: 60,
              child: Divider(
                thickness: 2,
              ),
            ),
          ],
        ),
        30.h,
        Row(
          children: [
            15.w,
            Text(
              AppString.titleOfOldPasswordField,
              style: textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            5.w,
            const Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
        Obx(() => CustomTextField(
              controller: oldPasswordTextEditingController,
              textColor: Colors.white,
              isForPwd: true,
              errorMessage: userController.validationErrors['password'] ?? null,
            )),
        30.h,
        Row(
          children: [
            15.w,
            Text(
              AppString.titleOfPasswordField,
              style: textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            5.w,
            const Icon(
              Icons.person,
              color: Colors.white,
            )
          ],
        ),
        Obx(() => CustomTextField(
              controller: passwordTextEditingController,
              errorMessage:
                  userController.validationErrors['oldPassword'] ?? null,
              textColor: Colors.white,
              isForPwd: true,
            )),
        30.h,
        Obx(() {
          return SizedBox(
            width: 160,
            child: CustomBtn(
              disabled:
                  isBtnForPwdDisabled || userController.isLoadingForPwd.value,
              label: AppString.confirmString,
              loading: userController.isLoadingForPwd.value,
              onPressed: () async {
                print(isBtnDisabled);
                if (isBtnDisabled) return;
                final responseData = await userController.changePassword(
                    password: passwordTextEditingController.text,
                    oldPassword: oldPasswordTextEditingController.text);
                if (responseData != null) {
                  passwordTextEditingController.clear();
                  oldPasswordTextEditingController.clear();
                  userController.validationErrors.forEach((key, value) =>
                      userController.validationErrors[key] = '');
                  Fluttertoast.showToast(
                    msg: "Password Changed Successful!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Something Went Wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  print(responseData);
                }
              },
              color: Colors.white,
              textColor: Colors.black,
            ),
          );
        }),
      ],
    );
  }
}
