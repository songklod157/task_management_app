import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/providers/task_provider.dart';
import 'package:task_management_app/widgets/task_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Task Management App',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white))),
        backgroundColor: const Color.fromARGB(255, 138, 97, 209),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: TabBarView(
          children: [
            TaskListWidget(status: 'TODO'),
            TaskListWidget(status: 'DOING'),
            TaskListWidget(status: 'DONE'),
          ],
        ),
      ),
      bottomNavigationBar: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.list), text: 'To-Do'),
          Tab(icon: Icon(Icons.hourglass_full), text: 'Doing'),
          Tab(icon: Icon(Icons.check), text: 'Done'),
        ],
      ),
    );
  }
}
