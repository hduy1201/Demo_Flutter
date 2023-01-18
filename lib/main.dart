import 'dart:convert';

import 'package:demo_01/models/task.dart';
import 'package:demo_01/pages/account/account.dart';
import 'package:demo_01/pages/doing/doing.dart';
import 'package:demo_01/pages/done/done.dart';
import 'package:demo_01/pages/home/home.dart';
import 'package:demo_01/services/task_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int count = 0;

  int selectedPage = 0;

  String selectedStatus = "ToDo";

  List<Task> tasks = [];

  bool isFetched = false;

  Widget buildBody(int pageIndex) {
    if (pageIndex == 0) {
      return HomePage(
        tasks: TaskService().getTasksByStatus('todo'),
      );
    } else if (pageIndex == 1) {
      return DoingPage(
        tasks: TaskService().getTasksByStatus('doing'),
      );
    }
    return DonePage(tasks: TaskService().getTasksByStatus('done'));
  }

  @override
  Widget build(BuildContext context) {
    if (!isFetched) {
      TaskService().storage.ready.then((ready) {
        if (ready) {
          dynamic savedData = TaskService().storage.getItem('tasks');
          print(savedData);
          if (savedData == null) {
            return;
          }
          setState(() {
            TaskService().tasks.addAll(jsonDecode(savedData).map<Task>((task) {
                  return Task.fromJson(task);
                }).toList());
          });
        }
      });
      isFetched = true;
    }

    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: const Center(child: Text('Note App')),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const AccountPage())));
                },
                icon: const Icon(Icons.supervised_user_circle))
          ],
        ),
        body: buildBody(selectedPage),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value) {
            setState(() {
              selectedPage = value;
              if (selectedPage == 0) {
                selectedStatus = "ToDo";
              } else if (selectedPage == 1) {
                selectedStatus = "Doing";
              } else {
                selectedStatus = "Done";
              }
            });
          },
          backgroundColor: const Color(0xFFFF9800),
          selectedItemColor: const Color(0xFFFFFFFF),
          unselectedItemColor: const Color(0xFF000000),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rounded),
              label: 'To Do',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run_rounded),
              label: 'Doing',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_all_rounded), label: 'Done')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              TaskService().addTask(Task(
                  id: DateTime.now().millisecondsSinceEpoch,
                  status: selectedStatus.toLowerCase()));
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
