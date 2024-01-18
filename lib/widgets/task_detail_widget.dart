import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskDetailWidget extends StatelessWidget {
  const TaskDetailWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Row(
            children: [
              Text(
                'Title ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              task.title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 50, 32, 55)),
            ),
          ),
          const Row(
            children: [
              Text(
                'Description ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              task.description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 50, 32, 55)),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Status: ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple),
              ),
              Text(task.status,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 50, 32, 55))),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Create at: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple)),
              Text(DateFormat('dd-MMM-yyyy-HH:mm:ss').format(task.createdAt),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 50, 32, 55))),
            ],
          ),
        ]),
      ),
    );
  }
}
