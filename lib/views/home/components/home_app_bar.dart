import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.dKey});
  final GlobalKey<SliderDrawerState> dKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isOpenDrawer = false;
  final TaskController _taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDrawerToggle() {
    setState(() {
      isOpenDrawer = !isOpenDrawer;
      if (isOpenDrawer) {
        _animationController.forward();
        widget.dKey.currentState!.openSlider();
      } else {
        _animationController.reverse();
        widget.dKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () {
                    onDrawerToggle();
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                    size: 40,
                  )),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10),
            //   child: IconButton(
            //       onPressed: () {
            //         onDrawerToggle();
            //       },
            //       icon: IconButton(
            //         onPressed: () {},
            //         icon: const Icon(
            //           CupertinoIcons.trash_fill,
            //           size: 35,
            //         ),
            //       )),
            // ),
            Obx(() {
              return _taskController.unCompletedTaskNumbers == 0 &&
                      _taskController.filteredTasks.length > 0
                  ? Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          color: Colors.green),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            Text(
                              "Great Job!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
