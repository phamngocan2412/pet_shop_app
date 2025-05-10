import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class PetGridItemWidget extends StatelessWidget {
  final Map<String, dynamic> pet;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const PetGridItemWidget({
    Key? key,
    required this.pet,
    required this.onFavoriteToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight.withAlpha(26),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
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
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(230),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName:
                            pet['isFavorite'] ? 'favorite' : 'favorite_border',
                        color: pet['isFavorite']
                            ? AppTheme.error600
                            : AppTheme.neutral600,
                        size: 18,
                      ),
                      onPressed: onFavoriteToggle,
                      constraints:
                          BoxConstraints.tightFor(width: 32, height: 32),
                      padding: EdgeInsets.zero,
                      iconSize: 18,
                    ),
                  ),
                ),
                if (pet['isNewArrival'] == true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.success600.withAlpha(230),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                if (pet['isFeatured'] == true && pet['isNewArrival'] != true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary600.withAlpha(230),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pet['name'],
                          style: AppTheme.lightTheme.textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${pet['price']}',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.primary700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${pet['breed']}',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'pets',
                        color: AppTheme.neutral500,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${pet['type']}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.neutral500,
                        ),
                      ),
                      SizedBox(width: 8),
                      CustomIconWidget(
                        iconName: 'cake',
                        color: AppTheme.neutral500,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${pet['age']} ${pet['age'] == 1 ? 'yr' : 'yrs'}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.neutral500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
