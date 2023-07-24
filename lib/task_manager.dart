import 'task.dart';

class TaskManager {
  List<Task> tasks;
  Task? activeTask;

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
    if (activeTask != null) {
      stopTimer(activeTask!.title);
    }
    try {
      var task = tasks.firstWhere((task) => task.title == title);
      task.startTime = DateTime.now();
      activeTask = task;
      print('Timer for task "$title" has been started.');
    } catch (e) {
      print('Task "$title" not found.');
    }
  }

  void stopTimer(String title) {
    try {
      var task = tasks.firstWhere((task) => task.title == title);
      if (task.startTime != null) {
        var elapsedTime = DateTime.now().difference(task.startTime!);
        task.totalTimeSpent += elapsedTime;
        task.startTime = null;
        if (activeTask == task) {
          activeTask = null;
        }
        print('Timer for task "$title" has been stopped.');
      } else {
        print('Timer for task "$title" is not running.');
      }
    } catch (e) {
      print('Task "$title" not found.');
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

  void showTaskDetails(String title) {
    try {
      var task = tasks.firstWhere((task) => task.title == title);
      print('Title: ${task.title}');
      print('Description: ${task.description}');
      print('Deadline: ${task.deadline}');
      if (task.startTime != null) {
        print('Start time: ${task.startTime}');
        var elapsedTime = DateTime.now().difference(task.startTime!);
        print('Elapsed time: ${formatDuration(elapsedTime)}');
      }
      print('Total time spent: ${formatDuration(task.totalTimeSpent)}');
    } catch (e) {
      print('Task "$title" not found.');
    }
  }

  void markTaskAsComplete(String title) {
    var task = tasks.firstWhere((task) => task.title == title);
    task.isComplete = true;
    if (activeTask == task) {
      activeTask = null;
    }
    print('Task "$title" has been marked as complete.');
  }

  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day(s) ${duration.inHours.remainder(24)} hour(s) ${duration.inMinutes.remainder(60)} minute(s) ${duration.inSeconds.remainder(60)} second(s)';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour(s) ${duration.inMinutes.remainder(60)} minute(s) ${duration.inSeconds.remainder(60)} second(s)';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute(s) ${duration.inSeconds.remainder(60)} second(s)';
    } else {
      return '${duration.inSeconds} second(s)';
    }
  }
}
