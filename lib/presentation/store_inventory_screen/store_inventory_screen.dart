import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/category_filter_widget.dart';
import './widgets/filter_panel_widget.dart';
import './widgets/product_grid_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/sort_dropdown_widget.dart';

class StoreInventoryScreen extends StatefulWidget {
  const StoreInventoryScreen({Key? key}) : super(key: key);

  @override
  State<StoreInventoryScreen> createState() => _StoreInventoryScreenState();
}

class _StoreInventoryScreenState extends State<StoreInventoryScreen> {
  bool isLoading = false;
  bool isFilterExpanded = false;
  String selectedCategory = 'All';
  String searchQuery = '';
  String sortOption = 'Popularity';
  RangeValues priceRange = const RangeValues(0, 200);
  List<String> selectedBrands = [];
  List<String> selectedFeatures = [];
  bool showOutOfStock = true;
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  // Mock data for products
  final List<Map<String, dynamic>> productsList = [
    {
      "id": 1,
      "name": "Premium Dog Food",
      "category": "Food",
      "price": 29.99,
      "discountPrice": 24.99,
      "rating": 4.7,
      "reviewCount": 128,
      "brand": "Royal Canin",
      "features": ["Organic", "Grain-free"],
      "inStock": true,
      "stockCount": 45,
      "isNew": true,
      "hasDiscount": true,
      "discountPercentage": 17,
      "imageUrl":
          "https://images.unsplash.com/photo-1589924691995-400dc9ecc119?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwZm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 2,
      "name": "Interactive Cat Toy",
      "category": "Toys",
      "price": 14.99,
      "discountPrice": null,
      "rating": 4.5,
      "reviewCount": 89,
      "brand": "PetSmart",
      "features": ["Battery-operated", "Durable"],
      "inStock": true,
      "stockCount": 32,
      "isNew": false,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1545249390-6bdfa286032f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2F0JTIwdG95fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 3,
      "name": "Adjustable Dog Collar",
      "category": "Accessories",
      "price": 19.99,
      "discountPrice": 15.99,
      "rating": 4.8,
      "reviewCount": 156,
      "brand": "PetCo",
      "features": ["Waterproof", "Reflective"],
      "inStock": true,
      "stockCount": 78,
      "isNew": false,
      "hasDiscount": true,
      "discountPercentage": 20,
      "imageUrl":
          "https://images.unsplash.com/photo-1567612529009-afe25301b6d0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwY29sbGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 4,
      "name": "Bird Cage Deluxe",
      "category": "Housing",
      "price": 89.99,
      "discountPrice": null,
      "rating": 4.6,
      "reviewCount": 42,
      "brand": "BirdLife",
      "features": ["Spacious", "Easy-clean"],
      "inStock": false,
      "stockCount": 0,
      "isNew": false,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1598435424599-b0dea3ae3cd6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8YmlyZCUyMGNhZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 5,
      "name": "Catnip Treats",
      "category": "Food",
      "price": 8.99,
      "discountPrice": null,
      "rating": 4.9,
      "reviewCount": 203,
      "brand": "Whiskas",
      "features": ["Organic", "Hypoallergenic"],
      "inStock": true,
      "stockCount": 120,
      "isNew": false,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1623256102769-4a21754e3600?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0JTIwdHJlYXRzfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 6,
      "name": "Dog Training Clicker",
      "category": "Training",
      "price": 6.99,
      "discountPrice": 4.99,
      "rating": 4.4,
      "reviewCount": 87,
      "brand": "PetSmart",
      "features": ["Ergonomic", "With wrist strap"],
      "inStock": true,
      "stockCount": 65,
      "isNew": false,
      "hasDiscount": true,
      "discountPercentage": 29,
      "imageUrl":
          "https://images.pixabay.com/photo-/2020/05/02/21/08/dog-training-5123057_960_720.jpg",
    },
    {
      "id": 7,
      "name": "Aquarium Filter System",
      "category": "Aquarium",
      "price": 34.99,
      "discountPrice": null,
      "rating": 4.7,
      "reviewCount": 56,
      "brand": "AquaLife",
      "features": ["Quiet", "Energy-efficient"],
      "inStock": true,
      "stockCount": 23,
      "isNew": true,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1584275779329-a243b56afd0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXF1YXJpdW0lMjBmaWx0ZXJ8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 8,
      "name": "Hamster Exercise Wheel",
      "category": "Small Pets",
      "price": 12.99,
      "discountPrice": 9.99,
      "rating": 4.3,
      "reviewCount": 38,
      "brand": "SmallWorld",
      "features": ["Silent", "Durable"],
      "inStock": true,
      "stockCount": 42,
      "isNew": false,
      "hasDiscount": true,
      "discountPercentage": 23,
      "imageUrl":
          "https://images.pixabay.com/photo-/2016/04/09/23/10/hamster-1319266_960_720.jpg",
    },
    {
      "id": 9,
      "name": "Premium Cat Food",
      "category": "Food",
      "price": 27.99,
      "discountPrice": null,
      "rating": 4.6,
      "reviewCount": 112,
      "brand": "Purina",
      "features": ["Grain-free", "High protein"],
      "inStock": true,
      "stockCount": 58,
      "isNew": false,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1583361704493-d4d4d1b1d70a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2F0JTIwZm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 10,
      "name": "Dog Chew Toy Bundle",
      "category": "Toys",
      "price": 19.99,
      "discountPrice": 16.99,
      "rating": 4.5,
      "reviewCount": 94,
      "brand": "Kong",
      "features": ["Durable", "Dental care"],
      "inStock": true,
      "stockCount": 37,
      "isNew": false,
      "hasDiscount": true,
      "discountPercentage": 15,
      "imageUrl":
          "https://images.unsplash.com/photo-1591946614720-90a587da4a36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwdG95fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 11,
      "name": "Reptile Heat Lamp",
      "category": "Reptiles",
      "price": 24.99,
      "discountPrice": null,
      "rating": 4.7,
      "reviewCount": 63,
      "brand": "ReptoCare",
      "features": ["Adjustable", "Energy-efficient"],
      "inStock": false,
      "stockCount": 0,
      "isNew": false,
      "hasDiscount": false,
      "discountPercentage": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1548550023-2bdb3c5beed7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVwdGlsZSUyMGxhbXB8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 12,
      "name": "Pet Grooming Kit",
      "category": "Grooming",
      "price": 39.99,
      "discountPrice": 29.99,
      "rating": 4.8,
      "reviewCount": 175,
      "brand": "PetCo",
      "features": ["Professional", "Complete set"],
      "inStock": true,
      "stockCount": 29,
      "isNew": true,
      "hasDiscount": true,
      "discountPercentage": 25,
      "imageUrl":
          "https://images.unsplash.com/photo-1516734212186-a967f81ad0d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGV0JTIwZ3Jvb21pbmd8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
    },
  ];

