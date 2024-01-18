import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/providers/task_provider.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/widgets/task_detail_widget.dart';

class TaskListWidget extends StatefulWidget {
  final String status;

  const TaskListWidget({super.key, required this.status});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final ScrollController _scrollController = ScrollController();
  final List<Task> _list = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchTasks(_currentPage);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      _fetchTasks(_currentPage);
    }
  }

  void _fetchTasks(int offset) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchTasks(
      offset: offset,
      limit: 10,
      sortBy: 'createdAt',
      isAsc: true,
      status: widget.status,
    );
    print('=====${taskProvider.tasks.length}');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks
        .where((task) => task.status == widget.status)
        .toList();
    _list.addAll(tasks);
    final groupedTasks = groupBy(
        _list,
        (Task task) =>
            DateFormat('dd-MM-yyyy').format(task.createdAt.toLocal()));
    print('Number of tasks: ${_list.length}');
    return ListView.builder(
      controller: _scrollController,
      itemCount: groupedTasks.length,
      itemBuilder: (context, index) {
        final List<Task> tasksOnDate = groupedTasks.values.elementAt(index);
        final DateTime date = tasksOnDate.first.createdAt.toLocal();
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date headline
              Row(
                children: [
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: const Color.fromARGB(255, 171, 122, 255),
                    ),
                    child: Text(
                      DateFormat('dd-MMM-yyyy').format(date),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              // Task items
              ...tasksOnDate.map((task) => Dismissible(
                    key: Key(
                        '${task.id}_${random.nextInt(99999).toString().padLeft(5, '0')}'),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      if (index != -1) {
                        _list.removeAt(index);
                      }
                    },
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskDetailWidget(
                            task: task,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          task.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 50, 32, 55)),
                        ),
                        subtitle: Text(task.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 97, 81, 102))),
                        trailing: Text(
                            DateFormat.Hm().format(
                              date,
                            ),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 97, 81, 102))),
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
