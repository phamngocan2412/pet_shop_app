import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class FeaturedPetCarouselWidget extends StatefulWidget {
  final List<Map<String, dynamic>> featuredPets;
  final Function(int) onFavoriteToggle;
  final Function(Map<String, dynamic>) onTap;

  const FeaturedPetCarouselWidget({
    Key? key,
    required this.featuredPets,
    required this.onFavoriteToggle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FeaturedPetCarouselWidget> createState() =>
      _FeaturedPetCarouselWidgetState();
}

class _FeaturedPetCarouselWidgetState extends State<FeaturedPetCarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featuredPets.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Pets',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  // View all featured pets
                },
                child: Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.featuredPets.length,
            itemBuilder: (context, index) {
              final pet = widget.featuredPets[index];
              return _buildFeaturedPetCard(pet, index);
            },
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.featuredPets.length,
            (index) => _buildPageIndicator(index == _currentPage),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFeaturedPetCard(Map<String, dynamic> pet, int index) {
    return GestureDetector(
      onTap: () => widget.onTap(pet),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight.withAlpha(26),
              blurRadius: 8,
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
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
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
                      ),
                      onPressed: () => widget.onFavoriteToggle(pet['id']),
                      constraints:
                          BoxConstraints.tightFor(width: 36, height: 36),
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                    ),
                  ),
                ),
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
                        fontSize: 12,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary600 : AppTheme.neutral300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
