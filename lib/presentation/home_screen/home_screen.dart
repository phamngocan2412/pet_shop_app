import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/category_filter_widget.dart';
import './widgets/featured_pet_carousel_widget.dart';
import './widgets/new_arrivals_widget.dart';
import './widgets/pet_grid_item_widget.dart';
import './widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  bool isLoading = false;
  bool isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  // Mock data for pets
  final List<Map<String, dynamic>> featuredPets = [
    {
      "id": 1,
      "name": "Luna",
      "type": "Dog",
      "breed": "Golden Retriever",
      "age": 2,
      "price": 1200,
      "isFeatured": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Friendly and energetic Golden Retriever. Great with kids and other pets.",
      "isFavorite": false,
    },
    {
      "id": 2,
      "name": "Oliver",
      "type": "Cat",
      "breed": "Siamese",
      "age": 1,
      "price": 800,
      "isFeatured": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1555685812-4b8f59697ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2lhbWVzZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "description":
          "Beautiful Siamese cat with blue eyes. Very affectionate and playful.",
      "isFavorite": true,
    },
    {
      "id": 3,
      "name": "Charlie",
      "type": "Bird",
      "breed": "Cockatiel",
      "age": 1,
      "price": 300,
      "isFeatured": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1591198936750-16d8e15edc9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja2F0aWVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Friendly Cockatiel that loves to sing. Hand-raised and very social.",
      "isFavorite": false,
    },
  ];

  final List<Map<String, dynamic>> allPets = [
    {
      "id": 1,
      "name": "Luna",
      "type": "Dog",
      "breed": "Golden Retriever",
      "age": 2,
      "price": 1200,
      "isFeatured": true,
      "isNewArrival": false,
      "imageUrl":
          "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Friendly and energetic Golden Retriever. Great with kids and other pets.",
      "isFavorite": false,
    },
    {
      "id": 2,
      "name": "Oliver",
      "type": "Cat",
      "breed": "Siamese",
      "age": 1,
      "price": 800,
      "isFeatured": true,
      "isNewArrival": false,
      "imageUrl":
          "https://images.unsplash.com/photo-1555685812-4b8f59697ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2lhbWVzZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "description":
          "Beautiful Siamese cat with blue eyes. Very affectionate and playful.",
      "isFavorite": true,
    },
    {
      "id": 3,
      "name": "Charlie",
      "type": "Bird",
      "breed": "Cockatiel",
      "age": 1,
      "price": 300,
      "isFeatured": true,
      "isNewArrival": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1591198936750-16d8e15edc9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja2F0aWVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Friendly Cockatiel that loves to sing. Hand-raised and very social.",
      "isFavorite": false,
    },
    {
      "id": 4,
      "name": "Max",
      "type": "Dog",
      "breed": "German Shepherd",
      "age": 3,
      "price": 1500,
      "isFeatured": false,
      "isNewArrival": false,
      "imageUrl":
          "https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z2VybWFuJTIwc2hlcGhlcmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "description":
          "Well-trained German Shepherd. Excellent guard dog and very loyal.",
      "isFavorite": false,
    },
    {
      "id": 5,
      "name": "Bella",
      "type": "Cat",
      "breed": "Maine Coon",
      "age": 2,
      "price": 1000,
      "isFeatured": false,
      "isNewArrival": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1615796153287-98eacf0abb13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFpbmUlMjBjb29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Gorgeous Maine Coon with a friendly personality. Great for families.",
      "isFavorite": true,
    },
    {
      "id": 6,
      "name": "Daisy",
      "type": "Small Pet",
      "breed": "Holland Lop Rabbit",
      "age": 1,
      "price": 250,
      "isFeatured": false,
      "isNewArrival": true,
      "imageUrl":
          "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmFiYml0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "description":
          "Adorable Holland Lop rabbit. Very gentle and easy to handle.",
      "isFavorite": false,
    },
    {
      "id": 7,
      "name": "Oscar",
      "type": "Fish",
      "breed": "Betta",
      "age": 1,
      "price": 50,
      "isFeatured": false,
      "isNewArrival": false,
      "imageUrl":
          "https://images.pixabay.com/photo/2018/03/18/18/20/betta-3237303_960_720.jpg",
      "description":
          "Beautiful blue Betta fish with flowing fins. Comes with starter tank kit.",
      "isFavorite": false,
    },
    {
      "id": 8,
      "name": "Rex",
      "type": "Dog",
      "breed": "Labrador Retriever",
      "age": 4,
      "price": 1100,
      "isFeatured": false,
      "isNewArrival": false,
      "imageUrl":
          "https://images.unsplash.com/photo-1591769225440-811ad7d6eab2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bGFicmFkb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "description":
          "Friendly Labrador Retriever. Great family dog and good with children.",
      "isFavorite": true,
    },
    {
      "id": 9,
      "name": "Coco",
      "type": "Bird",
      "breed": "Budgerigar",
      "age": 1,
      "price": 150,
      "isFeatured": false,
      "isNewArrival": true,
      "imageUrl":
          "https://images.pexels.com/photos/1661179/pexels-photo-1661179.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "description":
          "Colorful and playful budgie. Can learn to talk with proper training.",
      "isFavorite": false,
    },
    {
      "id": 10,
      "name": "Milo",
      "type": "Small Pet",
      "breed": "Guinea Pig",
      "age": 1,
      "price": 120,
      "isFeatured": false,
      "isNewArrival": false,
      "imageUrl":
          "https://images.pexels.com/photos/635729/pexels-photo-635729.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "description":
          "Friendly guinea pig that loves vegetables and being held.",
      "isFavorite": false,
    },
  ];

  final List<String> categories = [
    'All',
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Small Pet'
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePets();
    }
  }

  Future<void> _refreshPets() async {
    setState(() {
      isLoading = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadMorePets() async {
    if (isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoadingMore = false;
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _toggleFavorite(int petId) {
    setState(() {
      final index = allPets.indexWhere((pet) => pet['id'] == petId);
      if (index != -1) {
        allPets[index]['isFavorite'] = !allPets[index]['isFavorite'];
      }
    });
  }

  List<Map<String, dynamic>> get filteredPets {
    return allPets.where((pet) {
      final matchesCategory =
          selectedCategory == 'All' || pet['type'] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          pet['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          pet['breed']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get newArrivals {
    return allPets.where((pet) => pet['isNewArrival'] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Shop',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon: CustomIconWidget(iconName: 'favorite', color: Colors.white),
            onPressed: () {
              // Navigate to favorites
            },
            tooltip: 'Favorites',
          ),
          IconButton(
            icon: CustomIconWidget(
                iconName: 'shopping_cart', color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/cart-screen');
            },
            tooltip: 'Cart',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPets,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBarWidget(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FeaturedPetCarouselWidget(
                featuredPets: featuredPets,
                onFavoriteToggle: _toggleFavorite,
                onTap: (pet) {
                  Navigator.pushNamed(
                    context,
                    '/pet-details-screen',
                    arguments: pet,
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: CategoryFilterWidget(
                categories: categories,
                selectedCategory: selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),
            if (newArrivals.isNotEmpty)
              SliverToBoxAdapter(
                child: NewArrivalsWidget(
                  newArrivals: newArrivals,
                  onFavoriteToggle: _toggleFavorite,
                  onTap: (pet) {
                    Navigator.pushNamed(
                      context,
                      '/pet-details-screen',
                      arguments: pet,
                    );
                  },
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Pets',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    Text(
                      '${filteredPets.length} found',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            filteredPets.isEmpty
                ? SliverFillRemaining(
                    child: _buildEmptyState(),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final pet = filteredPets[index];
                          return PetGridItemWidget(
                            pet: pet,
                            onFavoriteToggle: () => _toggleFavorite(pet['id']),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/pet-details-screen',
                                arguments: pet,
                              );
                            },
                          );
                        },
                        childCount: filteredPets.length,
                      ),
                    ),
                  ),
            if (isLoadingMore)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/pet-management-screen');
              break;
            case 1:
              // Already on Home Screen
              break;
            case 2:
              Navigator.pushNamed(context, '/store-inventory-screen');
              break;
            case 3:
              Navigator.pushNamed(context, '/user-profile-screen');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'pets', color: AppTheme.neutral500),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'home', color: AppTheme.primary700),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'store', color: AppTheme.neutral500),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
                iconName: 'person', color: AppTheme.neutral500),
            label: 'Profile',
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
            iconName: 'pets',
            color: AppTheme.neutral300,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'No pets found',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: AppTheme.neutral600),
          ),
          SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty
                ? 'Try a different search term'
                : selectedCategory != 'All'
                    ? 'No ${selectedCategory}s available right now'
                    : 'Check back soon for new pets',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.neutral500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          if (selectedCategory != 'All' || searchQuery.isNotEmpty)
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  selectedCategory = 'All';
                  searchQuery = '';
                  _searchController.clear();
                });
              },
              icon: CustomIconWidget(iconName: 'refresh', color: Colors.white),
              label: Text('Reset Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary600,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
        ],
      ),
    );
  }
}
