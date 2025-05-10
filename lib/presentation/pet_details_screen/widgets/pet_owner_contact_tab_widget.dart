import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PetOwnerContactTabWidget extends StatelessWidget {
  final Map<String, dynamic> owner;

  const PetOwnerContactTabWidget({
    Key? key,
    required this.owner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOwnerHeader(),
          const SizedBox(height: 24),
          _buildContactInfo(),
          const SizedBox(height: 24),
          _buildOwnerStats(),
          const SizedBox(height: 24),
          _buildReviewSection(),
        ],
      ),
    );
  }

  Widget _buildOwnerHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(owner['avatar']),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    owner['name'],
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  const SizedBox(width: 8),
                  if (owner['verified'])
                    CustomIconWidget(
                      iconName: 'verified',
                      color: AppTheme.primary600,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                owner['type'],
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.neutral600,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'star',
                    color: AppTheme.warning600,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${owner['rating']} (${owner['reviewCount']} reviews)',
                    style: TextStyle(
                      color: AppTheme.neutral700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildContactItem(
            icon: 'location_on',
            title: 'Location',
            value: owner['location'],
          ),
          const Divider(height: 24),
          _buildContactItem(
            icon: 'phone',
            title: 'Phone',
            value: owner['phone'],
          ),
          const Divider(height: 24),
          _buildContactItem(
            icon: 'email',
            title: 'Email',
            value: owner['email'],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required String icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.neutral300),
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary600,
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
                style: TextStyle(
                  color: AppTheme.neutral600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: AppTheme.neutral900,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOwnerStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            label: 'Member Since',
            value: owner['memberSince'],
            icon: 'calendar_today',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatItem(
            label: 'Response Rate',
            value: owner['responseRate'],
            icon: 'chat',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatItem(
            label: 'Response Time',
            value: owner['responseTime'],
            icon: 'schedule',
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required String icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.neutral300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary600,
            size: 20,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.neutral900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppTheme.neutral600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    // Mock reviews
    final reviews = [
      {
        'name': 'Sarah Johnson',
        'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
        'rating': 5,
        'date': '2 weeks ago',
        'comment':
            'Great experience adopting from this shelter. They were very thorough and caring throughout the process.',
      },
      {
        'name': 'Michael Chen',
        'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
        'rating': 4,
        'date': '1 month ago',
        'comment':
            'Very responsive and helpful. The pet I adopted was exactly as described.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: Text('See all (${owner['reviewCount']})'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...reviews.map((review) => _buildReviewItem(review)).toList(),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review['avatar']),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: AppTheme.lightTheme.textTheme.titleSmall,
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => CustomIconWidget(
                            iconName: 'star',
                            color: index < review['rating']
                                ? AppTheme.warning600
                                : AppTheme.neutral300,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            color: AppTheme.neutral500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review['comment'],
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
