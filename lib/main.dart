import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/user_controller.dart';
import 'package:flutter_application_1/views/auth/login/login_view.dart';
import 'package:flutter_application_1/views/auth/register/register_view.dart';
import 'package:flutter_application_1/views/auth/user/forgot_password.dart';
import 'package:flutter_application_1/views/home/home_view.dart';
import 'package:flutter_application_1/views/task/task_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.put(UserController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthController _authController = Get.put(AuthController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task App',
      theme: ThemeData(
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(color: Colors.white, fontSize: 21),
              displaySmall: TextStyle(
                  color: Color.fromARGB(255, 234, 234, 234),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              headlineMedium: TextStyle(color: Colors.grey, fontSize: 17),
              headlineSmall: TextStyle(color: Colors.grey, fontSize: 16),
              titleSmall:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              titleLarge: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w300))),
      initialRoute: "/",
      home: Obx(() {
        return _authController.loginStatus.value
            ? const HomeView()
            : const LoginView();
      }),
      getPages: [
        GetPage(name: '/', page: () => const HomeView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/register', page: () => const RegisterView()),
      ],
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
    );
  }
}
