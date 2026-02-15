import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../core/constants/colors.dart';

class AppProgressBar extends StatelessWidget {
  final double percent;
  final String? label;
  final double height;
  final LinearGradient? gradient;

  const AppProgressBar({
    super.key,
    required this.percent,
    this.label,
    this.height = 10,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label!,
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${(percent * 100).toInt()}%',
                style: GoogleFonts.nunito(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: height,
          percent: percent.clamp(0.0, 1.0),
          backgroundColor: AppColors.surfaceLight,
          linearGradient: gradient ?? AppColors.primaryGradient,
          barRadius: Radius.circular(height / 2),
          animation: true,
          animationDuration: 800,
        ),
      ],
    );
  }
}
