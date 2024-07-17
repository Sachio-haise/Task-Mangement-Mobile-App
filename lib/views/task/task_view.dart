import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/task_controller.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/auth/components/auth_button.dart';
import 'package:flutter_application_1/views/home/home_view.dart';
import 'package:flutter_application_1/views/task/components/date_time_selector.dart';
import 'package:flutter_application_1/views/task/components/rap_text_field.dart';
import 'package:flutter_application_1/views/task/components/task_view_app_bar.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final AuthController _authController = Get.find<AuthController>();
  final TaskController _taskController = Get.find<TaskController>();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();

  final picker = ImagePicker();
  final List<String> _statusOptions = ['INPROGRESS', 'COMPLETED'];
  final List<String> taskPriorityOptions = ['High', 'Medium', 'Low'];
  bool _btnDisabled = true;
  ValueNotifier<String?> taskStatus = ValueNotifier<String?>(null);
  ValueNotifier<String?> taskPriority = ValueNotifier<String?>(null);
  ValueNotifier<String?> dueDateValue = ValueNotifier<String?>(null);
  ValueNotifier<String?> dueTimeValue = ValueNotifier<String?>(null);
  ValueNotifier<File?> file = ValueNotifier<File?>(null);

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat timeFormat = DateFormat('HH:mm');

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

  Future<void> addTask() async {
    if (_btnDisabled) {
      return;
    }
    var userId = _authController.user.value!.id;
    String priority;
    if (taskPriority.value == 'High') {
      priority = 0.toString();
    } else if (taskPriority.value == 'Medium') {
      priority = 1.toString();
    } else {
      priority = 2.toString();
    }
    final responseData = await _taskController.addTask(
        title: titleTextController.text,
        description: descriptionTextController.text,
        status: taskStatus.value!,
        priority: priority,
        userId: userId.toString(),
        // file: file.value!
        dueDate: dueDateValue.value!,
        dueTime: dueTimeValue.value!);
    if (responseData != null) {
      titleTextController.clear();
      descriptionTextController.clear();
      taskStatus.value = null;
      taskPriority.value = null;
      file.value = null;
      Get.toNamed('/');
    }
    print(responseData);
  }

  @override
  void initState() {
    super.initState();
    titleTextController.addListener(_checkInputs);
    descriptionTextController.addListener(_checkInputs);
    // Add listeners to ValueNotifiers
    taskStatus.addListener(_checkInputs);
    taskPriority.addListener(_checkInputs);
    dueDateValue.addListener(_checkInputs);
    dueTimeValue.addListener(_checkInputs);
    // file.addListener(_checkInputs);
  }

  void _checkInputs() {
    setState(() {
      _btnDisabled = titleTextController.text.isEmpty ||
          descriptionTextController.text.isEmpty ||
          taskStatus.value == null ||
          taskPriority.value == null ||
          dueDateValue.value == null ||
          dueTimeValue.value == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Side Task
                _buildTopSideText(textTheme),

                // Main Activity
                _buildMainViewActivity(textTheme, context),

                // Bottom Side Task
                _buildButtomSideButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            onPressed: () {
              titleTextController.clear();
              descriptionTextController.clear();
              taskStatus.value = null;
              taskPriority.value = null;
              file.value = null;
              Get.toNamed('/');
            },
            minWidth: 160,
            height: 55,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                5.w,
                const Text(
                  AppString.deleteTask,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Obx(() {
            return SizedBox(
                width: 160,
                child: AuthButton(
                  disabled: _btnDisabled,
                  label: AppString.addNewTask,
                  loading: _taskController.isLoading.value,
                  onPressed: addTask,
                ));
          })
        ],
      ),
    );
  }

  Widget _buildMainViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            25.h,
            RepTextField(
                controller: titleTextController, isForDescription: true),

            RepTextField(controller: descriptionTextController),
            10.h,

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _statusOptions.map((String value) {
                  return Row(
                    children: [
                      Radio<String>(
                        activeColor: AppColors.primaryColor,
                        value: value,
                        groupValue: taskStatus.value,
                        onChanged: (newValue) {
                          setState(() {
                            taskStatus.value = newValue;
                          });
                        },
                      ),
                      GestureDetector(
                          onTap: () => setState(() {
                                taskStatus.value = value;
                              }),
                          child: Text(
                            value,
                            style: textTheme.bodyMedium,
                          )),
                    ],
                  );
                }).toList(),
              ),
            ),
            20.h,
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: DropdownButton<String>(
                value: taskPriority.value,
                hint: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Text('Select Task Priority',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w300)),
                ),
                items: taskPriorityOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    taskPriority.value = newValue;
                  });
                },
              ),
            ),
            10.h,
            // Padding(
            //   padding: const EdgeInsets.only(left: 35),
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(
            //         width: 120,
            //         child: MaterialButton(
            //           onPressed: pickImage,
            //           height: 55,
            //           color: Colors.white,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(15)),
            //           child: Row(
            //             children: [
            //               const Icon(
            //                 Icons.file_upload,
            //                 color: AppColors.primaryColor,
            //               ),
            //               5.w,
            //               const Text(
            //                 AppString.uploadString,
            //                 style: TextStyle(
            //                     color: AppColors.primaryColor,
            //                     fontWeight: FontWeight.bold),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       10.h,
            //       SizedBox(
            //         width: 120,
            //         child: file.value != null
            //             ? Image.file(file.value!)
            //             : const SizedBox.shrink(),
            //       ),
            //     ],
            //   ),
            // ),
            DateTimeSelectionWidget(
              onTap: () => {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => SizedBox(
                          height: 280,
                          child: TimePickerWidget(
                            onChange: (_, __) => {},
                            dateFormat: "HH:mm",
                            onConfirm: (dateTime, _) => {
                              setState(() {
                                dueTimeValue.value =
                                    timeFormat.format(dateTime);
                              })
                            },
                          ),
                        ))
              },
              value: dueTimeValue.value,
              title: AppString.dueTimeString,
            ),
            DateTimeSelectionWidget(
              onTap: () => {
                DatePicker.showDatePicker(context,
                    maxDateTime: DateTime(2030, 4, 5),
                    minDateTime: DateTime.now(),
                    onConfirm: (dateTime, _) => {
                          setState(() {
                            dueDateValue.value = dateFormat.format(dateTime);
                          })
                        })
              },
              value: dueDateValue.value,
              title: AppString.dueDateString,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
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
            child: RichText(
              text: TextSpan(
                  text: AppString.addNewTask,
                  style: textTheme.titleLarge,
                  children: const [
                    TextSpan(
                        text: AppString.taskStrnig,
                        style: TextStyle(fontWeight: FontWeight.w400))
                  ]),
            ),
          ),
          const SizedBox(
            width: 75,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
