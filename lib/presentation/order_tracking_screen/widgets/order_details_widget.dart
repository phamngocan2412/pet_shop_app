import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class OrderDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsWidget({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Details',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(orderData['status']).withAlpha(26),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _getStatusColor(orderData['status']),
                    width: 1,
                  ),
                ),
                child: Text(
                  _getStatusText(orderData['status']),
                  style: TextStyle(
                    color: _getStatusColor(orderData['status']),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 24),
          _buildDetailRow(
            label: 'Order Number',
            value: orderData['orderId'],
            icon: 'receipt',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Order Date',
            value: orderData['orderDate'],
            icon: 'event',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Expected Delivery',
            value: orderData['expectedDelivery'],
            icon: 'calendar_today',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Tracking Number',
            value: orderData['trackingNumber'],
            icon: 'local_shipping',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Carrier',
            value: orderData['carrier'],
            icon: 'business',
          ),
          Divider(height: 24),
          Text(
            'Shipping Information',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Recipient',
            value: orderData['customerName'],
            icon: 'person',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Address',
            value: orderData['deliveryAddress'],
            icon: 'home',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Contact',
            value: orderData['contactPhone'],
            icon: 'phone',
          ),
          Divider(height: 24),
          Text(
            'Payment Information',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Payment Method',
            value: orderData['paymentMethod'],
            icon: 'credit_card',
          ),
          SizedBox(height: 12),
          _buildDetailRow(
            label: 'Total Amount',
            value: '\$${orderData['totalAmount'].toStringAsFixed(2)}',
            icon: 'attach_money',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required String icon,
    bool isHighlighted = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary700,
            size: 20,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.neutral600,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color:
                      isHighlighted ? AppTheme.primary700 : AppTheme.neutral800,
                  fontWeight:
                      isHighlighted ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppTheme.info600;
      case 'processed':
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
    switch (status) {
      case 'confirmed':
        return 'Confirmed';
      case 'processed':
        return 'Processed';
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
