import 'dart:io';
import 'task_manager.dart';

void printMenu(TaskManager taskManager) {
  print('Select an option:');
  print('1. Create a new task');
  print('2. Start timer for a task');
  print('3. Stop timer for a task');
  print('4. Show all tasks');
  print('5. Mark a task as complete');
  if (taskManager.activeTask != null) {
    print('6. Show active timer');
    print('7. Exit');
  } else {
    print('6. Exit');
  }
}

void handleUserInput(TaskManager taskManager) {
  while (true) {
    printMenu(taskManager);
    var input = stdin.readLineSync();
    switch (input) {
      case '1':
        print('Enter task title:');
        var title = '';
        while (title.isEmpty) {
          title = stdin.readLineSync() ?? '';
        }
        print('Enter task description (or just hit enter to skip):');
        var description = stdin.readLineSync();
        if (description == null || description.isEmpty) {
          description = 'No description provided';
        }
        DateTime deadline = DateTime.now();
        while (true) {
          print(
              'Enter task deadline (mm-dd-yy) or just hit enter for today\'s date:');
          var deadlineInput = stdin.readLineSync();
          if (deadlineInput == null || deadlineInput.isEmpty) {
            break;
          }
          var parts = deadlineInput.split('-');
          if (parts.length != 3) {
            print('Invalid date format. Using today\'s date as the deadline.');
          } else {
            var month = int.parse(parts[0]);
            var day = int.parse(parts[1]);
            var year = int.parse(parts[2]);
            if (year < 100) {
              year += 2000; // Convert two-digit year to four-digit year
            }
            deadline = DateTime(year, month, day);
            break;
          }
        }
        taskManager.createTask(title, description, deadline);
        break;

      case '2':
        if (taskManager.tasks.isEmpty) {
          print('No tasks available.');
          break;
        }
        print('Select a task:');
        for (var i = 0; i < taskManager.tasks.length; i++) {
          print('${i + 1}. ${taskManager.tasks[i].title}');
        }
        var taskIndex = int.parse(stdin.readLineSync() ?? '0') - 1;
        if (taskIndex < 0 || taskIndex >= taskManager.tasks.length) {
          print('Invalid task number. Please try again.');
          break;
        }
        taskManager.startTimer(taskManager.tasks[taskIndex].title);
        break;
      case '3':
        if (taskManager.activeTask == null) {
          print('No active task.');
          break;
        }
        taskManager.stopTimer(taskManager.activeTask!.title);
        break;
      case '4':
        taskManager.listTasks();
        break;
      case '5':
        if (taskManager.tasks.isEmpty) {
          print('No tasks available.');
          break;
        }
        print('Select a task:');
        for (var i = 0; i < taskManager.tasks.length; i++) {
          print('${i + 1}. ${taskManager.tasks[i].title}');
        }
        var taskIndex = int.parse(stdin.readLineSync() ?? '0') - 1;
        if (taskIndex < 0 || taskIndex >= taskManager.tasks.length) {
          print('Invalid task number. Please try again.');
          break;
        }
        taskManager.markTaskAsComplete(taskManager.tasks[taskIndex].title);
        break;
      case '6':
        if (taskManager.activeTask != null) {
          var elapsedTime =
              DateTime.now().difference(taskManager.activeTask!.startTime!);
          print(
              'Elapsed time for active task "${taskManager.activeTask!.title}": ${taskManager.formatDuration(elapsedTime)}');
          var totalTimeSpent =
              taskManager.activeTask!.totalTimeSpent + elapsedTime;
          print(
              'Total time spent on active task "${taskManager.activeTask!.title}": ${taskManager.formatDuration(totalTimeSpent)}');
        } else {
          return;
        }
        break;
      case '7':
        if (taskManager.activeTask != null) {
          return;
        }
        break;
      default:
        print('Invalid option. Please try again.');
    }
  }
}
