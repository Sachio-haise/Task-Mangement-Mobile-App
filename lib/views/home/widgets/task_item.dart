import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extensions/space_exts.dart';
import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/strings.dart';
import 'package:flutter_application_1/views/task/task_add_update.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key, required this.task, this.userId, required this.updateTask});

  final Task task;
  final int? userId;
  final VoidCallback updateTask;
  @override
  Widget build(BuildContext context) {
    String limitWords(String text, int limit) {
      if (text.length > limit) {
        return '${text.substring(0, limit)}...';
      }
      return text;
    }

    Widget checkDateStatus(DateTime currentDate, DateTime dueDate) {
      if (currentDate.isAfter(dueDate)) {
        return const Text("Over Due!",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12));
      } else if (currentDate.isBefore(dueDate)) {
        Duration difference = dueDate.difference(currentDate);
        if (difference.inDays <= 7) {
          return const Text(
            "Close to the due date",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.yellowColor),
          );
        } else {
          return const Text(
            "Still okay",
            style: TextStyle(
                color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
          );
        }
      } else {
        return const Text(
          "Today is the due date",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
        );
      }
    }

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ]),
      duration: const Duration(milliseconds: 600),
      child: ListTile(
        // check Icon
        leading: GestureDetector(
          onTap: updateTask,
          child: Container(
            decoration: BoxDecoration(
                color: task.status == 'COMPLETED'
                    ? AppColors.primaryColor
                    : Colors.grey.withOpacity(0.8),
                shape: BoxShape.circle),
            child: task.status == 'COMPLETED'
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : const Icon(
                    CupertinoIcons.clock,
                    color: Colors.white,
                  ),
          ),
        ),

        // Title
        title: InkWell(
          onTap: () {
            Get.to(() => TaskAddUpdate(
                  taskId: task.id,
                  title: task.name,
                  description: task.description,
                  status: task.status,
                  priority: task.priority,
                  dueDate: task.dueDate,
                  dueTime: task.dueTime,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                task.status == 'COMPLETED'
                    ? Text(
                        task.status,
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      )
                    : Text(
                        task.status,
                        style: const TextStyle(
                            color: AppColors.yellowColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 14),
                      ),
                Container(
                  decoration: BoxDecoration(
                      color: task.priority == 0
                          ? Colors.red
                          : task.priority == 1
                              ? Colors.yellow
                              : Colors.green,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Text(
                      task.priority == 0
                          ? "High"
                          : task.priority == 1
                              ? "Medium"
                              : "Low",
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Task Description
        subtitle: InkWell(
          onTap: () {
            Get.to(() => TaskAddUpdate(
                  taskId: task.id,
                  title: task.name,
                  description: task.description,
                  status: task.status,
                  priority: task.priority,
                  dueDate: task.dueDate,
                  dueTime: task.dueTime,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  limitWords(task.name, 40),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Text(
                  limitWords(task.description, 200),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                task.status == "COMPLETED"
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              AppString.deadlineString,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      task.dueDate,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    5.w,
                                    Text(
                                      task.dueTime,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                checkDateStatus(DateTime.now(),
                                    DateTime.parse(task.dueDate)),
                              ],
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
