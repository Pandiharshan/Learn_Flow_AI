import 'package:flutter/material.dart';
import '../models/learning_plan_model.dart';

class Helpers {
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  static IconData getSourceIcon(SourceType type) {
    switch (type) {
      case SourceType.youtube:
        return Icons.play_circle_filled_rounded;
      case SourceType.article:
        return Icons.article_rounded;
      case SourceType.pdf:
        return Icons.picture_as_pdf_rounded;
      case SourceType.notes:
        return Icons.edit_note_rounded;
    }
  }

  static Color getSourceColor(SourceType type) {
    switch (type) {
      case SourceType.youtube:
        return const Color(0xFFFF4B4B);
      case SourceType.article:
        return const Color(0xFF1CB0F6);
      case SourceType.pdf:
        return const Color(0xFFFF9600);
      case SourceType.notes:
        return const Color(0xFFCE82FF);
    }
  }
}
