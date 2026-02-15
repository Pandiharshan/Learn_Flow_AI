import '../models/topic_model.dart';
import '../models/learning_plan_model.dart';

class MockAiService {
  static Future<LearningPlanModel> generatePlan({
    required String input,
    required SourceType sourceType,
  }) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 3));

    final String title;
    switch (sourceType) {
      case SourceType.youtube:
        title = 'Flutter Development Masterclass';
        break;
      case SourceType.article:
        title = 'Modern Web Architecture Guide';
        break;
      case SourceType.pdf:
        title = 'Data Structures & Algorithms';
        break;
      case SourceType.notes:
        title = 'Machine Learning Fundamentals';
        break;
    }

    return LearningPlanModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: 'AI-generated learning path based on your content. Follow the structured roadmap to master each topic step by step.',
      sourceType: sourceType,
      sourceInput: input,
      totalDays: 7,
      topics: _getMockTopics(sourceType),
    );
  }

  static List<TopicModel> _getMockTopics(SourceType sourceType) {
    switch (sourceType) {
      case SourceType.youtube:
        return _flutterTopics();
      case SourceType.article:
        return _webDevTopics();
      case SourceType.pdf:
        return _dsaTopics();
      case SourceType.notes:
        return _mlTopics();
    }
  }

  static List<TopicModel> _flutterTopics() {
    return [
      TopicModel(
        id: '1',
        title: 'Dart Fundamentals',
        description: 'Core Dart language concepts including variables, functions, and OOP.',
        icon: '🎯',
        dayNumber: 1,
        tasks: [
          TaskItem(id: '1-1', title: 'Variables & Data Types', description: 'Learn about int, double, String, bool, var, and final'),
          TaskItem(id: '1-2', title: 'Functions & Parameters', description: 'Named, positional, and optional parameters'),
          TaskItem(id: '1-3', title: 'Null Safety Basics', description: 'Understanding nullable types and null-aware operators'),
        ],
      ),
      TopicModel(
        id: '2',
        title: 'Flutter Widgets',
        description: 'Understanding the widget tree, stateless and stateful widgets.',
        icon: '🧱',
        dayNumber: 2,
        tasks: [
          TaskItem(id: '2-1', title: 'StatelessWidget vs StatefulWidget', description: 'When to use each type'),
          TaskItem(id: '2-2', title: 'Common Widgets', description: 'Text, Container, Row, Column, Stack'),
          TaskItem(id: '2-3', title: 'Build a Profile Card', description: 'Practice combining widgets together'),
        ],
      ),
      TopicModel(
        id: '3',
        title: 'Layouts & Navigation',
        description: 'Mastering layout patterns and screen navigation.',
        icon: '🗺️',
        dayNumber: 3,
        tasks: [
          TaskItem(id: '3-1', title: 'Flex Layouts', description: 'Expanded, Flexible, MainAxisAlignment'),
          TaskItem(id: '3-2', title: 'Navigator & Routes', description: 'Push, pop, named routes'),
          TaskItem(id: '3-3', title: 'Bottom Navigation Bar', description: 'Build a multi-tab app'),
        ],
      ),
      TopicModel(
        id: '4',
        title: 'State Management',
        description: 'Managing app state with Provider pattern.',
        icon: '⚡',
        dayNumber: 4,
        tasks: [
          TaskItem(id: '4-1', title: 'setState Basics', description: 'Understanding local state'),
          TaskItem(id: '4-2', title: 'Provider Pattern', description: 'ChangeNotifier and Consumer'),
          TaskItem(id: '4-3', title: 'Build a Todo App', description: 'Practice state management'),
        ],
      ),
      TopicModel(
        id: '5',
        title: 'API Integration',
        description: 'Fetching and displaying data from REST APIs.',
        icon: '🌐',
        dayNumber: 5,
        tasks: [
          TaskItem(id: '5-1', title: 'HTTP Package', description: 'GET and POST requests'),
          TaskItem(id: '5-2', title: 'JSON Parsing', description: 'fromJson and toJson patterns'),
          TaskItem(id: '5-3', title: 'Build a News App', description: 'Fetch and display API data'),
        ],
      ),
      TopicModel(
        id: '6',
        title: 'Animations & Polish',
        description: 'Adding life to your app with animations.',
        icon: '✨',
        dayNumber: 6,
        tasks: [
          TaskItem(id: '6-1', title: 'Implicit Animations', description: 'AnimatedContainer, AnimatedOpacity'),
          TaskItem(id: '6-2', title: 'Hero Animations', description: 'Shared element transitions'),
          TaskItem(id: '6-3', title: 'Custom Animations', description: 'AnimationController basics'),
        ],
      ),
      TopicModel(
        id: '7',
        title: 'Deployment',
        description: 'Building and releasing your Flutter app.',
        icon: '🚀',
        dayNumber: 7,
        tasks: [
          TaskItem(id: '7-1', title: 'Build Configurations', description: 'Debug vs release mode'),
          TaskItem(id: '7-2', title: 'App Icons & Splash', description: 'Customize launch experience'),
          TaskItem(id: '7-3', title: 'Deploy to Play Store', description: 'Generate APK and publish'),
        ],
      ),
    ];
  }

  static List<TopicModel> _webDevTopics() {
    return [
      TopicModel(id: '1', title: 'HTML5 Semantics', description: 'Modern HTML structure and accessibility.', icon: '🏗️', dayNumber: 1,
        tasks: [TaskItem(id: '1-1', title: 'Semantic Elements'), TaskItem(id: '1-2', title: 'Forms & Validation'), TaskItem(id: '1-3', title: 'Accessibility Basics')]),
      TopicModel(id: '2', title: 'CSS3 & Flexbox', description: 'Responsive design with modern CSS.', icon: '🎨', dayNumber: 2,
        tasks: [TaskItem(id: '2-1', title: 'Flexbox Layout'), TaskItem(id: '2-2', title: 'CSS Grid'), TaskItem(id: '2-3', title: 'Media Queries')]),
      TopicModel(id: '3', title: 'JavaScript ES6+', description: 'Modern JavaScript features.', icon: '⚡', dayNumber: 3,
        tasks: [TaskItem(id: '3-1', title: 'Arrow Functions & Destructuring'), TaskItem(id: '3-2', title: 'Promises & Async/Await'), TaskItem(id: '3-3', title: 'Modules & Imports')]),
      TopicModel(id: '4', title: 'React Basics', description: 'Component-based UI development.', icon: '⚛️', dayNumber: 4,
        tasks: [TaskItem(id: '4-1', title: 'Components & Props'), TaskItem(id: '4-2', title: 'State & Hooks'), TaskItem(id: '4-3', title: 'Event Handling')]),
      TopicModel(id: '5', title: 'API & Backend', description: 'Connect frontend to backend services.', icon: '🔗', dayNumber: 5,
        tasks: [TaskItem(id: '5-1', title: 'REST API Design'), TaskItem(id: '5-2', title: 'Fetch & Axios'), TaskItem(id: '5-3', title: 'Error Handling')]),
      TopicModel(id: '6', title: 'Testing & DevTools', description: 'Debugging and quality assurance.', icon: '🧪', dayNumber: 6,
        tasks: [TaskItem(id: '6-1', title: 'Chrome DevTools'), TaskItem(id: '6-2', title: 'Unit Testing'), TaskItem(id: '6-3', title: 'Performance Profiling')]),
      TopicModel(id: '7', title: 'Deployment', description: 'Ship your web app to production.', icon: '🚀', dayNumber: 7,
        tasks: [TaskItem(id: '7-1', title: 'Build Optimization'), TaskItem(id: '7-2', title: 'CI/CD Pipeline'), TaskItem(id: '7-3', title: 'Cloud Hosting')]),
    ];
  }

  static List<TopicModel> _dsaTopics() {
    return [
      TopicModel(id: '1', title: 'Arrays & Strings', description: 'Fundamental data structures.', icon: '📊', dayNumber: 1,
        tasks: [TaskItem(id: '1-1', title: 'Array Operations'), TaskItem(id: '1-2', title: 'String Manipulation'), TaskItem(id: '1-3', title: 'Two Pointer Technique')]),
      TopicModel(id: '2', title: 'Linked Lists', description: 'Dynamic data structures.', icon: '🔗', dayNumber: 2,
        tasks: [TaskItem(id: '2-1', title: 'Singly Linked List'), TaskItem(id: '2-2', title: 'Doubly Linked List'), TaskItem(id: '2-3', title: 'Reverse a Linked List')]),
      TopicModel(id: '3', title: 'Stacks & Queues', description: 'LIFO and FIFO patterns.', icon: '📚', dayNumber: 3,
        tasks: [TaskItem(id: '3-1', title: 'Stack Implementation'), TaskItem(id: '3-2', title: 'Queue Variants'), TaskItem(id: '3-3', title: 'Balanced Parentheses')]),
      TopicModel(id: '4', title: 'Trees & BST', description: 'Hierarchical data structures.', icon: '🌳', dayNumber: 4,
        tasks: [TaskItem(id: '4-1', title: 'Binary Tree Traversals'), TaskItem(id: '4-2', title: 'BST Operations'), TaskItem(id: '4-3', title: 'Tree Height & Depth')]),
      TopicModel(id: '5', title: 'Sorting Algorithms', description: 'Comparison and non-comparison sorts.', icon: '🔀', dayNumber: 5,
        tasks: [TaskItem(id: '5-1', title: 'Merge Sort'), TaskItem(id: '5-2', title: 'Quick Sort'), TaskItem(id: '5-3', title: 'Time Complexity Analysis')]),
      TopicModel(id: '6', title: 'Graphs', description: 'Graph representations and traversals.', icon: '🕸️', dayNumber: 6,
        tasks: [TaskItem(id: '6-1', title: 'BFS & DFS'), TaskItem(id: '6-2', title: 'Adjacency List/Matrix'), TaskItem(id: '6-3', title: 'Shortest Path')]),
      TopicModel(id: '7', title: 'Dynamic Programming', description: 'Optimization through subproblems.', icon: '🧠', dayNumber: 7,
        tasks: [TaskItem(id: '7-1', title: 'Memoization vs Tabulation'), TaskItem(id: '7-2', title: 'Classic DP Problems'), TaskItem(id: '7-3', title: 'Practice on LeetCode')]),
    ];
  }

  static List<TopicModel> _mlTopics() {
    return [
      TopicModel(id: '1', title: 'Python for ML', description: 'Essential Python for machine learning.', icon: '🐍', dayNumber: 1,
        tasks: [TaskItem(id: '1-1', title: 'NumPy Basics'), TaskItem(id: '1-2', title: 'Pandas DataFrames'), TaskItem(id: '1-3', title: 'Matplotlib Visualization')]),
      TopicModel(id: '2', title: 'Data Preprocessing', description: 'Cleaning and preparing data.', icon: '🧹', dayNumber: 2,
        tasks: [TaskItem(id: '2-1', title: 'Handling Missing Data'), TaskItem(id: '2-2', title: 'Feature Scaling'), TaskItem(id: '2-3', title: 'Encoding Categorical Data')]),
      TopicModel(id: '3', title: 'Supervised Learning', description: 'Learning from labeled data.', icon: '🏷️', dayNumber: 3,
        tasks: [TaskItem(id: '3-1', title: 'Linear Regression'), TaskItem(id: '3-2', title: 'Logistic Regression'), TaskItem(id: '3-3', title: 'Model Evaluation')]),
      TopicModel(id: '4', title: 'Decision Trees & Forests', description: 'Tree-based models.', icon: '🌲', dayNumber: 4,
        tasks: [TaskItem(id: '4-1', title: 'Decision Tree Classifier'), TaskItem(id: '4-2', title: 'Random Forest'), TaskItem(id: '4-3', title: 'Feature Importance')]),
      TopicModel(id: '5', title: 'Neural Networks', description: 'Introduction to deep learning.', icon: '🧠', dayNumber: 5,
        tasks: [TaskItem(id: '5-1', title: 'Perceptron Model'), TaskItem(id: '5-2', title: 'Activation Functions'), TaskItem(id: '5-3', title: 'Build with TensorFlow')]),
      TopicModel(id: '6', title: 'Model Optimization', description: 'Tuning and improving models.', icon: '⚙️', dayNumber: 6,
        tasks: [TaskItem(id: '6-1', title: 'Hyperparameter Tuning'), TaskItem(id: '6-2', title: 'Cross-Validation'), TaskItem(id: '6-3', title: 'Regularization')]),
      TopicModel(id: '7', title: 'ML Project', description: 'Build an end-to-end ML project.', icon: '🚀', dayNumber: 7,
        tasks: [TaskItem(id: '7-1', title: 'Problem Definition'), TaskItem(id: '7-2', title: 'Model Training & Testing'), TaskItem(id: '7-3', title: 'Deploy with Flask')]),
    ];
  }

  /// Pre-built plan for dashboard demo
  static LearningPlanModel getSampleCompletedPlan() {
    final topics = _flutterTopics();
    // Mark first 3 topics as completed for demo
    for (int i = 0; i < 3; i++) {
      for (var task in topics[i].tasks) {
        task.isCompleted = true;
      }
    }
    return LearningPlanModel(
      id: 'sample-1',
      title: 'Flutter Development Masterclass',
      description: 'A complete guide to Flutter development.',
      sourceType: SourceType.youtube,
      sourceInput: 'https://youtube.com/example',
      topics: topics,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    );
  }
}
