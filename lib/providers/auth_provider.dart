import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: 'user-1',
    name: 'Alex Learner',
    email: 'alex@learnflow.ai',
    streak: 7,
    completedPaths: 3,
    totalTasksDone: 42,
    achievements: [
      '🔥 7-Day Streak',
      '🎯 First Plan Completed',
      '⚡ 10 Tasks Done',
      '🏆 3 Paths Mastered',
      '📚 Bookworm',
      '🚀 Fast Learner',
    ],
  );

  UserModel get user => _user;

  void incrementStreak() {
    _user = _user.copyWith(streak: _user.streak + 1);
    notifyListeners();
  }

  void incrementCompletedPaths() {
    _user = _user.copyWith(completedPaths: _user.completedPaths + 1);
    notifyListeners();
  }

  void incrementTasksDone() {
    _user = _user.copyWith(totalTasksDone: _user.totalTasksDone + 1);
    notifyListeners();
  }

  void addAchievement(String achievement) {
    if (!_user.achievements.contains(achievement)) {
      final newAchievements = [..._user.achievements, achievement];
      _user = _user.copyWith(achievements: newAchievements);
      notifyListeners();
    }
  }
}
