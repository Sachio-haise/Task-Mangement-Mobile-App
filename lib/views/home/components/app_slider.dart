import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/views/details/details_page.dart';
import 'package:flutter_application_1/views/home/home_view.dart';
import 'package:flutter_application_1/views/profile/profile_view.dart';
import 'package:get/get.dart';

class AppSlider extends StatelessWidget {
  AppSlider({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill
  ];

  final List<Widget> pages = [
    const HomeView(),
    const ProfileView(),
    const AppDetails(),
  ];

  String limitWords(String text, int limit) {
    if (text.length > limit) {
      return '${text.substring(0, limit)}...';
    }
    return text;
  }

  final List<String> texts = ["Home", "Settings", "Details"];
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Obx(() {
        var user = authController.user.value;
        if (user != null) {
          return Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.filePath != null
                    ? user.filePath!
                    : "https://cdn-icons-png.flaticon.com/512/5951/5951752.png"),
              ),
              const SizedBox(
                  height: 14), // Adjusted to SizedBox for consistency
              Text("${user.lastName} ${user.firstName}",
                  style: textTheme.displayMedium),
              10.h,
              Text(
                user.description != null
                    ? limitWords(user.description!, 35)
                    : "",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  itemCount: icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => {Get.to(() => pages[index])},
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: Icon(
                            icons[index],
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            texts[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              "Loading...",
              style: textTheme.displayMedium,
            ),
          );
        }
      }),
    );
  }
}
