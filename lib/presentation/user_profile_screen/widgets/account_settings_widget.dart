import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class AccountSettingsWidget extends StatefulWidget {
  const AccountSettingsWidget({Key? key}) : super(key: key);

  @override
  State<AccountSettingsWidget> createState() => _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends State<AccountSettingsWidget> {
  // Settings state
  bool notificationsEnabled = true;
  bool emailUpdatesEnabled = true;
  bool darkModeEnabled = false;
  bool locationTrackingEnabled = false;
  String selectedLanguage = 'English';
  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Notifications'),
          _buildSwitchSetting(
            title: 'Push Notifications',
            subtitle: 'Receive alerts about orders, promotions, and more',
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
            icon: 'notifications',
          ),
          _buildSwitchSetting(
            title: 'Email Updates',
            subtitle: 'Receive newsletters and promotional emails',
            value: emailUpdatesEnabled,
            onChanged: (value) {
              setState(() {
                emailUpdatesEnabled = value;
              });
            },
            icon: 'email',
          ),
          const Divider(),
          _buildSectionHeader('Appearance'),
          _buildSwitchSetting(
            title: 'Dark Mode',
            subtitle: 'Use dark theme throughout the app',
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
              // In a real app, this would update the app's theme
            },
            icon: 'dark_mode',
          ),
          const Divider(),
          _buildSectionHeader('Privacy'),
          _buildSwitchSetting(
            title: 'Location Tracking',
            subtitle:
                'Allow app to access your location for better recommendations',
            value: locationTrackingEnabled,
            onChanged: (value) {
              setState(() {
                locationTrackingEnabled = value;
              });
            },
            icon: 'location_on',
          ),
          const Divider(),
          _buildSectionHeader('Regional'),
          _buildDropdownSetting(
            title: 'Language',
            value: selectedLanguage,
            options: ['English', 'Spanish', 'French', 'German', 'Chinese'],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedLanguage = value;
                });
              }
            },
            icon: 'language',
          ),
          _buildDropdownSetting(
            title: 'Currency',
            value: selectedCurrency,
            options: ['USD', 'EUR', 'GBP', 'JPY', 'CAD'],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedCurrency = value;
                });
              }
            },
            icon: 'attach_money',
          ),
          const Divider(),
          _buildSectionHeader('Account'),
          _buildActionButton(
            title: 'Change Password',
            subtitle: 'Update your account password',
            icon: 'lock',
            onTap: () {
              // Navigate to change password screen or show dialog
            },
          ),
          _buildActionButton(
            title: 'Delete Account',
            subtitle: 'Permanently remove your account and all data',
            icon: 'delete_forever',
            isDestructive: true,
            onTap: () {
              _showDeleteAccountConfirmation();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
          color: AppTheme.primary700,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchSetting({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required String icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary700,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutral600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary600,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting({
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
    required String icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: AppTheme.primary700,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: value,
            items: options
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
            onChanged: onChanged,
            underline: Container(),
            icon: CustomIconWidget(
              iconName: 'arrow_drop_down',
              color: AppTheme.neutral600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isDestructive ? AppTheme.error600 : AppTheme.primary700,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? AppTheme.error600 : null,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutral600,
                    ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: isDestructive ? AppTheme.error600 : AppTheme.neutral600,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.error600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Please type "DELETE" to confirm:',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type DELETE here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.neutral600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In a real app, this would delete the account and log the user out
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deletion initiated'),
                  backgroundColor: AppTheme.error600,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error600,
            ),
            child:
                Text('Delete Account', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
