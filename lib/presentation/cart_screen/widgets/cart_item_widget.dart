import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int, int) onUpdateQuantity;
  final Function(int) onRemove;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onUpdateQuantity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPet = item["type"] == "Pet";
    final itemTotal = (item["price"] * item["quantity"]).toStringAsFixed(2);

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomImageWidget(
                imageUrl: item["imageUrl"],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),

            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Item type badge
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isPet ? AppTheme.primary100 : AppTheme.info100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item["type"],
                          style: TextStyle(
                            color:
                                isPet ? AppTheme.primary700 : AppTheme.info600,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Remove button
                      IconButton(
                        icon: CustomIconWidget(
                          iconName: 'close',
                          color: AppTheme.neutral500,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () => onRemove(item["id"]),
                        tooltip: 'Remove item',
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  // Item name
                  Text(
                    item["name"],
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),

                  // Item attributes
                  Wrap(
                    spacing: 8,
                    children:
                        (item["attributes"] as List<String>).map((attribute) {
                      return Chip(
                        label: Text(
                          attribute,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.neutral700,
                          ),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.symmetric(horizontal: 8),
                        backgroundColor: AppTheme.neutral100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),

                  // Price and quantity controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${itemTotal}',
                        style: TextStyle(
                          color: AppTheme.primary700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      // Quantity controls
                      Row(
                        children: [
                          _buildQuantityButton(
                            icon: 'remove',
                            onPressed: () => onUpdateQuantity(
                                item["id"], item["quantity"] - 1),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.neutral200),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${item["quantity"]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            icon: 'add',
                            onPressed: () => onUpdateQuantity(
                                item["id"], item["quantity"] + 1),
                          ),
                        ],
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

  Widget _buildQuantityButton(
      {required String icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: CustomIconWidget(
          iconName: icon,
          color: AppTheme.neutral700,
          size: 16,
        ),
        padding: EdgeInsets.all(4),
        constraints: BoxConstraints(),
        onPressed: onPressed,
        splashRadius: 20,
      ),
    );
  }
}
