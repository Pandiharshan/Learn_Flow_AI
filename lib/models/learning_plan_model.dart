import 'topic_model.dart';

enum SourceType { youtube, article, pdf, notes }

class LearningPlanModel {
  final String id;
  final String title;
  final String description;
  final SourceType sourceType;
  final String sourceInput;
  final List<TopicModel> topics;
  final int totalDays;
  final DateTime createdAt;

  LearningPlanModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.sourceType,
    this.sourceInput = '',
    required this.topics,
    this.totalDays = 7,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get progressPercent {
    if (topics.isEmpty) return 0;
    final totalTasks = topics.fold<int>(0, (sum, t) => sum + t.tasks.length);
    if (totalTasks == 0) return 0;
    final completedTasks = topics.fold<int>(
      0,
      (sum, t) => sum + t.tasks.where((task) => task.isCompleted).length,
    );
    return completedTasks / totalTasks;
  }

  int get completedTaskCount {
    return topics.fold<int>(
      0,
      (sum, t) => sum + t.tasks.where((task) => task.isCompleted).length,
    );
  }

  int get totalTaskCount {
    return topics.fold<int>(0, (sum, t) => sum + t.tasks.length);
  }

  String get sourceTypeLabel {
    switch (sourceType) {
      case SourceType.youtube:
        return 'YouTube';
      case SourceType.article:
        return 'Article';
      case SourceType.pdf:
        return 'PDF';
      case SourceType.notes:
        return 'Notes';
    }
  }

  String get sourceTypeIcon {
    switch (sourceType) {
      case SourceType.youtube:
        return '🎬';
      case SourceType.article:
        return '📰';
      case SourceType.pdf:
        return '📄';
      case SourceType.notes:
        return '📝';
    }
  }

  List<TopicModel> getTopicsForDay(int day) {
    return topics.where((t) => t.dayNumber == day).toList();
  }
}
