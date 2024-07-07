import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/home/components/app_slider.dart';
import 'package:flutter_application_1/views/home/components/fab.dart';
import 'package:flutter_application_1/views/home/components/home_app_bar.dart';
import 'package:flutter_application_1/views/home/widgets/task.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> dKey =
      const GlobalObjectKey<SliderDrawerState>('dKey');
  final List<int> testing = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: const Fab(),
        body: SliderDrawer(
          key: dKey,
          isDraggable: false,
          animationDuration: 1000,
          slider: AppSlider(),
          appBar: HomeAppBar(dKey: dKey),
          child: _buildHomeBody(textTheme),
        ));
  }

  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // AppBar
          Container(
            margin: const EdgeInsets.only(top: 0),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),
                25.w,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppString.mainTitle,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "1 of 3",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                )
              ],
            ),
          ),
          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          // Tasks
          SizedBox(
              width: double.infinity,
              height: 650,
              child: testing.isNotEmpty
                  ?
                  // Task is Not Empty
                  ListView.builder(
                      itemCount: testing.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) => {
                                setState(() {
                                  testing.removeAt(index);
                                }),
                                print(testing.length)
                              },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              8.w,
                              const Text(
                                AppString.deleteTask,
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          key: Key(index.toString()),
                          child: const Task()),
                    )
                  :
                  // Task list is empty
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie animate
                        FadeInUp(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(lottieURL,
                                animate: testing.isNotEmpty ? false : true),
                          ),
                        ),

                        // Sub Text
                        FadeInUp(
                            from: 30, child: const Text(AppString.doneAllTask))
                      ],
                    )),
        ],
      ),
    );
  }
}
