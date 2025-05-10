import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PaymentMethodWidget extends StatelessWidget {
  final Map<String, dynamic> paymentMethod;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentMethodWidget({
    Key? key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAddNew = paymentMethod["type"] == "Add New Card";

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppTheme.primary600 : AppTheme.neutral200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Radio(
                value: true,
                groupValue: isSelected,
                onChanged: (_) => onSelect(),
                activeColor: AppTheme.primary600,
              ),
              SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isAddNew ? AppTheme.primary100 : AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: paymentMethod["icon"],
                    color: isAddNew ? AppTheme.primary700 : AppTheme.neutral700,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod["type"],
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    if (!isAddNew) ...[
                      SizedBox(height: 4),
                      Text(
                        paymentMethod["name"],
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      if (paymentMethod["expiryDate"] != null) ...[
                        SizedBox(height: 4),
                        Text(
                          'Expires: ${paymentMethod["expiryDate"]}',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              if (paymentMethod["isDefault"] && !isAddNew)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primary100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Default',
                    style: TextStyle(
                      color: AppTheme.primary700,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
