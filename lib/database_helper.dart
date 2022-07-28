import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/task.dart';

class DatabaseHelper {
  Future<void> insertTask(Task task) async {
    final sharedPreference = await SharedPreferences.getInstance();
    final String? tasks = sharedPreference.getString("tasks");
    List<dynamic> allTasks = [];
    if (tasks == null) {
      allTasks.add(task.toMap());
      sharedPreference.setString('tasks', json.encode(allTasks));
    } else {
      allTasks = json.decode(tasks);
      allTasks.add(task.toMap());
      sharedPreference.setString('tasks', json.encode(allTasks));
    }
  }

  Future<List<Task>> getAllTask() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final String? tasks = sharedPreference.getString("tasks");
    List<Task> allTasks = [];
    if (tasks != null) {
      final List<dynamic> allTaskMap = json.decode(tasks);
      for (var task in allTaskMap) {
        allTasks.add(
          Task(
              id: task["id"],
              title: task["title"],
              descreption: task["description"]),
        );
      }
    }
    return allTasks;
  }

  Future<void> deleteTask(int id) async {
    final sharedPreference = await SharedPreferences.getInstance();
    final String? tasks = sharedPreference.getString("tasks");
    List<Task> allTasks = [];
    List<dynamic> allTaskForPush = [];
    if (tasks != null) {
      final List<dynamic> allTaskMap = json.decode(tasks);
      for (var task in allTaskMap) {
        if (task["id"] != id) {
          allTasks.add(
            Task(
                id: task["id"],
                title: task["title"],
                descreption: task["description"]),
          );
        }
      }
      for (var task in allTasks) {
        allTaskForPush.add(task.toMap());
      }
      sharedPreference.setString('tasks', json.encode(allTaskForPush));
    }
  }
}
