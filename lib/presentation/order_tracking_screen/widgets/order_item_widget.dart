import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class OrderItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPet = item['type'] == 'Pet';

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageWidget(
              imageUrl: item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),

          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            isPet ? AppTheme.primary100 : AppTheme.neutral100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        item['type'],
                        style: TextStyle(
                          color:
                              isPet ? AppTheme.primary700 : AppTheme.neutral700,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(item['status']).withAlpha(26),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        _getStatusText(item['status']),
                        style: TextStyle(
                          color: _getStatusColor(item['status']),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  item['name'],
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item['price'].toStringAsFixed(2)} ${item['quantity'] > 1 ? 'x ${item['quantity']}' : ''}',
                      style: TextStyle(
                        color: AppTheme.primary700,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (item['estimatedArrival'] != null)
                      Text(
                        'Arrives: ${item['estimatedArrival']}',
                        style: TextStyle(
                          color: AppTheme.neutral600,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                if (isPet) ...[
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'pets',
                        color: AppTheme.primary600,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Special care instructions included',
                        style: TextStyle(
                          color: AppTheme.primary600,
                          fontSize: 12,
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return AppTheme.info600;
      case 'processed':
      case 'shipped':
        return AppTheme.primary600;
      case 'in_transit':
        return AppTheme.warning600;
      case 'delivered':
        return AppTheme.success600;
      case 'cancelled':
        return AppTheme.error600;
      default:
        return AppTheme.neutral600;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Confirmed';
      case 'processed':
        return 'Processed';
      case 'shipped':
        return 'Shipped';
      case 'in_transit':
        return 'In Transit';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
