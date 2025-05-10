import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final int strength;
  final bool showRequirements;

  const PasswordStrengthIndicator({
    Key? key,
    required this.strength,
    this.showRequirements = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Strength bar
        Row(
          children: List.generate(5, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: _getColorForStrength(index),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 4),

        // Strength text
        Text(
          _getStrengthText(),
          style: TextStyle(
            fontSize: 12,
            color: _getStrengthTextColor(),
            fontWeight: FontWeight.w500,
          ),
        ),

        // Password requirements (only shown when focused)
        if (showRequirements) ...[
          SizedBox(height: 8),
          _buildRequirementsList(),
        ],
      ],
    );
  }

  Widget _buildRequirementsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password must contain:',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.neutral600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        _buildRequirementItem('At least 8 characters', RegExp(r'.{8,}')),
        _buildRequirementItem(
            'At least one uppercase letter', RegExp(r'[A-Z]')),
        _buildRequirementItem(
            'At least one lowercase letter', RegExp(r'[a-z]')),
        _buildRequirementItem('At least one number', RegExp(r'[0-9]')),
        _buildRequirementItem('At least one special character',
            RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      ],
    );
  }

  Widget _buildRequirementItem(String text, RegExp regex) {
    final isMet = regex.hasMatch(strength > 0 ? 'A1!a' : '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 14,
            color: isMet ? AppTheme.success600 : AppTheme.neutral400,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? AppTheme.success600 : AppTheme.neutral600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForStrength(int index) {
    if (index >= strength) {
      return AppTheme.neutral200;
    }

    switch (strength) {
      case 1:
        return AppTheme.error600;
      case 2:
        return AppTheme.warning600;
      case 3:
        return AppTheme.warning600;
      case 4:
        return AppTheme.success600;
      case 5:
        return AppTheme.success600;
      default:
        return AppTheme.neutral200;
    }
  }

  String _getStrengthText() {
    switch (strength) {
      case 0:
        return 'No password entered';
      case 1:
        return 'Very weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Medium';
      case 4:
        return 'Strong';
      case 5:
        return 'Very strong';
      default:
        return '';
    }
  }

  Color _getStrengthTextColor() {
    switch (strength) {
      case 1:
        return AppTheme.error600;
      case 2:
        return AppTheme.warning600;
      case 3:
        return AppTheme.warning600;
      case 4:
        return AppTheme.success600;
      case 5:
        return AppTheme.success600;
      default:
        return AppTheme.neutral500;
    }
  }
}
