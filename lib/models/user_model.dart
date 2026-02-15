class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final int streak;
  final int completedPaths;
  final int totalTasksDone;
  final List<String> achievements;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl = '',
    this.streak = 0,
    this.completedPaths = 0,
    this.totalTasksDone = 0,
    this.achievements = const [],
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    int? streak,
    int? completedPaths,
    int? totalTasksDone,
    List<String>? achievements,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      streak: streak ?? this.streak,
      completedPaths: completedPaths ?? this.completedPaths,
      totalTasksDone: totalTasksDone ?? this.totalTasksDone,
      achievements: achievements ?? this.achievements,
    );
  }
}
