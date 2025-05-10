import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(int) onAddToCart;

  const ProductCardWidget({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = !product['inStock'];
    final bool hasDiscount = product['hasDiscount'] ?? false;
    final bool isNew = product['isNew'] ?? false;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to product details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with badges
            Stack(
              children: [
                // Product image
                AspectRatio(
                  aspectRatio: 1,
                  child: ColorFiltered(
                    colorFilter: isOutOfStock
                        ? ColorFilter.mode(
                            Colors.grey.withAlpha(179),
                            BlendMode.saturation,
                          )
                        : ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.color,
                          ),
                    child: CustomImageWidget(
                      imageUrl: product['imageUrl'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Out of stock overlay
                if (isOutOfStock)
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black.withAlpha(128),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.error600,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'OUT OF STOCK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Discount badge
                if (hasDiscount)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.error600,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-${product['discountPercentage']}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                // New badge
                if (isNew)
                  Positioned(
                    top: hasDiscount ? 40 : 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.info600,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                // Quick add button
                if (!isOutOfStock)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: FloatingActionButton.small(
                      heroTag: 'product_${product['id']}',
                      onPressed: () => onAddToCart(product['id']),
                      backgroundColor: AppTheme.primary600,
                      child: CustomIconWidget(
                        iconName: 'add_shopping_cart',
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),

            // Product info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    product['name'],
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 4),

                  // Brand
                  Text(
                    product['brand'],
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutral600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8),

                  // Price
                  Row(
                    children: [
                      if (hasDiscount) ...[
                        Text(
                          '\$${product['discountPrice'].toStringAsFixed(2)}',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primary700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '\$${product['price'].toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppTheme.neutral500,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ] else
                        Text(
                          '\$${product['price'].toStringAsFixed(2)}',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primary700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.warning600,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${product['rating']}',
                        style: TextStyle(
                          color: AppTheme.neutral700,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${product['reviewCount']})',
                        style: TextStyle(
                          color: AppTheme.neutral500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Features
                  if ((product['features'] as List).isNotEmpty) ...[
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: (product['features'] as List)
                          .take(2)
                          .map<Widget>((feature) {
                        return Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.neutral100,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppTheme.neutral300),
                          ),
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: AppTheme.neutral700,
                              fontSize: 10,
                            ),
                          ),
                        );
                      }).toList(),
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
}
