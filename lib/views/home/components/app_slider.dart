import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:get/get.dart';

class AppSlider extends StatelessWidget {
  AppSlider({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill
  ];

  final List<String> texts = ["Home", "Profile", "Settings", "Details"];
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
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-L102BdOGuunKMMJL3Ot8N7JPhx1ZdnLX1g&s"),
              ),
              SizedBox(height: 14), // Adjusted to SizedBox for consistency
              Text("${user.lastName} ${user.firstName}",
                  style: textTheme.displayMedium),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  itemCount: icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => print("msg"),
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          leading: Icon(
                            icons[index],
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            texts[index],
                            style: TextStyle(color: Colors.white),
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
