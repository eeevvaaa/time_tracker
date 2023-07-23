import 'task.dart';

class TaskManager {
  List<Task> tasks;

  TaskManager({required this.tasks});

  void createTask(String title, String description, DateTime deadline) {
    var task = Task(
      title: title,
      description: description,
      deadline: deadline,
    );
    tasks.add(task);
  }

  void startTimer(String title) {
    var task = tasks.firstWhere((task) => task.title == title);
    task.startTime = DateTime.now();
  }

  void stopTimer(String title) {
    var task = tasks.firstWhere((task) => task.title == title);
    if (task.startTime != null) {
      var timeSpent = DateTime.now().difference(task.startTime!);
      task.totalTimeSpent += timeSpent;
      task.startTime = null; // reset startTime
    }
  }

  void listTasks() {
    for (var task in tasks) {
      print('Title: ${task.title}');
      print('Description: ${task.description}');
      print('Deadline: ${task.deadline}');
      print('Total Time Spent: ${task.totalTimeSpent}');
      print('Is Complete: ${task.isComplete}');
      print('-------------------------');
    }
  }

  void markTaskAsComplete(String title) {
    var task = tasks.firstWhere((task) => task.title == title);
    task.isComplete = true;
  }
}
