import 'package:demo_01/models/task.dart';
import 'package:demo_01/pages/home/components/task_item.dart';
import 'package:demo_01/services/task_service.dart';
import 'package:flutter/material.dart';

class DonePage extends StatefulWidget {
  List<Task> tasks;

  DonePage({super.key, required this.tasks});

  @override
  State<StatefulWidget> createState() {
    return DonePageState();
  }
}

class DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.tasks.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                  key: Key(widget.tasks[index].id.toString()),
                  onDismissed: ((direction) {
                    setState(() {
                      int deletedID = widget.tasks[index].id;
                      widget.tasks.removeAt(index);
                      TaskService().removeTask(deletedID);
                      TaskService().save();
                    });
                  }),
                  child: TaskItem(task: widget.tasks[index]));
            })));
  }
}
