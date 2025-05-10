import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PreparationStepWidget extends StatelessWidget {
  final Map<String, dynamic> step;
  final Function(bool) onToggle;

  const PreparationStepWidget({
    Key? key,
    required this.step,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = step['completed'];
    final bool isPastDue = !isCompleted && _isPastDue(step['dueDate']);

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppTheme.success100
            : isPastDue
                ? AppTheme.error100
                : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted
              ? AppTheme.success600.withAlpha(128)
              : isPastDue
                  ? AppTheme.error600.withAlpha(128)
                  : AppTheme.neutral200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Checkbox(
            value: isCompleted,
            onChanged: (value) => onToggle(value ?? false),
            activeColor: AppTheme.success600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 8),

          // Step details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      step['title'],
                      style: TextStyle(
                        color: isCompleted
                            ? AppTheme.success600
                            : isPastDue
                                ? AppTheme.error600
                                : AppTheme.neutral800,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppTheme.success600
                            : isPastDue
                                ? AppTheme.error600
                                : AppTheme.primary600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        isCompleted ? 'Completed' : 'Due ${step['dueDate']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  step['description'],
                  style: TextStyle(
                    color: isCompleted
                        ? AppTheme.success600
                        : isPastDue
                            ? AppTheme.error600
                            : AppTheme.neutral600,
                    fontSize: 14,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                if (isPastDue) ...[
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'warning_amber',
                        color: AppTheme.error600,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Past due! Please complete as soon as possible.',
                        style: TextStyle(
                          color: AppTheme.error600,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isPastDue(String dueDate) {
    try {
      final due = DateTime.parse(dueDate);
      final now = DateTime.now();
      return due.isBefore(now);
    } catch (e) {
      // If date parsing fails, assume it's not past due
      return false;
    }
  }
}
