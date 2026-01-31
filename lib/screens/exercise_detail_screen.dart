import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';
import '../utils/haptic_feedback.dart';
import 'exercise_session_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      AppHaptics.lightTap();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.surfaceColor,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and title
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: exercise.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                        ),
                        child: Icon(
                          exercise.icon,
                          size: 50,
                          color: exercise.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    Center(
                      child: Text(
                        exercise.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd,
                          vertical: AppTheme.spacingSm,
                        ),
                        decoration: BoxDecoration(
                          color: exercise.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 16,
                              color: exercise.color,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              exercise.duration,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: exercise.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXl),
                    // Description
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(
                      exercise.fullDescription,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: AppTheme.textColor.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    // Evidence basis
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingMd),
                      decoration: BoxDecoration(
                        color: exercise.color.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(
                          color: exercise.color.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.science_outlined,
                            color: exercise.color,
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingMd),
                          Expanded(
                            child: Text(
                              exercise.evidenceBasis,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLg),
                    // Benefits
                    Text(
                      'Benefits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    ...exercise.benefits.map((benefit) => Padding(
                          padding: const EdgeInsets.only(bottom: AppTheme.spacingMd),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: exercise.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppTheme.spacingMd),
                              Expanded(
                                child: Text(
                                  benefit,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppTheme.textColor.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: AppTheme.spacingXl),
                  ],
                ),
              ),
            ),
            // Start button
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AppHaptics.mediumTap();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExerciseSessionScreen(
                          exercise: exercise,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exercise.color,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  child: const Text(
                    'Start Exercise',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
