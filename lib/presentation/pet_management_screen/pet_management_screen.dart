import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/pet_filter_widget.dart';
import './widgets/pet_form_widget.dart';
import './widgets/pet_grid_view_widget.dart';
import './widgets/pet_list_view_widget.dart';

class PetManagementScreen extends StatefulWidget {
  const PetManagementScreen({Key? key}) : super(key: key);

  @override
  State<PetManagementScreen> createState() => _PetManagementScreenState();
}

class _PetManagementScreenState extends State<PetManagementScreen> {
  bool isGridView = true;
  bool isLoading = false;
  bool isSelectionMode = false;
  List<int> selectedPets = [];
  String filterType = 'All';
  String filterStatus = 'All';
  RangeValues priceRange = const RangeValues(0, 5000);
  RangeValues ageRange = const RangeValues(0, 15);

  // Mock data for pets
  final List<Map<String, dynamic>> petsList = [
    {
      "id": 1,
      "name": "Max",
      "type": "Dog",
      "breed": "Golden Retriever",
      "age": 2,
      "price": 1200,
      "status": "available",
      "description":
          "Friendly and energetic Golden Retriever. Great with kids and other pets.",
      "imageUrl":
          "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "views": 120,
      "inquiries": 15,
      "daysListed": 7,
      "healthRecords": ["Vaccinated", "Dewormed", "Microchipped"],
    },
    {
      "id": 2,
      "name": "Luna",
      "type": "Cat",
      "breed": "Siamese",
      "age": 1,
      "price": 800,
      "status": "pending",
      "description":
          "Beautiful Siamese cat with blue eyes. Very affectionate and playful.",
      "imageUrl":
          "https://images.unsplash.com/photo-1555685812-4b8f59697ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2lhbWVzZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "views": 85,
      "inquiries": 10,
      "daysListed": 5,
      "healthRecords": ["Vaccinated", "Spayed"],
    },
    {
      "id": 3,
      "name": "Rocky",
      "type": "Dog",
      "breed": "German Shepherd",
      "age": 3,
      "price": 1500,
      "status": "sold",
      "description":
          "Well-trained German Shepherd. Excellent guard dog and very loyal.",
      "imageUrl":
          "https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Z2VybWFuJTIwc2hlcGhlcmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "views": 200,
      "inquiries": 25,
      "daysListed": 14,
      "healthRecords": ["Vaccinated", "Dewormed", "Hip Certification"],
    },
    {
      "id": 4,
      "name": "Bella",
      "type": "Cat",
      "breed": "Maine Coon",
      "age": 2,
      "price": 1000,
      "status": "available",
      "description":
          "Gorgeous Maine Coon with a friendly personality. Great for families.",
      "imageUrl":
          "https://images.unsplash.com/photo-1615796153287-98eacf0abb13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFpbmUlMjBjb29ufGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "views": 110,
      "inquiries": 12,
      "daysListed": 8,
      "healthRecords": ["Vaccinated", "Dewormed"],
    },
    {
      "id": 5,
      "name": "Charlie",
      "type": "Bird",
      "breed": "Cockatiel",
      "age": 1,
      "price": 300,
      "status": "available",
      "description":
          "Friendly Cockatiel that loves to sing. Hand-raised and very social.",
      "imageUrl":
          "https://images.unsplash.com/photo-1591198936750-16d8e15edc9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja2F0aWVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "views": 65,
      "inquiries": 8,
      "daysListed": 10,
      "healthRecords": ["Vet Checked", "Dewormed"],
    },
    {
      "id": 6,
      "name": "Daisy",
      "type": "Small Pet",
      "breed": "Holland Lop Rabbit",
      "age": 1,
      "price": 250,
      "status": "available",
      "description":
          "Adorable Holland Lop rabbit. Very gentle and easy to handle.",
      "imageUrl":
          "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmFiYml0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "views": 70,
      "inquiries": 9,
      "daysListed": 6,
      "healthRecords": ["Vet Checked", "Dewormed"],
    },
    {
      "id": 7,
      "name": "Oscar",
      "type": "Fish",
      "breed": "Betta",
      "age": 1,
      "price": 50,
      "status": "available",
      "description":
          "Beautiful blue Betta fish with flowing fins. Comes with starter tank kit.",
      "imageUrl":
          "https://images.pixabay.com/photo-/2018/03/18/18/20/betta-3237303_960_720.jpg",
      "views": 45,
      "inquiries": 5,
      "daysListed": 12,
      "healthRecords": ["Healthy", "Parasite Free"],
    },
    {
      "id": 8,
      "name": "Rex",
      "type": "Dog",
      "breed": "Labrador Retriever",
      "age": 4,
      "price": 1100,
      "status": "pending",
      "description":
          "Friendly Labrador Retriever. Great family dog and good with children.",
      "imageUrl":
          "https://images.unsplash.com/photo-1591769225440-811ad7d6eab2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bGFicmFkb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
      "views": 130,
      "inquiries": 18,
      "daysListed": 9,
      "healthRecords": ["Vaccinated", "Dewormed", "Microchipped"],
    },
  ];

