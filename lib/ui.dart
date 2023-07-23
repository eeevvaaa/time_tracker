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
        print('Enter task description:');
        var description = '';
        while (description.isEmpty) {
          description = stdin.readLineSync() ?? '';
        }
        DateTime? deadline;
        while (deadline == null) {
          print('Enter task deadline (yyyy-mm-dd):');
          var deadlineInput = stdin.readLineSync() ?? '';
          try {
            deadline = DateTime.parse(deadlineInput);
          } catch (e) {
            print('Invalid date. Please try again.');
          }
        }
        taskManager.createTask(title, description, deadline);
        break;
      case '2':
        print('Enter task title:');
        var title = '';
        while (title.isEmpty) {
          title = stdin.readLineSync() ?? '';
        }
        taskManager.startTimer(title);
        break;
      case '3':
        print('Enter task title:');
        var title = '';
        while (title.isEmpty) {
          title = stdin.readLineSync() ?? '';
        }
        taskManager.stopTimer(title);
        break;
      case '4':
        taskManager.listTasks();
        break;
      case '5':
        print('Enter task title:');
        var title = '';
        while (title.isEmpty) {
          title = stdin.readLineSync() ?? '';
        }
        taskManager.markTaskAsComplete(title);
        break;
      case '6':
        return;
      default:
        print('Invalid option');
    }
  }
}
