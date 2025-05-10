import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class FilterPanelWidget extends StatefulWidget {
  final RangeValues priceRange;
  final List<String> brands;
  final List<String> selectedBrands;
  final List<String> features;
  final List<String> selectedFeatures;
  final bool showOutOfStock;
  final Function({
    RangeValues? price,
    List<String>? brands,
    List<String>? featuresList,
    bool? showOutOfStockItems,
  }) onApplyFilters;
  final VoidCallback onResetFilters;

  const FilterPanelWidget({
    Key? key,
    required this.priceRange,
    required this.brands,
    required this.selectedBrands,
    required this.features,
    required this.selectedFeatures,
    required this.showOutOfStock,
    required this.onApplyFilters,
    required this.onResetFilters,
  }) : super(key: key);

  @override
  State<FilterPanelWidget> createState() => _FilterPanelWidgetState();
}

class _FilterPanelWidgetState extends State<FilterPanelWidget> {
  late RangeValues _localPriceRange;
  late List<String> _localSelectedBrands;
  late List<String> _localSelectedFeatures;
  late bool _localShowOutOfStock;

  @override
  void initState() {
    super.initState();
    _localPriceRange = widget.priceRange;
    _localSelectedBrands = List.from(widget.selectedBrands);
    _localSelectedFeatures = List.from(widget.selectedFeatures);
    _localShowOutOfStock = widget.showOutOfStock;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight.withAlpha(26),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Range
          Text(
            'Price Range',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${_localPriceRange.start.toInt()}',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              Text(
                '\$${_localPriceRange.end.toInt()}',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
            ],
          ),
          RangeSlider(
            values: _localPriceRange,
            min: 0,
            max: 200,
            divisions: 20,
            labels: RangeLabels(
              '\$${_localPriceRange.start.toInt()}',
              '\$${_localPriceRange.end.toInt()}',
            ),
            onChanged: (values) {
              setState(() {
                _localPriceRange = values;
              });
            },
          ),

          // Brands
          SizedBox(height: 16),
          Text(
            'Brands',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.brands.map((brand) {
              final isSelected = _localSelectedBrands.contains(brand);
              return FilterChip(
                label: Text(brand),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _localSelectedBrands.add(brand);
                    } else {
                      _localSelectedBrands.remove(brand);
                    }
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: AppTheme.primary100,
                checkmarkColor: AppTheme.primary700,
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

          // Features
          SizedBox(height: 16),
          Text(
            'Features',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.features.map((feature) {
              final isSelected = _localSelectedFeatures.contains(feature);
              return FilterChip(
                label: Text(feature),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _localSelectedFeatures.add(feature);
                    } else {
                      _localSelectedFeatures.remove(feature);
                    }
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: AppTheme.info100,
                checkmarkColor: AppTheme.info600,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.info600 : AppTheme.neutral700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? AppTheme.info600 : AppTheme.neutral300,
                  ),
                ),
              );
            }).toList(),
          ),

          // Show Out of Stock
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Show Out of Stock Items',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              Switch(
                value: _localShowOutOfStock,
                onChanged: (value) {
                  setState(() {
                    _localShowOutOfStock = value;
                  });
                },
              ),
            ],
          ),

          // Apply and Reset buttons
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onResetFilters,
                  child: Text('Reset'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApplyFilters(
                      price: _localPriceRange,
                      brands: _localSelectedBrands,
                      featuresList: _localSelectedFeatures,
                      showOutOfStockItems: _localShowOutOfStock,
                    );
                  },
                  child: Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
