import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class CheckoutProgressWidget extends StatelessWidget {
  final int currentStep;

  const CheckoutProgressWidget({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(0, 'Delivery', context),
          _buildConnector(0, context),
          _buildStep(1, 'Payment', context),
          _buildConnector(1, context),
          _buildStep(2, 'Review', context),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String label, BuildContext context) {
    final isCompleted = currentStep > step;
    final isActive = currentStep == step;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? AppTheme.success600
                : isActive
                    ? AppTheme.primary600
                    : AppTheme.neutral200,
          ),
          child: Center(
            child: isCompleted
                ? CustomIconWidget(
                    iconName: 'check',
                    color: Colors.white,
                    size: 16,
                  )
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : AppTheme.neutral600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isCompleted || isActive
                ? AppTheme.primary700
                : AppTheme.neutral500,
            fontWeight:
                isCompleted || isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(int step, BuildContext context) {
    final isCompleted = currentStep > step;

    return Container(
      width: 40,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: isCompleted ? AppTheme.success600 : AppTheme.neutral200,
    );
  }
}
