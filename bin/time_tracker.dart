import 'package:time_tracker/task_manager.dart';
import 'package:time_tracker/data_storage.dart';
import 'package:time_tracker/ui.dart';

void main() async {
  var dataStorage = DataStorage(path: 'tasks.json');
  var tasks = await dataStorage.loadTasks();
  var taskManager = TaskManager(tasks: tasks);
  handleUserInput(taskManager);
  await dataStorage.saveTasks(taskManager.tasks);
}
