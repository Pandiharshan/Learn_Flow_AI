import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../models/learning_plan_model.dart';
import '../../providers/plan_provider.dart';
import '../../widgets/input_card.dart';
import '../../widgets/loader.dart';

class GeneratePlanScreen extends StatefulWidget {
  const GeneratePlanScreen({super.key});

  @override
  State<GeneratePlanScreen> createState() => _GeneratePlanScreenState();
}

class _GeneratePlanScreenState extends State<GeneratePlanScreen> {
  SourceType _selectedSource = SourceType.youtube;
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onGenerate() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter some content to generate a plan',
            style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.accentOrange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    await context.read<PlanProvider>().generatePlan(
          input: input,
          sourceType: _selectedSource,
        );

    if (mounted) {
      context.push('/skill-path');
    }
  }

  @override
  Widget build(BuildContext context) {
    final planProvider = context.watch<PlanProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.generatePlan,
                          style: GoogleFonts.nunito(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Choose a source and provide your content',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Source Type Selection
                  Text(
                    AppStrings.selectSource,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InputCard(
                    icon: Icons.play_circle_fill_rounded,
                    title: AppStrings.youtubeLink,
                    subtitle: 'Paste a YouTube video link',
                    isSelected: _selectedSource == SourceType.youtube,
                    onTap: () => setState(() => _selectedSource = SourceType.youtube),
                  ),
                  const SizedBox(height: 8),
                  InputCard(
                    icon: Icons.article_rounded,
                    title: AppStrings.articleLink,
                    subtitle: 'Paste a web article URL',
                    isSelected: _selectedSource == SourceType.article,
                    onTap: () => setState(() => _selectedSource = SourceType.article),
                  ),
                  const SizedBox(height: 8),
                  InputCard(
                    icon: Icons.picture_as_pdf_rounded,
                    title: AppStrings.pdfUpload,
                    subtitle: 'Upload a PDF document',
                    isSelected: _selectedSource == SourceType.pdf,
                    onTap: () => setState(() => _selectedSource = SourceType.pdf),
                  ),
                  const SizedBox(height: 8),
                  InputCard(
                    icon: Icons.edit_note_rounded,
                    title: AppStrings.personalNotes,
                    subtitle: 'Type your own notes or topics',
                    isSelected: _selectedSource == SourceType.notes,
                    onTap: () => setState(() => _selectedSource = SourceType.notes),
                  ),
                  const SizedBox(height: 24),

                  // Input Field
                  Text(
                    'Your Content',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppColors.cardShadow,
                    ),
                    child: TextField(
                      controller: _inputController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: _getHintText(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.cardWhite,
                      ),
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Generate Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: planProvider.isLoading ? null : _onGenerate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        disabledBackgroundColor: AppColors.surfaceLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome_rounded, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.createPlan,
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          // Loading overlay
          if (planProvider.isLoading)
            Loader(message: planProvider.loadingMessage),
        ],
      ),
    );
  }

  String _getHintText() {
    switch (_selectedSource) {
      case SourceType.youtube:
        return 'https://youtube.com/watch?v=...';
      case SourceType.article:
        return 'https://medium.com/...';
      case SourceType.pdf:
        return 'Paste the main text from your PDF here...';
      case SourceType.notes:
        return 'Type your study notes, topics, or learning goals...';
    }
  }
}
