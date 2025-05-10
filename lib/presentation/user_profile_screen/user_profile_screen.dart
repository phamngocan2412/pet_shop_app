import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/account_settings_widget.dart';
import './widgets/order_history_widget.dart';
import './widgets/personal_info_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/saved_pets_widget.dart';
import './widgets/stats_card_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;

  // Expansion panel states
  bool isPersonalInfoExpanded = true;
  bool isOrderHistoryExpanded = false;
  bool isSavedPetsExpanded = false;
  bool isAccountSettingsExpanded = false;

  // Mock user data
  final Map<String, dynamic> userData = {
    "id": "usr_12345",
    "name": "Alex Johnson",
    "email": "alex.johnson@example.com",
    "phone": "+1 (555) 123-4567",
    "address": "123 Pet Lovers Lane, San Francisco, CA 94107",
    "memberSince": "2021-06-15",
    "memberStatus": "Gold",
    "avatarUrl": "https://randomuser.me/api/portraits/men/32.jpg",
    "stats": {
      "petsPurchased": 5,
      "reviewsWritten": 12,
      "loyaltyPoints": 350,
    },
  };

  Future<void> _refreshUserData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));

    // Update user data (in a real app, this would fetch from an API)
    setState(() {
      userData["stats"]["loyaltyPoints"] =
          userData["stats"]["loyaltyPoints"] + 5;
      isLoading = false;
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout',
            style: AppTheme.lightTheme.textTheme.titleMedium),
        content: Text(
          'Are you sure you want to log out of your account?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppTheme.neutral600)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login-screen');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary700,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          IconButton(
            icon:
                CustomIconWidget(iconName: 'help_outline', color: Colors.white),
            onPressed: () {
              // Show help dialog or navigate to help screen
            },
            tooltip: 'Help',
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshUserData,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeaderWidget(userData: userData),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: StatsCardWidget(
                              title: 'Pets Purchased',
                              value:
                                  userData['stats']['petsPurchased'].toString(),
                              icon: 'pets',
                              color: AppTheme.primary600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatsCardWidget(
                              title: 'Reviews',
                              value: userData['stats']['reviewsWritten']
                                  .toString(),
                              icon: 'rate_review',
                              color: AppTheme.info600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatsCardWidget(
                              title: 'Points',
                              value:
                                  userData['stats']['loyaltyPoints'].toString(),
                              icon: 'stars',
                              color: AppTheme.warning600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildExpansionPanels(),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton.icon(
                        onPressed: _handleLogout,
                        icon: CustomIconWidget(
                            iconName: 'logout', color: Colors.white),
                        label: const Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error600,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home-screen');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/pet-management-screen');
              break;
            case 2:
              Navigator.pushReplacementNamed(
                  context, '/store-inventory-screen');
              break;
            case 3:
              // Already on Profile
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
                CustomIconWidget(iconName: 'store', color: AppTheme.neutral500),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
                iconName: 'person', color: AppTheme.primary700),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionPanels() {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                initiallyExpanded: isPersonalInfoExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    isPersonalInfoExpanded = expanded;
                  });
                },
                title: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'person',
                      color: AppTheme.primary700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Personal Information',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                  ],
                ),
                trailing: CustomIconWidget(
                  iconName: isPersonalInfoExpanded
                      ? 'keyboard_arrow_up'
                      : 'keyboard_arrow_down',
                  color: AppTheme.neutral600,
                ),
                children: [
                  PersonalInfoWidget(userData: userData),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                initiallyExpanded: isOrderHistoryExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    isOrderHistoryExpanded = expanded;
                  });
                },
                title: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'receipt_long',
                      color: AppTheme.primary700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Order History',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                  ],
                ),
                trailing: CustomIconWidget(
                  iconName: isOrderHistoryExpanded
                      ? 'keyboard_arrow_up'
                      : 'keyboard_arrow_down',
                  color: AppTheme.neutral600,
                ),
                children: [
                  OrderHistoryWidget(),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                initiallyExpanded: isSavedPetsExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    isSavedPetsExpanded = expanded;
                  });
                },
                title: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'favorite',
                      color: AppTheme.primary700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Saved Pets',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                  ],
                ),
                trailing: CustomIconWidget(
                  iconName: isSavedPetsExpanded
                      ? 'keyboard_arrow_up'
                      : 'keyboard_arrow_down',
                  color: AppTheme.neutral600,
                ),
                children: [
                  SavedPetsWidget(),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ExpansionTile(
                initiallyExpanded: isAccountSettingsExpanded,
                onExpansionChanged: (expanded) {
                  setState(() {
                    isAccountSettingsExpanded = expanded;
                  });
                },
                title: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'settings',
                      color: AppTheme.primary700,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Account Settings',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                  ],
                ),
                trailing: CustomIconWidget(
                  iconName: isAccountSettingsExpanded
                      ? 'keyboard_arrow_up'
                      : 'keyboard_arrow_down',
                  color: AppTheme.neutral600,
                ),
                children: [
                  AccountSettingsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
