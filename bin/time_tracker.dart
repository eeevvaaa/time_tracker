import 'package:time_tracker/task_manager.dart';
import 'package:time_tracker/data_storage.dart';
import 'package:time_tracker/ui.dart';

void main() async {
  var dataStorage = DataStorage(path: 'tasks.json');
  var tasks = await dataStorage.loadTasks();
  var taskManager = TaskManager(tasks: tasks);

  try {
    handleUserInput(taskManager);
  } finally {
    if (taskManager.activeTask != null) {
      taskManager.stopTimer(taskManager.activeTask!.title);
    }
    await dataStorage.saveTasks(taskManager.tasks);
  }
}
