import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../models/topic_model.dart';
import '../../providers/plan_provider.dart';
import '../../widgets/progress_bar.dart';

class SkillPathScreen extends StatefulWidget {
  const SkillPathScreen({super.key});

  @override
  State<SkillPathScreen> createState() => _SkillPathScreenState();
}

class _SkillPathScreenState extends State<SkillPathScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plan = context.watch<PlanProvider>().currentPlan;

    if (plan == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => context.go('/dashboard'),
          ),
        ),
        body: Center(
          child: Text(
            'No plan selected',
            style: GoogleFonts.nunito(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/dashboard'),
        ),
        title: Text(
          plan.title,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${(plan.progressPercent * 100).toInt()}%',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Overall Progress
          Container(
            color: AppColors.cardWhite,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppProgressBar(
                  percent: plan.progressPercent,
                  label: AppStrings.overallProgress,
                ),
                const SizedBox(height: 8),
                Text(
                  '${plan.completedTaskCount} of ${plan.totalTaskCount} tasks completed',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Day Tabs
          Container(
            color: AppColors.cardWhite,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textLight,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelStyle: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabAlignment: TabAlignment.start,
              tabs: List.generate(
                7,
                (i) => Tab(text: '${AppStrings.dayLabel} ${i + 1}'),
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(7, (dayIndex) {
                final dayTopics = plan.getTopicsForDay(dayIndex + 1);
                if (dayTopics.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('📖', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          'Rest day! Review previous topics.',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: dayTopics.asMap().entries.map((entry) {
                      return _buildTopicNode(
                        context,
                        entry.value,
                        isLast: entry.key == dayTopics.length - 1,
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicNode(BuildContext context, TopicModel topic, {bool isLast = false}) {
    final isComplete = topic.isCompleted;

    return Column(
      children: [
        // Node connector line top
        if (topic.id != '1')
          Container(
            width: 3,
            height: 20,
            decoration: BoxDecoration(
              color: isComplete ? AppColors.primary : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

        // Topic Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(18),
            border: isComplete
                ? Border.all(color: AppColors.primary, width: 2)
                : Border.all(color: AppColors.surfaceLight, width: 1),
            boxShadow: AppColors.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isComplete
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        topic.icon,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic.title,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          topic.description,
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (isComplete)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              // Task checklist
              ...topic.tasks.map(
                (task) => _TaskCheckItem(
                  task: task,
                  topicId: topic.id,
                ),
              ),
              // Progress for this topic
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: topic.completionPercent,
                        backgroundColor: AppColors.surfaceLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${(topic.completionPercent * 100).toInt()}%',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isComplete ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Node connector line bottom
        if (!isLast)
          Container(
            width: 3,
            height: 20,
            decoration: BoxDecoration(
              color: isComplete ? AppColors.primary : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}

class _TaskCheckItem extends StatelessWidget {
  final TaskItem task;
  final String topicId;

  const _TaskCheckItem({
    required this.task,
    required this.topicId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PlanProvider>().toggleTask(topicId, task.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: task.isCompleted
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: task.isCompleted ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: task.isCompleted ? AppColors.primary : AppColors.textLight,
                  width: 2,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task.title,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: task.isCompleted
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