  List<Map<String, dynamic>> get filteredPets {
    return petsList.where((pet) {
      final matchesType = filterType == 'All' || pet['type'] == filterType;
      final matchesStatus =
          filterStatus == 'All' || pet['status'] == filterStatus;
      final matchesPrice =
          pet['price'] >= priceRange.start && pet['price'] <= priceRange.end;
      final matchesAge =
          pet['age'] >= ageRange.start && pet['age'] <= ageRange.end;

      return matchesType && matchesStatus && matchesPrice && matchesAge;
    }).toList();
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        selectedPets.clear();
      }
    });
  }

  void togglePetSelection(int petId) {
    setState(() {
      if (selectedPets.contains(petId)) {
        selectedPets.remove(petId);
      } else {
        selectedPets.add(petId);
      }
    });
  }

  void updatePetStatus(int petId, String newStatus) {
    setState(() {
      final petIndex = petsList.indexWhere((pet) => pet['id'] == petId);
      if (petIndex != -1) {
        petsList[petIndex]['status'] = newStatus;
      }
    });
  }

  void updateBatchStatus(String newStatus) {
    setState(() {
      for (var petId in selectedPets) {
        final petIndex = petsList.indexWhere((pet) => pet['id'] == petId);
        if (petIndex != -1) {
          petsList[petIndex]['status'] = newStatus;
        }
      }
      selectedPets.clear();
      isSelectionMode = false;
    });
  }

  void deletePet(int petId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion',
            style: AppTheme.lightTheme.textTheme.titleMedium),
        content: Text(
          'Are you sure you want to delete this pet? This action cannot be undone.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppTheme.neutral600)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                petsList.removeWhere((pet) => pet['id'] == petId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pet deleted successfully'),
                  backgroundColor: AppTheme.error600,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error600,
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void deleteBatchPets() {
    if (selectedPets.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Batch Deletion',
            style: AppTheme.lightTheme.textTheme.titleMedium),
        content: Text(
          'Are you sure you want to delete ${selectedPets.length} pets? This action cannot be undone.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppTheme.neutral600)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                petsList.removeWhere((pet) => selectedPets.contains(pet['id']));
                selectedPets.clear();
                isSelectionMode = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pets deleted successfully'),
                  backgroundColor: AppTheme.error600,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error600,
            ),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void showAddEditPetForm([Map<String, dynamic>? pet]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PetFormWidget(
        pet: pet,
        onSave: (newPet) {
          setState(() {
            if (pet != null) {
              // Edit existing pet
              final index = petsList.indexWhere((p) => p['id'] == pet['id']);
              if (index != -1) {
                petsList[index] = {
                  ...newPet,
                  'id': pet['id'],
                  'views': pet['views'],
                  'inquiries': pet['inquiries'],
                  'daysListed': pet['daysListed'],
                };
              }
            } else {
              // Add new pet
              petsList.add({
                ...newPet,
                'id': petsList.isNotEmpty
                    ? petsList
                            .map((p) => p['id'])
                            .reduce((a, b) => a > b ? a : b) +
                        1
                    : 1,
                'views': 0,
                'inquiries': 0,
                'daysListed': 0,
              });
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(pet != null
                  ? 'Pet updated successfully'
                  : 'Pet added successfully'),
              backgroundColor: AppTheme.success600,
            ),
          );
        },
      ),
    );
  }

  void applyFilters({
    String? type,
    String? status,
    RangeValues? price,
    RangeValues? age,
  }) {
    setState(() {
      if (type != null) filterType = type;
      if (status != null) filterStatus = status;
      if (price != null) priceRange = price;
      if (age != null) ageRange = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Management',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          if (isSelectionMode)
            Row(
              children: [
                Text('${selectedPets.length} selected',
                    style: TextStyle(color: Colors.white)),
                IconButton(
                  icon:
                      CustomIconWidget(iconName: 'close', color: Colors.white),
                  onPressed: toggleSelectionMode,
                  tooltip: 'Cancel selection',
                ),
              ],
            )
          else
            Row(
              children: [
                IconButton(
                  icon: CustomIconWidget(
                    iconName: isGridView ? 'view_list' : 'grid_view',
                    color: Colors.white,
                  ),
                  onPressed: toggleView,
                  tooltip: isGridView
                      ? 'Switch to list view'
                      : 'Switch to grid view',
                ),
                IconButton(
                  icon: CustomIconWidget(
                      iconName: 'filter_list', color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => PetFilterWidget(
                        initialType: filterType,
                        initialStatus: filterStatus,
                        initialPriceRange: priceRange,
                        initialAgeRange: ageRange,
                        onApplyFilters: applyFilters,
                      ),
                    );
                  },
                  tooltip: 'Filter pets',
                ),
                if (filteredPets.isNotEmpty)
                  IconButton(
                    icon: CustomIconWidget(
                        iconName: 'select_all', color: Colors.white),
                    onPressed: toggleSelectionMode,
                    tooltip: 'Select multiple pets',
                  ),
              ],
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(isSelectionMode ? 60 : 0),
          child: isSelectionMode
              ? Container(
                  color: AppTheme.primary800,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBatchActionButton(
                        label: 'Mark Available',
                        icon: 'check_circle',
                        color: AppTheme.available500,
                        onPressed: () => updateBatchStatus('available'),
                      ),
                      _buildBatchActionButton(
                        label: 'Mark Pending',
                        icon: 'pending',
                        color: AppTheme.pending500,
                        onPressed: () => updateBatchStatus('pending'),
                      ),
                      _buildBatchActionButton(
                        label: 'Mark Sold',
                        icon: 'sell',
                        color: AppTheme.sold500,
                        onPressed: () => updateBatchStatus('sold'),
                      ),
                      _buildBatchActionButton(
                        label: 'Delete',
                        icon: 'delete',
                        color: AppTheme.error600,
                        onPressed: deleteBatchPets,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredPets.isEmpty
              ? _buildEmptyState()
              : isGridView
                  ? PetGridViewWidget(
                      pets: filteredPets,
                      isSelectionMode: isSelectionMode,
                      selectedPets: selectedPets,
                      onToggleSelection: togglePetSelection,
                      onUpdateStatus: updatePetStatus,
                      onDelete: deletePet,
                      onEdit: showAddEditPetForm,
                    )
                  : PetListViewWidget(
                      pets: filteredPets,
                      isSelectionMode: isSelectionMode,
                      selectedPets: selectedPets,
                      onToggleSelection: togglePetSelection,
                      onUpdateStatus: updatePetStatus,
                      onDelete: deletePet,
                      onEdit: showAddEditPetForm,
                    ),
      floatingActionButton: !isSelectionMode
          ? FloatingActionButton(
              onPressed: () => showAddEditPetForm(),
              backgroundColor: AppTheme.primary600,
              child: CustomIconWidget(iconName: 'add', color: Colors.white),
              tooltip: 'Add new pet',
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Pet Management
              break;
            case 1:
              Navigator.pushNamed(context, '/home-screen');
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
                CustomIconWidget(iconName: 'pets', color: AppTheme.primary700),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon:
                CustomIconWidget(iconName: 'home', color: AppTheme.neutral500),
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

  Widget _buildBatchActionButton({
    required String label,
    required String icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: selectedPets.isEmpty ? null : onPressed,
      icon: CustomIconWidget(
          iconName: icon,
          color: selectedPets.isEmpty ? AppTheme.neutral400 : Colors.white),
      label: Text(
        label,
        style: TextStyle(
          color: selectedPets.isEmpty ? AppTheme.neutral400 : Colors.white,
          fontSize: 12,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor:
            selectedPets.isEmpty ? AppTheme.neutral700 : color.withAlpha(204),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
            filterType != 'All' ||
                    filterStatus != 'All' ||
                    priceRange.start > 0 ||
                    priceRange.end < 5000 ||
                    ageRange.start > 0 ||
                    ageRange.end < 15
                ? 'Try adjusting your filters'
                : 'Add your first pet by clicking the + button',
            style: AppTheme.lightTheme.textTheme.bodyMedium
                ?.copyWith(color: AppTheme.neutral500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          if (filterType != 'All' ||
              filterStatus != 'All' ||
              priceRange.start > 0 ||
              priceRange.end < 5000 ||
              ageRange.start > 0 ||
              ageRange.end < 15)
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  filterType = 'All';
                  filterStatus = 'All';
                  priceRange = const RangeValues(0, 5000);
                  ageRange = const RangeValues(0, 15);
                });
              },
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
