import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class PetCardWidget extends StatelessWidget {
  final Map<String, dynamic> pet;
  final bool isSelectionMode;
  final bool isSelected;
  final Function(int) onToggleSelection;
  final Function(int, String) onUpdateStatus;
  final Function(int) onDelete;
  final Function(Map<String, dynamic>) onEdit;

  const PetCardWidget({
    Key? key,
    required this.pet,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onToggleSelection,
    required this.onUpdateStatus,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color statusColor = AppTheme.getPetStatusColor(pet['status']);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(230),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      pet['status'].toString().toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pet['name'],
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${pet['price']}',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.primary700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${pet['breed']} • ${pet['age']} ${pet['age'] == 1 ? 'year' : 'years'} old',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatItem(
                        icon: 'visibility',
                        value: pet['views'],
                        label: 'Views',
                      ),
                      SizedBox(width: 16),
                      _buildStatItem(
                        icon: 'question_answer',
                        value: pet['inquiries'],
                        label: 'Inquiries',
                      ),
                      SizedBox(width: 16),
                      _buildStatItem(
                        icon: 'calendar_today',
                        value: pet['daysListed'],
                        label: 'Days',
                      ),
                    ],
                  ),
                  if (!isSelectionMode) ...[
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          label: 'Edit',
                          icon: 'edit',
                          color: AppTheme.info600,
                          onPressed: () => onEdit(pet),
                        ),
                        _buildStatusButton(),
                        _buildActionButton(
                          label: 'Delete',
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
  }

  Widget _buildStatItem(
      {required String icon, required int value, required String label}) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: icon,
          color: AppTheme.neutral500,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          '$value $label',
          style: TextStyle(
            color: AppTheme.neutral500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required String icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: CustomIconWidget(iconName: icon, color: color, size: 16),
      label: Text(
        label,
        style: TextStyle(color: color, fontSize: 12),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size(80, 36),
      ),
    );
  }

  Widget _buildStatusButton() {
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

    String label =
        'Mark ${nextStatus.substring(0, 1).toUpperCase()}${nextStatus.substring(1)}';

    return _buildActionButton(
      label: label,
      icon: icon,
      color: color,
      onPressed: () => onUpdateStatus(pet['id'], nextStatus),
    );
  }
}
