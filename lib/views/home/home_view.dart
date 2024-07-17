import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/enum/sort_order.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/home/components/app_slider.dart';
import 'package:flutter_application_1/views/home/components/fab.dart';
import 'package:flutter_application_1/views/home/components/home_app_bar.dart';
import 'package:flutter_application_1/views/home/widgets/task.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> dKey = GlobalKey<SliderDrawerState>();
  final TaskController _taskController = Get.find<TaskController>();
  final List<String> sortOptions = ['Date', 'Priority'];
  final List<String> statusOptions = ['ALL', 'COMPLETED', 'INPROGRESS'];
  String currentStatus = "ALL";
  SortDateOrder _sortDateOrder = SortDateOrder.ascending;
  SortPriorityOrder _sortPriorityOrder = SortPriorityOrder.high;

  void _sortTasks() {
    List<Task> filteredTasks = _taskController.tasks.toList();
    print(filteredTasks.length); // the length got 0
    print(_taskController.tasks.length);
    if (currentStatus != 'ALL') {
      filteredTasks = filteredTasks.where((task) {
        return task.status == currentStatus;
      }).toList();
    }
    if (_sortDateOrder == SortDateOrder.ascending) {
      filteredTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      filteredTasks.sort((a, b) => b.dueDate.compareTo(a.dueDate));
    }
    setState(() {
      _taskController.filteredTasks.value = filteredTasks;
    });
  }

  void _sortTasksByPriority() {
    List<Task> filteredTasks = _taskController.tasks.toList();
    if (currentStatus != "ALL") {
      filteredTasks = filteredTasks.where((task) {
        return task.status == currentStatus;
      }).toList();
    }
    if (_sortPriorityOrder == SortPriorityOrder.high) {
      filteredTasks.sort((a, b) => a.priority.compareTo(b.priority));
    } else {
      filteredTasks.sort((a, b) => b.priority.compareTo(a.priority));
    }
    setState(() {
      _taskController.filteredTasks.value = filteredTasks;
    });
  }

  void _toggleSortDateOrder() {
    setState(() {
      _sortDateOrder = _sortDateOrder == SortDateOrder.ascending
          ? SortDateOrder.descending
          : SortDateOrder.ascending;
      _sortTasks();
    });
  }

  void _toggleSortPriorityOrder() {
    setState(() {
      _sortPriorityOrder = _sortPriorityOrder == SortPriorityOrder.low
          ? SortPriorityOrder.high
          : SortPriorityOrder.low;
      _sortTasksByPriority();
    });
  }

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar
            Container(
              margin: const EdgeInsets.only(top: 0),
              width: double.infinity,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: 1 / 3,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
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

            // Sorter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 120,
                    child: DropdownButton(
                        underline: const SizedBox.shrink(),
                        hint: const Text(
                          "Sort By",
                          style: TextStyle(color: Colors.black),
                        ),
                        items: sortOptions.map((String option) {
                          return DropdownMenuItem(
                              value: option,
                              child: Row(
                                children: [
                                  Text(
                                    option,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (option == "Date" &&
                                      _sortDateOrder == SortDateOrder.ascending)
                                    const Icon(Icons.arrow_upward)
                                  else if (option == "Date" &&
                                      _sortDateOrder ==
                                          SortDateOrder.descending)
                                    const Icon(Icons.arrow_downward),
                                  if (option == "Priority" &&
                                      _sortPriorityOrder ==
                                          SortPriorityOrder.high)
                                    const Icon(Icons.arrow_upward)
                                  else if (option == "Priority" &&
                                      _sortPriorityOrder ==
                                          SortPriorityOrder.low)
                                    const Icon(Icons.arrow_downward)
                                ],
                              ));
                        }).toList(),
                        onChanged: (option) {
                          if (option == "Date") return _toggleSortDateOrder();
                          if (option == "Priority") {
                            return _toggleSortPriorityOrder();
                          }
                        }),
                  ),
                  DropdownButton(
                      value: currentStatus,
                      underline: const SizedBox.shrink(),
                      items: statusOptions.map((String option) {
                        return DropdownMenuItem(
                            value: option,
                            child: Row(
                              children: [
                                Text(
                                  option,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ));
                      }).toList(),
                      onChanged: (option) {
                        setState(() {
                          currentStatus = option!;
                          _sortTasks();
                        });
                      }),
                ],
              ),
            ),
            4.h,

            // Tasks
            SizedBox(
                width: double.infinity,
                height: 560,
                child:
                    // Task is Not Empty
                    Obx(() {
                  return _taskController.filteredTasks.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: _taskController.filteredTasks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final task = _taskController.filteredTasks[index];
                            return Dismissible(
                                key: Key(task.id.toString()),
                                direction: DismissDirection.horizontal,
                                onDismissed: (_) => {
                                      setState(() {
                                        _taskController.deleteTask(
                                            taskId: task.id.toString());
                                        _taskController.tasks.remove(task);
                                        _taskController.filteredTasks
                                            .remove(task);
                                      }),
                                      print(
                                          _taskController.filteredTasks.length)
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
                                child: TaskItem(task: task));
                          })
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lottie animate
                            FadeInUp(
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: Lottie.asset(lottieURL,
                                    animate: _taskController.tasks.isNotEmpty
                                        ? false
                                        : true),
                              ),
                            ),

                            // Sub Text
                            FadeInUp(
                                from: 30,
                                child: const Text(AppString.doneAllTask))
                          ],
                        );
                })),
          ],
        ),
      ),
    );
  }
}
