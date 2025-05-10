import 'package:flutter/material.dart';

import './pet_card_widget.dart';

class PetListViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> pets;
  final bool isSelectionMode;
  final List<int> selectedPets;
  final Function(int) onToggleSelection;
  final Function(int, String) onUpdateStatus;
  final Function(int) onDelete;
  final Function(Map<String, dynamic>) onEdit;

  const PetListViewWidget({
    Key? key,
    required this.pets,
    required this.isSelectionMode,
    required this.selectedPets,
    required this.onToggleSelection,
    required this.onUpdateStatus,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final pet = pets[index];
        final isSelected = selectedPets.contains(pet['id']);

        return PetCardWidget(
          pet: pet,
          isSelectionMode: isSelectionMode,
          isSelected: isSelected,
          onToggleSelection: onToggleSelection,
          onUpdateStatus: onUpdateStatus,
          onDelete: onDelete,
          onEdit: onEdit,
        );
      },
    );
  }
}
