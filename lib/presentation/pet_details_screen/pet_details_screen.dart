import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/pet_details_tab_widget.dart';
import './widgets/pet_image_carousel_widget.dart';
import './widgets/pet_overview_tab_widget.dart';
import './widgets/pet_owner_contact_tab_widget.dart';
import './widgets/similar_pets_widget.dart';

class PetDetailsScreen extends StatefulWidget {
  final int petId;

  const PetDetailsScreen({
    Key? key,
    required this.petId,
  }) : super(key: key);

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isFavorite = false;
  bool isLoading = true;
  late Map<String, dynamic> petData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPetData();
  }

  void _loadPetData() {
    // Simulate loading data from API
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        petData = _getPetData(widget.petId);
        isLoading = false;
      });
    });
  }

  Map<String, dynamic> _getPetData(int id) {
    // Mock data for the pet details
    return {
      "id": id,
      "name": "Luna",
      "type": "Dog",
      "breed": "Golden Retriever",
      "age": 2,
      "gender": "Female",
      "price": 1200,
      "status": "available",
      "description":
          "Luna is a friendly and energetic Golden Retriever who loves to play fetch and go for long walks. She's great with children and other pets, making her the perfect addition to any family. Luna is fully trained and responds well to basic commands. She's been with us for a few months and is eager to find her forever home.",
      "images": [
        "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1633722715463-d30f4f325e24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1612502169027-5a379283f6a0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      ],
      "details": {
        "weight": "30 kg",
        "height": "56 cm",
        "color": "Golden",
        "temperament": "Friendly, Intelligent, Devoted",
        "goodWith": ["Children", "Other Dogs", "Cats"],
        "activityLevel": "High",
        "specialNeeds": "None",
        "dietaryNeeds": "Premium dry dog food, 2 cups twice daily",
        "medicalHistory": [
          "Vaccinated (DHPP, Rabies, Bordetella)",
          "Dewormed",
          "Microchipped",
          "Spayed"
        ],
        "training": "House-trained, knows basic commands (sit, stay, come)",
      },
      "owner": {
        "name": "Happy Paws Shelter",
        "type": "Shelter",
        "location": "123 Pet Avenue, Dogtown, CA",
        "phone": "(555) 123-4567",
        "email": "contact@happypaws.example.com",
        "rating": 4.8,
        "reviewCount": 156,
        "memberSince": "January 2018",
        "responseRate": "95%",
        "responseTime": "Within 2 hours",
        "verified": true,
        "avatar":
            "https://images.unsplash.com/photo-1571844307880-751c6d86f3f3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YW5pbWFsJTIwc2hlbHRlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      },
      "similarPets": [
        {
          "id": 2,
          "name": "Max",
          "breed": "Labrador Retriever",
          "age": 1,
          "price": 1000,
          "status": "available",
          "imageUrl":
              "https://images.unsplash.com/photo-1591769225440-811ad7d6eab2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bGFicmFkb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
        },
        {
          "id": 3,
          "name": "Bella",
          "breed": "Beagle",
          "age": 3,
          "price": 900,
          "status": "available",
          "imageUrl":
              "https://images.unsplash.com/photo-1505628346881-b72b27e84530?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YmVhZ2xlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
        },
        {
          "id": 4,
          "name": "Charlie",
          "breed": "German Shepherd",
          "age": 2,
          "price": 1300,
          "status": "pending",
          "imageUrl":
              "https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z2VybWFuJTIwc2hlcGhlcmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
        },
        {
          "id": 5,
          "name": "Daisy",
          "breed": "Border Collie",
          "age": 1,
          "price": 1100,
          "status": "available",
          "imageUrl":
              "https://images.unsplash.com/photo-1503256207526-0d5d80fa2f47?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9yZGVyJTIwY29sbGllfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
        },
      ]
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sharePet() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing pet listing...'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet added to cart'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Navigate to cart screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/cart-screen');
    });
  }

  void _contactOwner() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact ${petData['owner']['name']}',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(petData['owner']['avatar']),
              ),
              title: Text(petData['owner']['name']),
              subtitle:
                  Text('Response time: ${petData['owner']['responseTime']}'),
            ),
            Divider(),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'phone', color: AppTheme.primary600),
              title: Text('Call'),
              subtitle: Text(petData['owner']['phone']),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calling owner...'),
                    duration: Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'email', color: AppTheme.primary600),
              title: Text('Email'),
              subtitle: Text(petData['owner']['email']),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening email...'),
                    duration: Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'message', color: AppTheme.primary600),
              title: Text('Message'),
              subtitle: Text('Send a direct message'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening messaging...'),
                    duration: Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PetImageCarouselWidget(images: petData['images']),
                      _buildPetHeader(),
                      _buildTabBar(),
                      _buildTabBarView(),
                      SimilarPetsWidget(similarPets: petData['similarPets']),
                      SizedBox(height: 80), // Space for bottom buttons
                    ],
                  ),
                ),
              ],
            ),
      bottomSheet: _buildBottomActions(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      leading: IconButton(
        icon: CustomIconWidget(iconName: 'arrow_back', color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: CustomIconWidget(
            iconName: isFavorite ? 'favorite' : 'favorite_border',
            color: Colors.white,
          ),
          onPressed: _toggleFavorite,
          tooltip: 'Add to favorites',
        ),
        IconButton(
          icon: CustomIconWidget(iconName: 'share', color: Colors.white),
          onPressed: _sharePet,
          tooltip: 'Share',
        ),
      ],
    );
  }

  Widget _buildPetHeader() {
    final statusColor = AppTheme.getPetStatusColor(petData['status']);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  petData['name'],
                  style: AppTheme.lightTheme.textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  petData['status'].toString().toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${petData['breed']} • ${petData['age']} ${petData['age'] == 1 ? 'year' : 'years'} old • ${petData['gender']}',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.neutral600,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                '\$${petData['price']}',
                style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primary700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              if (petData['status'] == 'available')
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.success100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Ready for adoption',
                    style: TextStyle(
                      color: AppTheme.success600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.neutral500,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                petData['owner']['location'].split(',')[0],
                style: TextStyle(
                  color: AppTheme.neutral500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.neutral200),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            icon:
                CustomIconWidget(iconName: 'pets', color: AppTheme.primary700),
            text: 'Overview',
          ),
          Tab(
            icon:
                CustomIconWidget(iconName: 'info', color: AppTheme.primary700),
            text: 'Details',
          ),
          Tab(
            icon: CustomIconWidget(
                iconName: 'person', color: AppTheme.primary700),
            text: 'Owner',
          ),
        ],
        labelColor: AppTheme.primary700,
        unselectedLabelColor: AppTheme.neutral500,
        indicatorColor: AppTheme.primary700,
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: 400, // Fixed height for tab content
      child: TabBarView(
        controller: _tabController,
        children: [
          PetOverviewTabWidget(description: petData['description']),
          PetDetailsTabWidget(details: petData['details']),
          PetOwnerContactTabWidget(owner: petData['owner']),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _contactOwner,
              icon: CustomIconWidget(
                  iconName: 'message', color: AppTheme.primary700),
              label: Text('Contact Owner'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: petData['status'] == 'available' ? _addToCart : null,
              icon: CustomIconWidget(
                iconName: 'shopping_cart',
                color: petData['status'] == 'available'
                    ? Colors.white
                    : AppTheme.neutral400,
              ),
              label: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: AppTheme.primary700,
                disabledBackgroundColor: AppTheme.neutral300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
