import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/models/task.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskServicesImpl extends GetxService {
  final String baseUrl = "http://localhost:8080";

  Future<List<Task>> getTasks() async {
    var url = Uri.parse("$baseUrl/api/v1/task");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    final responseData = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (responseData.statusCode == 200) {
      final List<dynamic> tasks = jsonDecode(responseData.body);
      print("tasks -> $tasks");
      return tasks.map((task) => Task.fromJson(task)).toList();
    }
    print("Fail to load task ${responseData.body}");
    return [];
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
    // make endpoint url
    var url = Uri.parse("$baseUrl/api/v1/task/create");

    // extract token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    // make request for file
    var request = http.MultipartRequest("POST", url);

    // read file
    // var stream = http.ByteStream(Stream.castFrom(file.openRead()));

    // get file bites
    // var length = await file.length();

    // make http file
    // final multipartFile = http.MultipartFile('file', stream, length,
    //    filename: basename(file.path));

    // set header
    request.headers['Authorization'] = "Bearer $token";
    request.headers['Content-Type'] = "multipart/form-data";

    // add data
    request.fields.addAll({
      'name': title,
      'description': description,
      'status': status,
      'priority': priority,
      'userId': userId,
      'dueDate': dueDate,
      'dueTime': dueTime
    });
    // request.files.add(multipartFile);
    final response = await request.send();
    var responseData = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      var data = jsonDecode(responseData.body)['task'];
      print("the task is ${data}");

      return Task.fromJson(data);
    } else {
      print("Fail to add task : ${responseData.body}");
      return null;
    }
  }

  Future<void> deleteTask({required String taskId}) async {
    // extract token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");

    final url = Uri.parse("$baseUrl/api/v1/task/delete/${taskId}");
    final resposeData =
        await http.delete(url, headers: {'Authorization': "Bearer $token"});
    print(resposeData.body);
  }
}
