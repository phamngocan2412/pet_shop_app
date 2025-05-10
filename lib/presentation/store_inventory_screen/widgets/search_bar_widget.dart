import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final String initialQuery;
  final Function(String) onSearch;

  const SearchBarWidget({
    Key? key,
    required this.initialQuery,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _searchController;

  // Popular search suggestions
  final List<String> popularSearches = [
    'Dog food',
    'Cat toys',
    'Aquarium filter',
    'Pet grooming',
    'Bird cage',
    'Organic treats',
    'Training equipment',
    'Hamster wheel',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    widget.onSearch(query);
    Navigator.pop(context);
  }

  void _selectSuggestion(String suggestion) {
    _searchController.text = suggestion;
    _submitSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.neutral300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Search bar
          TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: CustomIconWidget(
                  iconName: 'search', color: AppTheme.neutral600),
              suffixIcon: IconButton(
                icon: CustomIconWidget(
                    iconName: 'clear', color: AppTheme.neutral600),
                onPressed: () {
                  _searchController.clear();
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onSubmitted: (_) => _submitSearch(),
          ),
          SizedBox(height: 16),

          // Popular searches
          Text(
            'Popular Searches',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: popularSearches.map((search) {
              return ActionChip(
                label: Text(search),
                onPressed: () => _selectSuggestion(search),
                backgroundColor: AppTheme.neutral100,
                labelStyle: TextStyle(color: AppTheme.neutral700),
              );
            }).toList(),
          ),

          SizedBox(height: 24),

          // Search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitSearch,
              icon: CustomIconWidget(iconName: 'search', color: Colors.white),
              label: Text('Search'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
