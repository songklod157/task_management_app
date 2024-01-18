import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks({
    int offset = 0,
    int limit = 10,
    String sortBy = 'createdAt',
    bool isAsc = true,
    String status = 'TODO',
  }) async {
    try {
      final response = await _dio.get(
          'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list',
          queryParameters: {
            'offset': offset,
            'limit': limit,
            'sortBy': sortBy,
            'isAsc': isAsc,
            'status': status
          });
      final List<dynamic> data = response.data['tasks'];
      _tasks = data.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  void deleteTask(String taskId) {
    int index = _tasks.indexWhere((task) => task.id == taskId);

    if (index != -1) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }
}
