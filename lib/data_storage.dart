import 'dart:convert';
import 'dart:io';
import 'task.dart';

class DataStorage {
  final String path;

  DataStorage({required this.path});

  Future<void> saveTasks(List<Task> tasks) async {
    final file = File(path);
    final taskListJson = tasks.map((task) => task.toJson()).toList();
    await file.writeAsString(jsonEncode(taskListJson));
  }

  Future<List<Task>> loadTasks() async {
    final file = File(path);
    if (!await file.exists()) {
      return [];
    }
    final taskListJson = jsonDecode(await file.readAsString()) as List;
    return taskListJson.map((taskJson) => Task.fromJson(taskJson)).toList();
  }
}
