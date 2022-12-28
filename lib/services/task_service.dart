import 'dart:convert';

import 'package:demo_01/models/task.dart';
import 'package:localstorage/localstorage.dart';

class TaskService {
  final LocalStorage storage = LocalStorage('tasks.json');
  final List<Task> tasks = [];

  //apply singleton pattern
  static final TaskService _taskService = TaskService._internal();

  factory TaskService() {
    return _taskService;
  }

  TaskService._internal() {
    //load tasks from local storage
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void removeTask(int id) {
    tasks.removeWhere((task) => task.id == id);
  }

  //get task by status
  List<Task> getTasksByStatus(String status) {
    return tasks.where((task) => task.status == status).toList();
  }

  void save() {
    var data = jsonEncode(tasks);
    print(data);
    //save to local storage
    storage.setItem('tasks', data);
  }
}
