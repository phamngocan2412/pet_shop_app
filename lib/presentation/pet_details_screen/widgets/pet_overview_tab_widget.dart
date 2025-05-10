import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PetOverviewTabWidget extends StatelessWidget {
  final String description;

  const PetOverviewTabWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this Pet',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildAdoptionBenefits(),
          const SizedBox(height: 24),
          _buildAdoptionProcess(),
        ],
      ),
    );
  }

  Widget _buildAdoptionBenefits() {
    final benefits = [
      {
        'icon': 'favorite',
        'title': 'Companionship',
        'description':
            'Pets provide loyal companionship and unconditional love.'
      },
      {
        'icon': 'healing',
        'title': 'Health Benefits',
        'description':
            'Studies show pet owners have lower blood pressure and reduced stress.'
      },
      {
        'icon': 'volunteer_activism',
        'title': 'Save a Life',
        'description':
            'By adopting, you\'re giving a deserving pet a second chance.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits of Adoption',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        ...benefits
            .map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primary100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomIconWidget(
                          iconName: benefit['icon']!,
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
                              benefit['title']!,
                              style: AppTheme.lightTheme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              benefit['description']!,
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildAdoptionProcess() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.info100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'info',
                color: AppTheme.info600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Adoption Process',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.info600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildProcessStep(1, 'Submit an application',
              'Fill out our adoption form to express your interest.'),
          _buildProcessStep(2, 'Meet the pet',
              'Schedule a visit to meet and interact with the pet.'),
          _buildProcessStep(3, 'Home check',
              'We may conduct a brief home check to ensure it\'s suitable.'),
          _buildProcessStep(4, 'Finalize adoption',
              'Complete paperwork and welcome your new family member!'),
        ],
      ),
    );
  }

  Widget _buildProcessStep(int step, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.info600,
              shape: BoxShape.circle,
            ),
            child: Text(
              step.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
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
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
