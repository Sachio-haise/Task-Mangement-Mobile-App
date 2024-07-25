import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/details/components/bulletList.dart';
import 'package:flutter_application_1/views/task/components/task_view_app_bar.dart';

class AppDetails extends StatelessWidget {
  const AppDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TaskViewAppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 75,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          AppString.mainTitle,
                          style: textTheme.displayLarge,
                        )),
                    const SizedBox(
                      width: 75,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    "STILL BETA",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                15.h,
                const Text(
                  " -Tagline",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                10.h,
                Text(
                  "      The app is created for managing our daily tasks effectively, empowering users to stay organized and productive. Seamlessly handle tasks, set deadlines, and in the future, we're planning to add a feature to connect with others for project collaboration. Simplify your life and achieve your goals with our intuitive task management solution.",
                  style: textTheme.bodyMedium,
                ),
                15.h,
                const Text(
                  " -Features",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "User Authentication:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Secure sign-up and login',
                      'Password recovery options'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Task Management:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Create, read, update, and delete tasks',
                      'Organize tasks by categories or tags',
                      'Set priorities for tasks',
                      'Mark tasks as complete'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Task Deadlines:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Set deadlines for tasks',
                      'Receive notifications for upcoming deadlines',
                      'View overdue tasks'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "User Profile Management:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Edit username and other profile details',
                      'Update profile picture'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Security and Privacy:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Data Protection: Explain how user data is protected.',
                      'Privacy Policies: Link to the privacy policy and terms of service'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "User-to-User Connections (Future Feature):",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'Connect with other users',
                      'Share tasks or collaborate on projects',
                      'View connections’ activities (with privacy settings)'
                    ],
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "Rating System (Future Feature):",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: BulletList(
                    items: [
                      'A rating system is in the planning stages for future implementation',
                      'This will allow users to rate tasks and projects, helping to prioritize and improve workflow'
                    ],
                  ),
                ),
                20.h,
                const Divider(),
                20.h,
                const Text(
                  " -Developer Contact",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                10.h,
                const Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    "For any inquiries or support, please contact the developer:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                10.h,
                Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: "Email: ",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "aungkaungmyatkpg777@gmail.com",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue))
                            ]),
                      ),
                      5.h,
                      RichText(
                        text: const TextSpan(
                            text: "Website: ",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "https://akm-web-dev.vercel.app",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue))
                            ]),
                      ),
                      45.h,
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Copyright © 2023 All Rghts Reserved | Haruto",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                80.h,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
