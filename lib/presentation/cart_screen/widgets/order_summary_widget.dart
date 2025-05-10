import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double shipping;
  final double discount;
  final double total;

  const OrderSummaryWidget({
    Key? key,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.discount,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        SizedBox(height: 16),

        // Summary items
        _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
        _buildSummaryRow('Tax (8%)', '\$${tax.toStringAsFixed(2)}'),
        _buildSummaryRow('Shipping',
            shipping == 0 ? 'FREE' : '\$${shipping.toStringAsFixed(2)}'),

        if (discount > 0)
          _buildSummaryRow(
            'Discount',
            '-\$${discount.toStringAsFixed(2)}',
            valueColor: AppTheme.success600,
          ),

        SizedBox(height: 16),
        Divider(thickness: 1),
        SizedBox(height: 16),

        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.neutral800,
              ),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.neutral600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor ?? AppTheme.neutral800,
            ),
          ),
        ],
      ),
    );
  }
}
