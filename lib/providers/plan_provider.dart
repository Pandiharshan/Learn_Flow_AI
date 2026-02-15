import 'package:flutter/material.dart';
import '../models/learning_plan_model.dart';
import '../services/mock_ai_service.dart';
import '../services/plan_service.dart';

class PlanProvider extends ChangeNotifier {
  final PlanService _planService = PlanService();
  LearningPlanModel? _currentPlan;
  bool _isLoading = false;
  String _loadingMessage = '';

  PlanProvider() {
    // Add a sample completed plan for dashboard demo
    _planService.addPlan(MockAiService.getSampleCompletedPlan());
  }

  List<LearningPlanModel> get plans => _planService.plans;
  LearningPlanModel? get currentPlan => _currentPlan;
  bool get isLoading => _isLoading;
  String get loadingMessage => _loadingMessage;
  int get totalCompletedTasks => _planService.totalCompletedTasks;
  int get completedPlansCount => _planService.completedPlansCount;

  Future<void> generatePlan({
    required String input,
    required SourceType sourceType,
  }) async {
    _isLoading = true;
    _loadingMessage = 'Analyzing your content...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));
    _loadingMessage = 'Extracting key topics...';
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));
    _loadingMessage = 'Building your learning roadmap...';
    notifyListeners();

    final plan = await MockAiService.generatePlan(
      input: input,
      sourceType: sourceType,
    );

    _planService.addPlan(plan);
    _currentPlan = plan;
    _isLoading = false;
    _loadingMessage = '';
    notifyListeners();
  }

  void setCurrentPlan(String planId) {
    _currentPlan = _planService.getPlanById(planId);
    notifyListeners();
  }

  void toggleTask(String topicId, String taskId) {
    if (_currentPlan == null) return;
    for (var topic in _currentPlan!.topics) {
      if (topic.id == topicId) {
        for (var task in topic.tasks) {
          if (task.id == taskId) {
            task.isCompleted = !task.isCompleted;
            notifyListeners();
            return;
          }
        }
      }
    }
  }

  void removePlan(String id) {
    _planService.removePlan(id);
    if (_currentPlan?.id == id) {
      _currentPlan = null;
    }
    notifyListeners();
  }
}
