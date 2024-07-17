import 'dart:io';

import 'package:flutter_application_1/models/task.dart';
import 'package:flutter_application_1/services/task_services_impl.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TaskController extends GetxController {
  TaskServicesImpl taskServicesImpl = Get.put(TaskServicesImpl());
  var isLoading = false.obs;
  RxList<Task> tasks = <Task>[].obs;
  RxList<Task> filteredTasks = <Task>[].obs;

  void loadTask() async {
    List<Task> taskData = await taskServicesImpl.getTasks();
    tasks.value = taskData;
    filteredTasks.value = taskData;
  }

  Future<Task?> addTask(
      {required String title,
      required String description,
      required String status,
      required String priority,
      required String userId,
      required String dueDate,
      required String dueTime
      // required File file
      }) async {
    isLoading.value = true;
    final responseData = await taskServicesImpl.addTask(
        title: title,
        description: description,
        status: status,
        priority: priority,
        userId: userId,
        dueDate: dueDate,
        dueTime: dueTime
        // file: file
        );
    isLoading.value = false;
    if (responseData != null) {
      return responseData;
    } else {
      return null;
    }
  }

  Future<void> deleteTask({required String taskId}) async {
    await taskServicesImpl.deleteTask(taskId: taskId);
  }
}
