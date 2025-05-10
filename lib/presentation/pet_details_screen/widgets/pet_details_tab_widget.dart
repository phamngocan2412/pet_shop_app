import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PetDetailsTabWidget extends StatelessWidget {
  final Map<String, dynamic> details;

  const PetDetailsTabWidget({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Physical Characteristics',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildDetailsGrid([
            {'label': 'Weight', 'value': details['weight']},
            {'label': 'Height', 'value': details['height']},
            {'label': 'Color', 'value': details['color']},
            {'label': 'Activity Level', 'value': details['activityLevel']},
          ]),
          const SizedBox(height: 24),
          Text(
            'Temperament',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            details['temperament'],
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Text(
            'Compatibility',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildCompatibilityChips(),
          const SizedBox(height: 24),
          Text(
            'Care Requirements',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildCareRequirements(),
          const SizedBox(height: 24),
          Text(
            'Medical History',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _buildMedicalHistory(),
          const SizedBox(height: 24),
          Text(
            'Training',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            details['training'],
            style: AppTheme.lightTheme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid(List<Map<String, String>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.neutral100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                items[index]['label']!,
                style: TextStyle(
                  color: AppTheme.neutral600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                items[index]['value']!,
                style: TextStyle(
                  color: AppTheme.neutral900,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompatibilityChips() {
    final List<String> goodWith = List<String>.from(details['goodWith']);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: goodWith.map((item) {
        String iconName;
        switch (item.toLowerCase()) {
          case 'children':
            iconName = 'child_care';
            break;
          case 'other dogs':
            iconName = 'pets';
            break;
          case 'cats':
            iconName = 'pets';
            break;
          default:
            iconName = 'check_circle';
        }

        return Chip(
          avatar: CustomIconWidget(
            iconName: iconName,
            color: AppTheme.success600,
            size: 16,
          ),
          label: Text(item),
          backgroundColor: AppTheme.success100,
          labelStyle: TextStyle(
            color: AppTheme.success600,
            fontWeight: FontWeight.w500,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCareRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.neutral300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCareItem(
            icon: 'restaurant',
            title: 'Dietary Needs',
            description: details['dietaryNeeds'],
          ),
          const Divider(height: 24),
          _buildCareItem(
            icon: 'medical_services',
            title: 'Special Needs',
            description: details['specialNeeds'] == 'None'
                ? 'No special medical needs'
                : details['specialNeeds'],
          ),
        ],
      ),
    );
  }

  Widget _buildCareItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primary100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary700,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicalHistory() {
    final List<String> medicalHistory =
        List<String>.from(details['medicalHistory']);

    return Column(
      children: medicalHistory.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.success600,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item,
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