  // Categories for filter
  final List<String> categories = [
    'All',
    'Food',
    'Toys',
    'Accessories',
    'Housing',
    'Training',
    'Aquarium',
    'Small Pets',
    'Reptiles',
    'Grooming'
  ];

  // Brands for filter
  final List<String> brands = [
    'Royal Canin',
    'PetSmart',
    'PetCo',
    'BirdLife',
    'Whiskas',
    'AquaLife',
    'SmallWorld',
    'Purina',
    'Kong',
    'ReptoCare'
  ];

  // Features for filter
  final List<String> features = [
    'Organic',
    'Grain-free',
    'Hypoallergenic',
    'Durable',
    'Waterproof',
    'Battery-operated',
    'Quiet',
    'Energy-efficient',
    'Spacious',
    'Reflective'
  ];

  // Sort options
  final List<String> sortOptions = [
    'Popularity',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Rating'
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulate loading more products
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          page++;
          isLoading = false;
        });
      });
    }
  }

  List<Map<String, dynamic>> get filteredProducts {
    return productsList.where((product) {
      // Filter by category
      final matchesCategory =
          selectedCategory == 'All' || product['category'] == selectedCategory;

      // Filter by search query
      final matchesSearch = searchQuery.isEmpty ||
          product['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          product['brand']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          product['category']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      // Filter by price range
      final price = product['discountPrice'] ?? product['price'];
      final matchesPrice = price >= priceRange.start && price <= priceRange.end;

      // Filter by brands
      final matchesBrand =
          selectedBrands.isEmpty || selectedBrands.contains(product['brand']);

      // Filter by features
      final hasSelectedFeatures = selectedFeatures.isEmpty ||
          selectedFeatures.any(
              (feature) => (product['features'] as List).contains(feature));

      // Filter by stock
      final matchesStock = showOutOfStock || product['inStock'];

      return matchesCategory &&
          matchesSearch &&
          matchesPrice &&
          matchesBrand &&
          hasSelectedFeatures &&
          matchesStock;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedProducts {
    final products = List<Map<String, dynamic>>.from(filteredProducts);

    switch (sortOption) {
      case 'Price: Low to High':
        products.sort((a, b) {
          final priceA = a['discountPrice'] ?? a['price'];
          final priceB = b['discountPrice'] ?? b['price'];
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price: High to Low':
        products.sort((a, b) {
          final priceA = a['discountPrice'] ?? a['price'];
          final priceB = b['discountPrice'] ?? b['price'];
          return priceB.compareTo(priceA);
        });
        break;
      case 'Newest':
        products.sort(
            (a, b) => b['isNew'] == a['isNew'] ? 0 : (b['isNew'] ? 1 : -1));
        break;
      case 'Rating':
        products.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Popularity':
      default:
        products.sort((a, b) => b['reviewCount'].compareTo(a['reviewCount']));
        break;
    }

    return products;
  }

  void updateCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void updateSortOption(String option) {
    setState(() {
      sortOption = option;
    });
  }

  void toggleFilterPanel() {
    setState(() {
      isFilterExpanded = !isFilterExpanded;
    });
  }

  void applyFilters({
    RangeValues? price,
    List<String>? brands,
    List<String>? featuresList,
    bool? showOutOfStockItems,
  }) {
    setState(() {
      if (price != null) priceRange = price;
      if (brands != null) selectedBrands = brands;
      if (featuresList != null) selectedFeatures = featuresList;
      if (showOutOfStockItems != null) showOutOfStock = showOutOfStockItems;
    });
  }

  void resetFilters() {
    setState(() {
      selectedCategory = 'All';
      searchQuery = '';
      sortOption = 'Popularity';
      priceRange = const RangeValues(0, 200);
      selectedBrands = [];
      selectedFeatures = [];
      showOutOfStock = true;
    });
  }

  void addToCart(int productId) {
    // Simulate adding to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added to cart'),
        backgroundColor: AppTheme.success600,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart-screen');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayProducts = sortedProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Store Inventory',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon: CustomIconWidget(iconName: 'search', color: Colors.white),
            onPressed: () {
              // Show search dialog
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SearchBarWidget(
                  initialQuery: searchQuery,
                  onSearch: updateSearchQuery,
                ),
              );
            },
            tooltip: 'Search products',
          ),
          IconButton(
            icon: Badge(
              label: Text('3'),
              child: CustomIconWidget(
                  iconName: 'shopping_cart', color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/cart-screen');
            },
            tooltip: 'View cart',
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filter
          CategoryFilterWidget(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: updateCategory,
          ),

          // Filter and sort controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: toggleFilterPanel,
                    icon: CustomIconWidget(
                      iconName:
                          isFilterExpanded ? 'filter_list_off' : 'filter_list',
                      color: AppTheme.primary700,
                    ),
                    label: Text(isFilterExpanded ? 'Hide Filters' : 'Filter'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SortDropdownWidget(
                    options: sortOptions,
                    selectedOption: sortOption,
                    onOptionSelected: updateSortOption,
                  ),
                ),
              ],
            ),
          ),

          // Expanded filter panel
          if (isFilterExpanded)
            FilterPanelWidget(
              priceRange: priceRange,
              brands: brands,
              selectedBrands: selectedBrands,
              features: features,
              selectedFeatures: selectedFeatures,
              showOutOfStock: showOutOfStock,
              onApplyFilters: applyFilters,
              onResetFilters: resetFilters,
            ),

          // Results count and reset filters button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${displayProducts.length} products',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.neutral600,
                  ),
                ),
                if (selectedCategory != 'All' ||
                    searchQuery.isNotEmpty ||
                    priceRange.start > 0 ||
                    priceRange.end < 200 ||
                    selectedBrands.isNotEmpty ||
                    selectedFeatures.isNotEmpty ||
                    !showOutOfStock)
                  TextButton.icon(
                    onPressed: resetFilters,
                    icon: CustomIconWidget(
                        iconName: 'restart_alt', color: AppTheme.primary700),
                    label: Text('Reset All'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                  ),
              ],
            ),
          ),

          // Product grid
          Expanded(
            child: displayProducts.isEmpty
                ? _buildEmptyState()
                : ProductGridWidget(
                    products: displayProducts,
                    onAddToCart: addToCart,
                    scrollController: _scrollController,
                  ),
          ),

          // Loading indicator
          if (isLoading)
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home-screen');
              break;
            case 1:
              Navigator.pushNamed(context, '/pet-management-screen');
              break;
            case 2:
              // Already on Store Inventory
              break;
            case 3:
              Navigator.pushNamed(context, '/user-profile-screen');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'home', color: AppTheme.neutral500),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'pets', color: AppTheme.neutral500),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'store', color: AppTheme.primary700),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
                iconName: 'person', color: AppTheme.neutral500),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart-screen');
        },
        child: CustomIconWidget(iconName: 'shopping_cart', color: Colors.white),
        tooltip: 'View cart',
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'inventory_2',
            color: AppTheme.neutral300,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: AppTheme.neutral600),
          ),
          SizedBox(height: 8),
          Text(
            selectedCategory != 'All' ||
                    searchQuery.isNotEmpty ||
                    priceRange.start > 0 ||
                    priceRange.end < 200 ||
                    selectedBrands.isNotEmpty ||
                    selectedFeatures.isNotEmpty ||
                    !showOutOfStock
                ? 'Try adjusting your filters'
                : 'Check back later for new products',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.neutral500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          if (selectedCategory != 'All' ||
              searchQuery.isNotEmpty ||
              priceRange.start > 0 ||
              priceRange.end < 200 ||
              selectedBrands.isNotEmpty ||
              selectedFeatures.isNotEmpty ||
              !showOutOfStock)
            ElevatedButton.icon(
              onPressed: resetFilters,
              icon: CustomIconWidget(
                  iconName: 'filter_alt_off', color: Colors.white),
              label: Text('Clear Filters'),
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
