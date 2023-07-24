import 'dart:io';
import 'task_manager.dart';

void printMenu() {
  print('1. Create a new task');
  print('2. Start timer for a task');
  print('3. Stop timer for a task');
  print('4. List all tasks');
  print('5. Mark a task as complete');
  print('6. Exit');
}

void handleUserInput(TaskManager taskManager) {
  while (true) {
    printMenu();
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
              'Enter task deadline (yyyy-mm-dd) or just hit enter for today\'s date:');
          var deadlineInput = stdin.readLineSync();
          if (deadlineInput == null || deadlineInput.isEmpty) {
            break;
          }
          try {
            deadline = DateTime.parse(deadlineInput);
            break;
          } catch (e) {
            print('Invalid date. Please try again.');
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
        return;
      default:
        print('Invalid option');
    }
  }
}
