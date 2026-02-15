import '../models/learning_plan_model.dart';

class PlanService {
  final List<LearningPlanModel> _plans = [];

  List<LearningPlanModel> get plans => List.unmodifiable(_plans);

  void addPlan(LearningPlanModel plan) {
    _plans.insert(0, plan);
  }

  LearningPlanModel? getPlanById(String id) {
    try {
      return _plans.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  void removePlan(String id) {
    _plans.removeWhere((p) => p.id == id);
  }

  int get totalCompletedTasks {
    return _plans.fold<int>(0, (sum, p) => sum + p.completedTaskCount);
  }

  int get totalTasks {
    return _plans.fold<int>(0, (sum, p) => sum + p.totalTaskCount);
  }

  int get completedPlansCount {
    return _plans.where((p) => p.progressPercent >= 1.0).length;
  }
}
