import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/order_activity_feed_widget.dart';
import './widgets/order_details_widget.dart';
import './widgets/order_item_widget.dart';
import './widgets/order_map_widget.dart';
import './widgets/order_timeline_widget.dart';
import './widgets/preparation_step_widget.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _notificationsEnabled = true;
  int _selectedShipmentIndex = 0;
  bool _isLoading = false;

  // Mock order data
  final Map<String, dynamic> orderData = {
    "orderId": "ORD-2023-7845",
    "orderDate": "2023-11-15 14:30",
    "expectedDelivery": "2023-11-22",
    "status": "in_transit",
    "currentStage":
        2, // 0: confirmed, 1: processed, 2: in_transit, 3: delivered
    "customerName": "Alex Johnson",
    "deliveryAddress": "123 Pet Lovers Lane, Pawsville, CA 94103",
    "contactPhone": "+1 (555) 123-4567",
    "paymentMethod": "Credit Card (ending in 4321)",
    "totalAmount": 245.99,
    "trackingNumber": "TRK78945612300",
    "carrier": "PetEx Delivery",
    "shipments": [
      {
        "shipmentId": "SHP-001",
        "items": [
          {
            "id": 1,
            "name": "Golden Retriever Puppy",
            "type": "Pet",
            "price": 1200.00,
            "quantity": 1,
            "image":
                "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
            "status": "in_transit",
            "estimatedArrival": "2023-11-22"
          }
        ],
        "status": "in_transit",
        "trackingNumber": "TRK78945612300",
        "carrier": "PetEx Delivery",
        "currentLocation": "Distribution Center, San Francisco",
        "lastUpdated": "2023-11-18 09:45"
      },
      {
        "shipmentId": "SHP-002",
        "items": [
          {
            "id": 2,
            "name": "Premium Dog Food",
            "type": "Product",
            "price": 45.99,
            "quantity": 2,
            "image":
                "https://images.unsplash.com/photo-1589924691995-400dc9ecc119?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9nJTIwZm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
            "status": "shipped",
            "estimatedArrival": "2023-11-20"
          },
          {
            "id": 3,
            "name": "Dog Bed - Large",
            "type": "Product",
            "price": 89.99,
            "quantity": 1,
            "image":
                "https://images.unsplash.com/photo-1598875184988-5e67b1a874b8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZG9nJTIwYmVkfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
            "status": "shipped",
            "estimatedArrival": "2023-11-20"
          }
        ],
        "status": "shipped",
        "trackingNumber": "TRK78945612301",
        "carrier": "PetEx Delivery",
        "currentLocation": "Regional Hub, Los Angeles",
        "lastUpdated": "2023-11-17 16:30"
      }
    ],
    "preparationSteps": [
      {
        "id": 1,
        "title": "Home Inspection",
        "description":
            "Virtual home check to ensure suitable environment for your new pet",
        "completed": true,
        "dueDate": "2023-11-17"
      },
      {
        "id": 2,
        "title": "Adoption Agreement",
        "description": "Sign and return the adoption agreement documents",
        "completed": true,
        "dueDate": "2023-11-18"
      },
      {
        "id": 3,
        "title": "Initial Vet Appointment",
        "description":
            "Schedule first vet appointment within 7 days of arrival",
        "completed": false,
        "dueDate": "2023-11-29"
      },
      {
        "id": 4,
        "title": "Training Session",
        "description":
            "Book complimentary training session with our certified trainers",
        "completed": false,
        "dueDate": "2023-12-05"
      }
    ],
    "activityFeed": [
      {
        "timestamp": "2023-11-18 09:45",
        "status": "In Transit",
        "description":
            "Your order has left our distribution center and is on its way to you",
        "location": "Distribution Center, San Francisco"
      },
      {
        "timestamp": "2023-11-17 16:30",
        "status": "Processed",
        "description":
            "Your order has been processed and is ready for shipping",
        "location": "Pet Shop Warehouse, San Francisco"
      },
      {
        "timestamp": "2023-11-16 10:15",
        "status": "Confirmed",
        "description": "Your order has been confirmed and is being prepared",
        "location": "Pet Shop Headquarters"
      },
      {
        "timestamp": "2023-11-15 14:30",
        "status": "Order Placed",
        "description": "Thank you for your order! We've received your payment",
        "location": "Online"
      }
    ],
    "deliveryLocation": {
      "latitude": 37.7749,
      "longitude": -122.4194,
      "address": "123 Pet Lovers Lane, Pawsville, CA 94103"
    },
    "currentDeliveryLocation": {
      "latitude": 37.8044,
      "longitude": -122.2712,
      "address": "Distribution Center, San Francisco"
    },
    "isDelayed": false,
    "delayReason": "",
    "revisedDeliveryDate": "",
    "isCompleted": false
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: orderData['shipments'].length,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedShipmentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _notificationsEnabled
              ? 'Order notifications enabled'
              : 'Order notifications disabled',
        ),
        backgroundColor:
            _notificationsEnabled ? AppTheme.success600 : AppTheme.neutral600,
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support',
            style: AppTheme.lightTheme.textTheme.titleMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our support team is here to help with your order ${orderData['orderId']}.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Text(
              'Choose your preferred contact method:',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildContactOption(
              icon: 'chat',
              title: 'Live Chat',
              subtitle: 'Available now',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Connecting to live chat...'),
                    backgroundColor: AppTheme.info600,
                  ),
                );
              },
            ),
            _buildContactOption(
              icon: 'phone',
              title: 'Phone Call',
              subtitle: '+1 (800) PET-SHOP',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Initiating phone call...'),
                    backgroundColor: AppTheme.info600,
                  ),
                );
              },
            ),
            _buildContactOption(
              icon: 'email',
              title: 'Email',
              subtitle: 'support@petshop.com',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening email client...'),
                    backgroundColor: AppTheme.info600,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primary100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.primary700,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTheme.textTheme.titleSmall,
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'arrow_forward_ios',
              color: AppTheme.neutral500,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _reorderItems() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reorder Items',
            style: AppTheme.lightTheme.textTheme.titleMedium),
        content: Text(
          'Would you like to reorder the items from this order?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Items added to cart'),
                  backgroundColor: AppTheme.success600,
                ),
              );
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isPetOrder =
        orderData['shipments'][0]['items'][0]['type'] == 'Pet';
    final bool isCompleted = orderData['isCompleted'];
    final bool isDelayed = orderData['isDelayed'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: _notificationsEnabled
                  ? 'notifications_active'
                  : 'notifications_off',
              color: Colors.white,
            ),
            onPressed: _toggleNotifications,
            tooltip: _notificationsEnabled
                ? 'Disable notifications'
                : 'Enable notifications',
          ),
          IconButton(
            icon:
                CustomIconWidget(iconName: 'help_outline', color: Colors.white),
            onPressed: _contactSupport,
            tooltip: 'Contact support',
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                });
                // Simulate network request
                await Future.delayed(Duration(seconds: 1));
                setState(() {
                  _isLoading = false;
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Timeline
                    OrderTimelineWidget(
                      currentStage: orderData['currentStage'],
                      isDelayed: isDelayed,
                    ),

                    // Order Status Banner
                    if (isDelayed)
                      _buildDelayedBanner()
                    else if (isCompleted)
                      _buildCompletedBanner(),

                    // Order Details
                    OrderDetailsWidget(orderData: orderData),

                    // Shipment Tabs (if multiple shipments)
                    if (orderData['shipments'].length > 1)
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipments',
                              style: AppTheme.lightTheme.textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.neutral100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                tabs: List.generate(
                                  orderData['shipments'].length,
                                  (index) => Tab(
                                    text: 'Shipment ${index + 1}',
                                  ),
                                ),
                                labelColor: AppTheme.primary700,
                                unselectedLabelColor: AppTheme.neutral600,
                                indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.shadowLight,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Items in current shipment
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items in ${orderData['shipments'].length > 1 ? 'Shipment ${_selectedShipmentIndex + 1}' : 'Your Order'}',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          ...List.generate(
                            orderData['shipments'][_selectedShipmentIndex]
                                    ['items']
                                .length,
                            (index) => OrderItemWidget(
                              item: orderData['shipments']
                                  [_selectedShipmentIndex]['items'][index],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Preparation Steps (for pet orders)
                    if (isPetOrder)
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preparation Steps',
                              style: AppTheme.lightTheme.textTheme.titleMedium,
                            ),
                            SizedBox(height: 8),
                            ...List.generate(
                              orderData['preparationSteps'].length,
                              (index) => PreparationStepWidget(
                                step: orderData['preparationSteps'][index],
                                onToggle: (completed) {
                                  setState(() {
                                    orderData['preparationSteps'][index]
                                        ['completed'] = completed;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Delivery Map
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Location',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          OrderMapWidget(
                            deliveryLocation: orderData['deliveryLocation'],
                            currentLocation:
                                orderData['currentDeliveryLocation'],
                            showCurrentLocation: orderData['currentStage'] ==
                                2, // Only show current location if in transit
                          ),
                        ],
                      ),
                    ),

                    // Activity Feed
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activity Feed',
                            style: AppTheme.lightTheme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8),
                          OrderActivityFeedWidget(
                            activities: orderData['activityFeed'],
                          ),
                        ],
                      ),
                    ),

                    // Completed Order Options
                    if (isCompleted) _buildCompletedOrderOptions(),

                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: _contactSupport,
                icon: CustomIconWidget(
                    iconName: 'support_agent', color: AppTheme.primary700),
                label: Text('Support'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              if (isCompleted)
                ElevatedButton.icon(
                  onPressed: _reorderItems,
                  icon:
                      CustomIconWidget(iconName: 'replay', color: Colors.white),
                  label: Text('Reorder'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user-profile-screen');
                  },
                  icon:
                      CustomIconWidget(iconName: 'person', color: Colors.white),
                  label: Text('My Account'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDelayedBanner() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warning100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.warning600.withAlpha(128)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'warning_amber',
                color: AppTheme.warning600,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Delivery Delay',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.warning600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            orderData['delayReason'],
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.warning600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Revised delivery date: ${orderData['revisedDeliveryDate']}',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.warning600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedBanner() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.success100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.success600.withAlpha(128)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.success600,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Order Completed',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.success600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Your order has been successfully delivered. Thank you for shopping with us!',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.success600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedOrderOptions() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Complete',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildCompletedOrderOption(
                  icon: 'rate_review',
                  title: 'Leave a Review',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Review feature coming soon'),
                        backgroundColor: AppTheme.info600,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildCompletedOrderOption(
                  icon: 'replay',
                  title: 'Reorder',
                  onTap: _reorderItems,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildCompletedOrderOption(
                  icon: 'swap_horiz',
                  title: 'Return/Exchange',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Return/Exchange feature coming soon'),
                        backgroundColor: AppTheme.info600,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildCompletedOrderOption(
                  icon: 'support_agent',
                  title: 'Get Support',
                  onTap: _contactSupport,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedOrderOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.neutral200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.primary600,
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
