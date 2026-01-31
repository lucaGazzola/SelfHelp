import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';

class GroundingStepCard extends StatelessWidget {
  final GroundingStep step;
  final int currentCount;
  final bool isActive;
  final bool isComplete;
  final Color color;
  final VoidCallback? onItemTap;

  const GroundingStepCard({
    super.key,
    required this.step,
    required this.currentCount,
    required this.isActive,
    required this.isComplete,
    required this.color,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppTheme.mediumAnimation,
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: isActive
            ? color.withOpacity(0.1)
            : isComplete
                ? AppTheme.surfaceColor
                : AppTheme.surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isActive
              ? color
              : isComplete
                  ? color.withOpacity(0.3)
                  : Colors.transparent,
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Count badge
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isActive || isComplete
                      ? color.withOpacity(isActive ? 0.2 : 0.1)
                      : AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Center(
                  child: isComplete
                      ? Icon(
                          Icons.check_rounded,
                          color: color,
                          size: 28,
                        )
                      : Text(
                          '${step.count}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: isActive ? color : AppTheme.textColor.withOpacity(0.4),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              // Sense info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          step.icon,
                          size: 18,
                          color: isActive ? color : AppTheme.textColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          step.sense,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isActive ? color : AppTheme.textColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.instruction,
                      style: TextStyle(
                        fontSize: 15,
                        color: isActive
                            ? AppTheme.textColor
                            : AppTheme.textColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: AppTheme.spacingLg),
            // Progress indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(step.count, (index) {
                final isItemComplete = index < currentCount;
                return GestureDetector(
                  onTap: onItemTap,
                  child: AnimatedContainer(
                    duration: AppTheme.shortAnimation,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isItemComplete ? 32 : 28,
                    height: isItemComplete ? 32 : 28,
                    decoration: BoxDecoration(
                      color: isItemComplete ? color : color.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isItemComplete
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Center(
              child: Text(
                'Tap the circle for each thing you notice',
                style: TextStyle(
                  fontSize: 13,
                  color: AppTheme.textColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
