class TaskItem {
  final String id;
  final String title;
  final String description;
  bool isCompleted;

  TaskItem({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  });
}

class TopicModel {
  final String id;
  final String title;
  final String description;
  final String icon;
  final List<TaskItem> tasks;
  final int dayNumber;

  TopicModel({
    required this.id,
    required this.title,
    required this.description,
    this.icon = '📘',
    required this.tasks,
    this.dayNumber = 1,
  });

  double get completionPercent {
    if (tasks.isEmpty) return 0;
    final completed = tasks.where((t) => t.isCompleted).length;
    return completed / tasks.length;
  }

  bool get isCompleted => tasks.every((t) => t.isCompleted);
}
