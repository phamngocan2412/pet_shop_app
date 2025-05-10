import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ShippingOptionWidget extends StatelessWidget {
  final Map<String, dynamic> option;
  final bool isSelected;
  final VoidCallback onSelect;
  final bool isFreeShipping;

  const ShippingOptionWidget({
    Key? key,
    required this.option,
    required this.isSelected,
    required this.onSelect,
    this.isFreeShipping = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double originalPrice = option["price"];
    final bool isActuallyFree = originalPrice == 0 || isFreeShipping;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppTheme.primary600 : Colors.transparent,
          width: isSelected ? 2 : 0,
        ),
      ),
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Radio button
              Radio(
                value: true,
                groupValue: isSelected,
                onChanged: (_) => onSelect(),
                activeColor: AppTheme.primary600,
              ),
              SizedBox(width: 8),

              // Icon
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary100 : AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: option["icon"],
                  color: isSelected ? AppTheme.primary700 : AppTheme.neutral600,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppTheme.primary700
                            : AppTheme.neutral800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      option["estimatedDelivery"],
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.neutral600,
                      ),
                    ),
                  ],
                ),
              ),

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isFreeShipping && originalPrice > 0)
                    Text(
                      '\$${originalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.neutral500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Text(
                    isActuallyFree
                        ? 'FREE'
                        : '\$${originalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isActuallyFree
                          ? AppTheme.success600
                          : AppTheme.neutral800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
