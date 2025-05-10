import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PetFilterWidget extends StatefulWidget {
  final String initialType;
  final String initialStatus;
  final RangeValues initialPriceRange;
  final RangeValues initialAgeRange;
  final Function({
    String? type,
    String? status,
    RangeValues? price,
    RangeValues? age,
  }) onApplyFilters;

  const PetFilterWidget({
    Key? key,
    required this.initialType,
    required this.initialStatus,
    required this.initialPriceRange,
    required this.initialAgeRange,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  State<PetFilterWidget> createState() => _PetFilterWidgetState();
}

class _PetFilterWidgetState extends State<PetFilterWidget> {
  late String selectedType;
  late String selectedStatus;
  late RangeValues priceRange;
  late RangeValues ageRange;

  final List<String> petTypes = [
    'All',
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Small Pet'
  ];
  final List<String> statusOptions = ['All', 'available', 'pending', 'sold'];

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType;
    selectedStatus = widget.initialStatus;
    priceRange = widget.initialPriceRange;
    ageRange = widget.initialAgeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Pets',
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
            Text(
              'Pet Type',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: petTypes.map((type) {
                final isSelected = selectedType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedType = type;
                      });
                    }
                  },
                  backgroundColor: Colors.white,
                  selectedColor: AppTheme.primary100,
                  labelStyle: TextStyle(
                    color:
                        isSelected ? AppTheme.primary700 : AppTheme.neutral700,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isSelected
                          ? AppTheme.primary600
                          : AppTheme.neutral300,
                    ),
                  ),
                );
              }).toList(),
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
              children: statusOptions.map((status) {
                final isSelected = selectedStatus == status;
                Color chipColor;
                if (status == 'All') {
                  chipColor = AppTheme.neutral500;
                } else {
                  chipColor = AppTheme.getPetStatusColor(status);
                }

                return ChoiceChip(
                  label: Text(
                    status == 'All'
                        ? status
                        : status.substring(0, 1).toUpperCase() +
                            status.substring(1),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedStatus = status;
                      });
                    }
                  },
                  backgroundColor: Colors.white,
                  selectedColor: status == 'All'
                      ? AppTheme.neutral100
                      : chipColor.withAlpha(51),
                  labelStyle: TextStyle(
                    color: isSelected ? chipColor : AppTheme.neutral700,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isSelected ? chipColor : AppTheme.neutral300,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price Range',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Text(
                  '\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primary700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: priceRange,
              min: 0,
              max: 5000,
              divisions: 50,
              labels: RangeLabels(
                '\$${priceRange.start.toInt()}',
                '\$${priceRange.end.toInt()}',
              ),
              onChanged: (values) {
                setState(() {
                  priceRange = values;
                });
              },
              activeColor: AppTheme.primary600,
              inactiveColor: AppTheme.neutral200,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age Range (years)',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Text(
                  '${ageRange.start.toInt()} - ${ageRange.end.toInt()} years',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primary700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: ageRange,
              min: 0,
              max: 15,
              divisions: 15,
              labels: RangeLabels(
                '${ageRange.start.toInt()} yr',
                '${ageRange.end.toInt()} yr',
              ),
              onChanged: (values) {
                setState(() {
                  ageRange = values;
                });
              },
              activeColor: AppTheme.primary600,
              inactiveColor: AppTheme.neutral200,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedType = 'All';
                        selectedStatus = 'All';
                        priceRange = const RangeValues(0, 5000);
                        ageRange = const RangeValues(0, 15);
                      });
                    },
                    child: Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApplyFilters(
                        type: selectedType,
                        status: selectedStatus,
                        price: priceRange,
                        age: ageRange,
                      );
                      Navigator.pop(context);
                    },
                    child: Text('Apply Filters'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
