import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class PersonalInfoWidget extends StatefulWidget {
  final Map<String, dynamic> userData;

  const PersonalInfoWidget({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData['name']);
    emailController = TextEditingController(text: widget.userData['email']);
    phoneController = TextEditingController(text: widget.userData['phone']);
    addressController = TextEditingController(text: widget.userData['address']);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Save changes to userData (in a real app, this would update the backend)
        widget.userData['name'] = nameController.text;
        widget.userData['email'] = emailController.text;
        widget.userData['phone'] = phoneController.text;
        widget.userData['address'] = addressController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Details',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.neutral600,
                ),
              ),
              TextButton.icon(
                onPressed: _toggleEditing,
                icon: CustomIconWidget(
                  iconName: isEditing ? 'save' : 'edit',
                  color: AppTheme.primary700,
                  size: 18,
                ),
                label: Text(
                  isEditing ? 'Save' : 'Edit',
                  style: TextStyle(
                    color: AppTheme.primary700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoField(
            label: 'Full Name',
            value: widget.userData['name'],
            controller: nameController,
            icon: 'person',
            isEditing: isEditing,
          ),
          _buildInfoField(
            label: 'Email',
            value: widget.userData['email'],
            controller: emailController,
            icon: 'email',
            isEditing: isEditing,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildInfoField(
            label: 'Phone',
            value: widget.userData['phone'],
            controller: phoneController,
            icon: 'phone',
            isEditing: isEditing,
            keyboardType: TextInputType.phone,
          ),
          _buildInfoField(
            label: 'Address',
            value: widget.userData['address'],
            controller: addressController,
            icon: 'home',
            isEditing: isEditing,
            isMultiline: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required TextEditingController controller,
    required String icon,
    required bool isEditing,
    TextInputType keyboardType = TextInputType.text,
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.neutral500,
            ),
          ),
          const SizedBox(height: 4),
          isEditing
              ? TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  maxLines: isMultiline ? 3 : 1,
                  decoration: InputDecoration(
                    prefixIcon: CustomIconWidget(
                      iconName: icon,
                      color: AppTheme.neutral600,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconWidget(
                      iconName: icon,
                      color: AppTheme.primary700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        value,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.neutral800,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
