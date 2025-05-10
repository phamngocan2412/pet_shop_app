import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class PetFormWidget extends StatefulWidget {
  final Map<String, dynamic>? pet;
  final Function(Map<String, dynamic>) onSave;

  const PetFormWidget({
    Key? key,
    this.pet,
    required this.onSave,
  }) : super(key: key);

  @override
  State<PetFormWidget> createState() => _PetFormWidgetState();
}

class _PetFormWidgetState extends State<PetFormWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Form fields
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _ageController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  String _selectedType = 'Dog';
  String _selectedStatus = 'available';
  List<String> _selectedHealthRecords = [];

  final List<String> _petTypes = ['Dog', 'Cat', 'Bird', 'Fish', 'Small Pet'];
  final List<String> _statusOptions = ['available', 'pending', 'sold'];
  final List<String> _healthRecordOptions = [
    'Vaccinated',
    'Dewormed',
    'Microchipped',
    'Spayed/Neutered',
    'Health Certificate',
    'Vet Checked',
    'Parasite Free',
    'Hip Certification',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize controllers with existing pet data if editing
    final pet = widget.pet;
    _nameController = TextEditingController(text: pet?['name'] ?? '');
    _breedController = TextEditingController(text: pet?['breed'] ?? '');
    _ageController = TextEditingController(text: pet?['age']?.toString() ?? '');
    _priceController =
        TextEditingController(text: pet?['price']?.toString() ?? '');
    _descriptionController =
        TextEditingController(text: pet?['description'] ?? '');
    _imageUrlController = TextEditingController(text: pet?['imageUrl'] ?? '');

    if (pet != null) {
      _selectedType = pet['type'] ?? 'Dog';
      _selectedStatus = pet['status'] ?? 'available';
      _selectedHealthRecords = List<String>.from(pet['healthRecords'] ?? []);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newPet = {
        'name': _nameController.text,
        'type': _selectedType,
        'breed': _breedController.text,
        'age': int.parse(_ageController.text),
        'price': double.parse(_priceController.text),
        'status': _selectedStatus,
        'description': _descriptionController.text,
        'imageUrl': _imageUrlController.text,
        'healthRecords': _selectedHealthRecords,
      };

      widget.onSave(newPet);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.pet != null;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'Edit Pet' : 'Add New Pet',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                IconButton(
                  icon: CustomIconWidget(
                      iconName: 'close', color: AppTheme.neutral600),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: CustomIconWidget(
                      iconName: 'image', color: AppTheme.primary700),
                  text: 'Images',
                ),
                Tab(
                  icon: CustomIconWidget(
                      iconName: 'info', color: AppTheme.primary700),
                  text: 'Basic Info',
                ),
                Tab(
                  icon: CustomIconWidget(
                      iconName: 'description', color: AppTheme.primary700),
                  text: 'Details',
                ),
                Tab(
                  icon: CustomIconWidget(
                      iconName: 'medical_services', color: AppTheme.primary700),
                  text: 'Health',
                ),
              ],
              labelColor: AppTheme.primary700,
              unselectedLabelColor: AppTheme.neutral500,
              indicatorColor: AppTheme.primary700,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildImagesTab(),
                  _buildBasicInfoTab(),
                  _buildDetailsTab(),
                  _buildHealthTab(),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    if (_tabController.index > 0) {
                      _tabController.animateTo(_tabController.index - 1);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: CustomIconWidget(
                      iconName: 'arrow_back', color: AppTheme.primary700),
                  label: Text(_tabController.index == 0 ? 'Cancel' : 'Back'),
                ),
                ElevatedButton.icon(
                  onPressed: _tabController.index == 3
                      ? _submitForm
                      : () {
                          _tabController.animateTo(_tabController.index + 1);
                        },
                  icon: CustomIconWidget(
                    iconName:
                        _tabController.index == 3 ? 'save' : 'arrow_forward',
                    color: Colors.white,
                  ),
                  label: Text(_tabController.index == 3 ? 'Save Pet' : 'Next'),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImagesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Pet Image',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _imageUrlController,
            decoration: InputDecoration(
              labelText: 'Image URL',
              hintText: 'Enter a valid image URL',
              prefixIcon: CustomIconWidget(
                  iconName: 'link', color: AppTheme.neutral600),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an image URL';
              }
              if (!Uri.tryParse(value)!.isAbsolute) {
                return 'Please enter a valid URL';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          if (_imageUrlController.text.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preview',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageWidget(
                    imageUrl: _imageUrlController.text,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          else
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.neutral100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.neutral300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'image',
                    color: AppTheme.neutral400,
                    size: 48,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Enter an image URL to preview',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.neutral500,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          Text(
            'Tips:',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 4),
          Text(
            '• Use high-quality images with good lighting\n'
            '• Show the pet clearly without distractions\n'
            '• Include multiple angles if possible\n'
            '• Optimal aspect ratio is 4:3 or 16:9',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Pet Name',
              hintText: 'Enter pet name',
              prefixIcon: CustomIconWidget(
                  iconName: 'pets', color: AppTheme.neutral600),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(
            'Pet Type',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _petTypes.map((type) {
              final isSelected = _selectedType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedType = type;

                      // Set breed suggestions based on type
                      if (_breedController.text.isEmpty) {
                        switch (type) {
                          case 'Dog':
                            _breedController.text = 'Labrador Retriever';
                            break;
                          case 'Cat':
                            _breedController.text = 'Domestic Shorthair';
                            break;
                          case 'Bird':
                            _breedController.text = 'Cockatiel';
                            break;
                          case 'Fish':
                            _breedController.text = 'Betta';
                            break;
                          case 'Small Pet':
                            _breedController.text = 'Hamster';
                            break;
                        }
                      }
                    });
                  }
                },
                backgroundColor: Colors.white,
                selectedColor: AppTheme.primary100,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primary700 : AppTheme.neutral700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color:
                        isSelected ? AppTheme.primary600 : AppTheme.neutral300,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _breedController,
            decoration: InputDecoration(
              labelText: 'Breed',
              hintText: 'Enter breed',
              prefixIcon: CustomIconWidget(
                  iconName: 'category', color: AppTheme.neutral600),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a breed';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age (years)',
                    hintText: 'Enter age',
                    prefixIcon: CustomIconWidget(
                        iconName: 'cake', color: AppTheme.neutral600),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price (\$)',
                    hintText: 'Enter price',
                    prefixIcon: CustomIconWidget(
                        iconName: 'attach_money', color: AppTheme.neutral600),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Status',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _statusOptions.map((status) {
              final isSelected = _selectedStatus == status;
              final statusColor = AppTheme.getPetStatusColor(status);

              return ChoiceChip(
                label: Text(
                  status.substring(0, 1).toUpperCase() + status.substring(1),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedStatus = status;
                    });
                  }
                },
                backgroundColor: Colors.white,
                selectedColor: statusColor.withAlpha(51),
                labelStyle: TextStyle(
                  color: isSelected ? statusColor : AppTheme.neutral700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? statusColor : AppTheme.neutral300,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Pet Description',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Enter a detailed description of the pet...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 8,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              if (value.length < 20) {
                return 'Description should be at least 20 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(
            'Tips for a great description:',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 4),
          Text(
            '• Describe the pet\'s personality and temperament\n'
            '• Mention any special training or skills\n'
            '• Include information about diet and care requirements\n'
            '• Note any unique characteristics or markings\n'
            '• Explain why this pet would make a great companion',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          SizedBox(height: 16),
          Text(
            'Character count: ${_descriptionController.text.length}',
            style: TextStyle(
              color: _descriptionController.text.length < 20
                  ? AppTheme.error600
                  : AppTheme.success600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Health Records',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'Select all that apply:',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _healthRecordOptions.map((record) {
              final isSelected = _selectedHealthRecords.contains(record);
              return FilterChip(
                label: Text(record),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedHealthRecords.add(record);
                    } else {
                      _selectedHealthRecords.remove(record);
                    }
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: AppTheme.success100,
                checkmarkColor: AppTheme.success600,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.success600 : AppTheme.neutral700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color:
                        isSelected ? AppTheme.success600 : AppTheme.neutral300,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          if (_selectedHealthRecords.isEmpty)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.warning100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.warning600.withAlpha(128)),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'warning',
                    color: AppTheme.warning600,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Adding health records increases buyer confidence and can help your pet get adopted faster.',
                      style: TextStyle(
                        color: AppTheme.warning600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.success600.withAlpha(128)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIconWidget(
                    iconName: 'check_circle',
                    color: AppTheme.success600,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Health records selected:',
                          style: TextStyle(
                            color: AppTheme.success600,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _selectedHealthRecords.join(', '),
                          style: TextStyle(
                            color: AppTheme.success600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 16),
          Text(
            'Health records help potential buyers understand the medical history and current health status of the pet. This builds trust and can lead to faster adoptions.',
            style: AppTheme.lightTheme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
