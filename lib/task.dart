class Task {
  String title;
  String description;
  DateTime deadline;
  Duration totalTimeSpent = Duration.zero;
  bool isComplete;
  DateTime? startTime;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
    this.totalTimeSpent = const Duration(),
    this.isComplete = false,
    this.startTime,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'deadline': deadline.toIso8601String(),
        'totalTimeSpent': totalTimeSpent.inSeconds,
        'isComplete': isComplete,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        description: json['description'],
        deadline: DateTime.parse(json['deadline']),
        totalTimeSpent: Duration(seconds: json['totalTimeSpent']),
        isComplete: json['isComplete'],
      );
}
