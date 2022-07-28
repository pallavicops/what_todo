import 'dart:async';

import 'package:what_todo/models/task.dart';

import '../database_helper.dart';

class TaskBloc {
  StreamController<List<Task>> taskListController =
      StreamController.broadcast();
  Stream<List<Task>> get tasksStream => taskListController.stream;

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  void fetchAllTasks() async {
    final List<Task> allTask = await _databaseHelper.getAllTask();
    if (allTask.isEmpty) {
      taskListController.sink.addError("No data found");
    } else {
      taskListController.sink.add(allTask);
    }
  }

  void insertTask(Task newTask) async {
    await _databaseHelper.insertTask(newTask);
  }

  void deleteTask(int id) {
    _databaseHelper.deleteTask(id);
    fetchAllTasks();
  }
}

final taskBloc = TaskBloc();
