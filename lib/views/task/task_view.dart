import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/task/components/date_time_selector.dart';
import 'package:flutter_application_1/views/task/components/rap_text_field.dart';
import 'package:flutter_application_1/views/task/components/task_view_app_bar.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController =
      TextEditingController();
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

  Padding _buildButtomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            onPressed: () {},
            minWidth: 150,
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
          MaterialButton(
            onPressed: () {},
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Text(
              AppString.addNewTask,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMainViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),
          RepTextField(controller: titleTextController),
          10.h,
          RepTextField(controller: titleTextController, isForDescription: true),
          DateTimeSelectionWidget(
            onTap: () => {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => SizedBox(
                        height: 280,
                        child: TimePickerWidget(
                          onChange: (_, __) => {},
                          dateFormat: "HH:mm",
                          onConfirm: (dateTime, _) => {},
                        ),
                      ))
            },
            title: AppString.timeString,
          ),
          DateTimeSelectionWidget(
            onTap: () => {
              DatePicker.showDatePicker(context,
                  maxDateTime: DateTime(2030, 4, 5),
                  minDateTime: DateTime.now(),
                  onConfirm: (dateTime, _) => {})
            },
            title: AppString.dateString,
          )
        ],
      ),
    );
  }

  Widget _buildTopSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
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
