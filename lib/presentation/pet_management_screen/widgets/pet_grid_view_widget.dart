import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class PetGridViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pets;
  final bool isSelectionMode;
  final List<int> selectedPets;
  final Function(int) onToggleSelection;
  final Function(int, String) onUpdateStatus;
  final Function(int) onDelete;
  final Function(Map<String, dynamic>) onEdit;

  const PetGridViewWidget({
    Key? key,
    required this.pets,
    required this.isSelectionMode,
    required this.selectedPets,
    required this.onToggleSelection,
    required this.onUpdateStatus,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        final isSelected = selectedPets.contains(pet['id']);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected
                ? BorderSide(color: AppTheme.primary600, width: 2)
                : BorderSide.none,
          ),
          child: InkWell(
            onTap: () {
              if (isSelectionMode) {
                onToggleSelection(pet['id']);
              } else {
                // View pet details
              }
            },
            onLongPress: () {
              if (!isSelectionMode) {
                onToggleSelection(pet['id']);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CustomImageWidget(
                        imageUrl: pet['imageUrl'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.getPetStatusColor(pet['status'])
                              .withAlpha(230),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          pet['status'].toString().toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    if (isSelectionMode)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(230),
                            shape: BoxShape.circle,
                          ),
                          child: Checkbox(
                            value: isSelected,
                            onChanged: (_) => onToggleSelection(pet['id']),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              pet['name'],
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '\$${pet['price']}',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: AppTheme.primary700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${pet['breed']} • ${pet['age']} ${pet['age'] == 1 ? 'year' : 'years'}',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(
                            icon: 'visibility',
                            value: pet['views'],
                          ),
                          _buildStatItem(
                            icon: 'question_answer',
                            value: pet['inquiries'],
                          ),
                          _buildStatItem(
                            icon: 'calendar_today',
                            value: pet['daysListed'],
                          ),
                        ],
                      ),
                      if (!isSelectionMode) ...[
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionButton(
                              icon: 'edit',
                              color: AppTheme.info600,
                              onPressed: () => onEdit(pet),
                            ),
                            _buildStatusButton(pet),
                            _buildActionButton(
                              icon: 'delete',
                              color: AppTheme.error600,
                              onPressed: () => onDelete(pet['id']),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem({required String icon, required int value}) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.neutral500,
          size: 12,
        ),
        SizedBox(width: 2),
        Text(
          '$value',
          style: TextStyle(
            color: AppTheme.neutral500,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: CustomIconWidget(iconName: icon, color: color, size: 16),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      visualDensity: VisualDensity.compact,
      splashRadius: 20,
      tooltip: icon == 'edit' ? 'Edit' : 'Delete',
    );
  }

  Widget _buildStatusButton(Map<String, dynamic> pet) {
    String nextStatus;
    String icon;
    Color color;

    switch (pet['status']) {
      case 'available':
        nextStatus = 'pending';
        icon = 'pending';
        color = AppTheme.pending500;
        break;
      case 'pending':
        nextStatus = 'sold';
        icon = 'sell';
        color = AppTheme.sold500;
        break;
      case 'sold':
        nextStatus = 'available';
        icon = 'check_circle';
        color = AppTheme.available500;
        break;
      default:
        nextStatus = 'available';
        icon = 'check_circle';
        color = AppTheme.available500;
    }

    return IconButton(
      onPressed: () => onUpdateStatus(pet['id'], nextStatus),
      icon: CustomIconWidget(iconName: icon, color: color, size: 16),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      visualDensity: VisualDensity.compact,
      splashRadius: 20,
      tooltip:
          'Mark ${nextStatus.substring(0, 1).toUpperCase()}${nextStatus.substring(1)}',
    );
  }
}
