import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class OrderActivityFeedWidget extends StatelessWidget {
  final List<dynamic> activities;

  const OrderActivityFeedWidget({
    Key? key,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          final bool isFirst = index == 0;
          final bool isLast = index == activities.length - 1;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline indicator
                Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: _getStatusColor(activity['status']),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: AppTheme.neutral200,
                      ),
                  ],
                ),
                SizedBox(width: 16),

                // Activity content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            activity['status'],
                            style: TextStyle(
                              color: _getStatusColor(activity['status']),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            _formatTimestamp(activity['timestamp']),
                            style: TextStyle(
                              color: AppTheme.neutral500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        activity['description'],
                        style: TextStyle(
                          color: AppTheme.neutral700,
                          fontSize: 14,
                        ),
                      ),
                      if (activity['location'] != null) ...[
                        SizedBox(height: 4),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'location_on',
                              color: AppTheme.neutral500,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              activity['location'],
                              style: TextStyle(
                                color: AppTheme.neutral500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (!isLast) SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'order placed':
        return AppTheme.neutral600;
      case 'confirmed':
        return AppTheme.info600;
      case 'processed':
        return AppTheme.primary600;
      case 'in transit':
        return AppTheme.warning600;
      case 'delivered':
        return AppTheme.success600;
      case 'cancelled':
        return AppTheme.error600;
      default:
        return AppTheme.neutral600;
    }
  }

  String _formatTimestamp(String timestamp) {
    // This is a simple formatter for the mock data
    // In a real app, you would parse the timestamp and format it properly
    return timestamp.split(' ')[0];
  }
}
