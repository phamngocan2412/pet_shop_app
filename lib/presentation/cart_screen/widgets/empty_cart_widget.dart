import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';
import './suggested_pet_widget.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onContinueShopping;
  final List<Map<String, dynamic>> suggestedPets;

  const EmptyCartWidget({
    Key? key,
    required this.onContinueShopping,
    required this.suggestedPets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),

            // Empty cart illustration
            CustomImageWidget(
              imageUrl:
                  "https://images.pexels.com/photos/6568607/pexels-photo-6568607.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              borderRadius: 100,
            ),
            SizedBox(height: 32),

            // Empty cart message
            Text(
              'Your Cart is Empty',
              style: AppTheme.lightTheme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Looks like you haven\'t added any pets or products to your cart yet.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),

            // Continue shopping button
            ElevatedButton.icon(
              onPressed: onContinueShopping,
              icon: CustomIconWidget(
                iconName: 'shopping_bag',
                color: Colors.white,
              ),
              label: Text('Continue Shopping'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),

            SizedBox(height: 48),
            Divider(),
            SizedBox(height: 24),

            // Suggested pets section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pets You Might Like',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 16),

            // Suggested pets grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: suggestedPets.length,
              itemBuilder: (context, index) {
                return SuggestedPetWidget(pet: suggestedPets[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
