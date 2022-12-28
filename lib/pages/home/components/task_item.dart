// ignore_for_file: must_be_immutable

import 'package:demo_01/models/task.dart';
import 'package:demo_01/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  Task task;
  late TextEditingController _controller;
  TaskItem({super.key, required this.task}) {
    _controller = TextEditingController(text: task.content);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Text(task.id.toString()),
        title: TextField(
          controller: _controller,
          onEditingComplete: () {
            task.content = _controller.text;
            TaskService().save();
            print(task.content);
          },
        ),
        subtitle: Text(task.status));
  }
}
