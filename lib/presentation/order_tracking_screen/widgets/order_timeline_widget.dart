import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class OrderTimelineWidget extends StatelessWidget {
  final int currentStage;
  final bool isDelayed;

  const OrderTimelineWidget({
    Key? key,
    required this.currentStage,
    this.isDelayed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> stages = [
      {
        "title": "Confirmed",
        "icon": "check_circle",
        "description": "Order confirmed",
      },
      {
        "title": "Processed",
        "icon": "inventory",
        "description": "Order processed",
      },
      {
        "title": "In Transit",
        "icon": "local_shipping",
        "description": "On the way",
      },
      {
        "title": "Delivered",
        "icon": "home",
        "description": "Order delivered",
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.primary800,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: List.generate(
              stages.length,
              (index) {
                final bool isCompleted = index <= currentStage;
                final bool isCurrent = index == currentStage;

                return Expanded(
                  child: Row(
                    children: [
                      // Stage indicator
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? (isDelayed && isCurrent
                                      ? AppTheme.warning600
                                      : AppTheme.primary400)
                                  : AppTheme.neutral300,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: CustomIconWidget(
                                iconName: stages[index]['icon'],
                                color: isCompleted
                                    ? Colors.white
                                    : AppTheme.neutral500,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            stages[index]['title'],
                            style: TextStyle(
                              color: isCompleted
                                  ? Colors.white
                                  : AppTheme.neutral300,
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            stages[index]['description'],
                            style: TextStyle(
                              color: isCompleted
                                  ? AppTheme.primary100
                                  : AppTheme.neutral400,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // Connector line
                      if (index < stages.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index < currentStage
                                ? AppTheme.primary400
                                : AppTheme.neutral300,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Delay indicator
          if (isDelayed)
            Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.warning600,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'warning_amber',
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Delivery Delayed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
