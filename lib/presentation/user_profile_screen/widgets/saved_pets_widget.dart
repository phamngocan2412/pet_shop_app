import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class SavedPetsWidget extends StatefulWidget {
  const SavedPetsWidget({Key? key}) : super(key: key);

  @override
  State<SavedPetsWidget> createState() => _SavedPetsWidgetState();
}

class _SavedPetsWidgetState extends State<SavedPetsWidget> {
  // Mock saved pets data
  final List<Map<String, dynamic>> savedPets = [
    {
      "id": 1,
      "name": "Luna",
      "type": "Cat",
      "breed": "Siamese",
      "age": 1,
      "price": 800,
      "status": "available",
      "imageUrl":
          "https://images.unsplash.com/photo-1555685812-4b8f59697ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2lhbWVzZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 2,
      "name": "Rocky",
      "type": "Dog",
      "breed": "German Shepherd",
      "age": 3,
      "price": 1500,
      "status": "available",
      "imageUrl":
          "https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z2VybWFuJTIwc2hlcGhlcmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 3,
      "name": "Charlie",
      "type": "Bird",
      "breed": "Cockatiel",
      "age": 1,
      "price": 300,
      "status": "available",
      "imageUrl":
          "https://images.unsplash.com/photo-1591198936750-16d8e15edc9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja2F0aWVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    },
  ];

  void _removePet(int petId) {
    setState(() {
      savedPets.removeWhere((pet) => pet['id'] == petId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pets you\'ve saved',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: 16),
          savedPets.isEmpty
              ? _buildEmptyState()
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: savedPets.length,
                  itemBuilder: (context, index) {
                    final pet = savedPets[index];
                    return _buildPetCard(pet);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildPetCard(Map<String, dynamic> pet) {
    final statusColor = AppTheme.getPetStatusColor(pet['status']);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Image
              Expanded(
                child: CustomImageWidget(
                  imageUrl: pet['imageUrl'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Pet Info
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet['name'],
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${pet['breed']} • ${pet['age']} ${pet['age'] == 1 ? 'year' : 'years'}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutral600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${pet['price']}',
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: AppTheme.primary700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            pet['status'].toString().toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/pet-details-screen',
                                arguments: {'petId': pet['id']},
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              minimumSize: const Size(0, 32),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Remove button
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(204),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: CustomIconWidget(
                  iconName: 'favorite',
                  color: AppTheme.error600,
                  size: 20,
                ),
                onPressed: () => _removePet(pet['id']),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                padding: EdgeInsets.zero,
                iconSize: 20,
                splashRadius: 20,
                tooltip: 'Remove from favorites',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'favorite_border',
            color: AppTheme.neutral300,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved pets',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pets you save will appear here for easy access',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutral500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/home-screen');
            },
            icon: CustomIconWidget(
              iconName: 'pets',
              color: Colors.white,
            ),
            label: const Text('Browse Pets'),
          ),
        ],
      ),
    );
  }
}
