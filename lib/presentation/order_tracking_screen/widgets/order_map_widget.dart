import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class OrderMapWidget extends StatelessWidget {
  final Map<String, dynamic> deliveryLocation;
  final Map<String, dynamic> currentLocation;
  final bool showCurrentLocation;

  const OrderMapWidget({
    Key? key,
    required this.deliveryLocation,
    required this.currentLocation,
    this.showCurrentLocation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Map placeholder
            CustomImageWidget(
              imageUrl:
                  "https://maps.googleapis.com/maps/api/staticmap?center=${deliveryLocation['latitude']},${deliveryLocation['longitude']}&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7C${deliveryLocation['latitude']},${deliveryLocation['longitude']}&key=YOUR_API_KEY",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Map overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(153),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.5],
                ),
              ),
            ),

            // Delivery location marker
            Positioned(
              bottom: 16,
              left: 16,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomIconWidget(
                      iconName: 'location_on',
                      color: AppTheme.error600,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Delivery Address',
                      style: TextStyle(
                        color: AppTheme.neutral800,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Current location marker (if in transit)
            if (showCurrentLocation)
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(51),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Current Location',
                        style: TextStyle(
                          color: AppTheme.neutral800,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(51),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CustomIconWidget(
                        iconName: 'local_shipping',
                        color: AppTheme.primary600,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

            // Map controls
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(51),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      icon: CustomIconWidget(
                        iconName: 'add',
                        color: AppTheme.neutral800,
                        size: 20,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                      splashRadius: 20,
                    ),
                    Divider(height: 1, thickness: 1),
                    IconButton(
                      icon: CustomIconWidget(
                        iconName: 'remove',
                        color: AppTheme.neutral800,
                        size: 20,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(),
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
            ),

            // Open in maps button
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: CustomIconWidget(
                  iconName: 'map',
                  color: Colors.white,
                  size: 16,
                ),
                label: Text(
                  'Open in Maps',
                  style: TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: Size(0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
