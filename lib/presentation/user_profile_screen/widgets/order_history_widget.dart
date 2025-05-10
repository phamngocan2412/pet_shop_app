import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class OrderHistoryWidget extends StatefulWidget {
  const OrderHistoryWidget({Key? key}) : super(key: key);

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  String selectedFilter = 'All';
  String sortOrder = 'newest';

  // Mock order data
  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD-1234",
      "date": "2023-05-15",
      "total": 125.99,
      "status": "Delivered",
      "items": [
        {
          "name": "Golden Retriever Puppy",
          "quantity": 1,
          "price": 125.99,
          "imageUrl":
              "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
        }
      ]
    },
    {
      "id": "ORD-1235",
      "date": "2023-06-22",
      "total": 45.50,
      "status": "Processing",
      "items": [
        {
          "name": "Premium Cat Food (5kg)",
          "quantity": 1,
          "price": 35.50,
          "imageUrl":
              "https://images.pexels.com/photos/6957/animal-pet-cute-cat.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        },
        {
          "name": "Cat Toy Set",
          "quantity": 1,
          "price": 10.00,
          "imageUrl":
              "https://images.pexels.com/photos/6957/animal-pet-cute-cat.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        }
      ]
    },
    {
      "id": "ORD-1236",
      "date": "2023-07-10",
      "total": 78.25,
      "status": "Shipped",
      "items": [
        {
          "name": "Dog Bed (Large)",
          "quantity": 1,
          "price": 58.25,
          "imageUrl":
              "https://images.unsplash.com/photo-1591769225440-811ad7d6eab2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bGFicmFkb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
        },
        {
          "name": "Dog Chew Toys",
          "quantity": 2,
          "price": 10.00,
          "imageUrl":
              "https://images.unsplash.com/photo-1591769225440-811ad7d6eab2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bGFicmFkb3J8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredOrders {
    List<Map<String, dynamic>> result = [...orders];

    // Apply filter
    if (selectedFilter != 'All') {
      result =
          result.where((order) => order['status'] == selectedFilter).toList();
    }

    // Apply sorting
    result.sort((a, b) {
      final dateA = DateTime.parse(a['date']);
      final dateB = DateTime.parse(b['date']);
      return sortOrder == 'newest'
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterAndSort(),
          const SizedBox(height: 16),
          filteredOrders.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return _buildOrderCard(order);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSort() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedFilter,
            decoration: InputDecoration(
              labelText: 'Filter by Status',
              prefixIcon: CustomIconWidget(
                iconName: 'filter_list',
                color: AppTheme.neutral600,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            items: ['All', 'Delivered', 'Shipped', 'Processing', 'Cancelled']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedFilter = value;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: sortOrder,
            decoration: InputDecoration(
              labelText: 'Sort by Date',
              prefixIcon: CustomIconWidget(
                iconName: 'sort',
                color: AppTheme.neutral600,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'newest',
                child: Text('Newest First'),
              ),
              DropdownMenuItem(
                value: 'oldest',
                child: Text('Oldest First'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  sortOrder = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final date = DateTime.parse(order['date']);
    final formattedDate = '${date.month}/${date.day}/${date.year}';

    Color statusColor;
    IconData statusIcon;

    switch (order['status']) {
      case 'Delivered':
        statusColor = AppTheme.success600;
        statusIcon = Icons.check_circle;
        break;
      case 'Shipped':
        statusColor = AppTheme.info600;
        statusIcon = Icons.local_shipping;
        break;
      case 'Processing':
        statusColor = AppTheme.warning600;
        statusIcon = Icons.hourglass_bottom;
        break;
      case 'Cancelled':
        statusColor = AppTheme.error600;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = AppTheme.neutral600;
        statusIcon = Icons.help_outline;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order['id']}',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 16,
                        color: statusColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'calendar_today',
                  color: AppTheme.neutral500,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  formattedDate,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutral600,
                  ),
                ),
                const SizedBox(width: 16),
                CustomIconWidget(
                  iconName: 'attach_money',
                  color: AppTheme.neutral500,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '\$${order['total'].toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.neutral600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order['items'].length,
              itemBuilder: (context, index) {
                final item = order['items'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageWidget(
                          imageUrl: item['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${item['quantity']} x \$${item['price'].toStringAsFixed(2)}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.neutral600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/order-tracking-screen',
                      arguments: {'orderId': order['id']},
                    );
                  },
                  icon: CustomIconWidget(
                    iconName: 'track_changes',
                    color: AppTheme.primary700,
                    size: 18,
                  ),
                  label: const Text('Track Order'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Show order details or navigate to order details screen
                  },
                  icon: CustomIconWidget(
                    iconName: 'receipt',
                    color: AppTheme.primary700,
                    size: 18,
                  ),
                  label: const Text('View Details'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'receipt_long',
            color: AppTheme.neutral300,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'No orders found',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedFilter != 'All'
                ? 'Try changing your filter settings'
                : 'Your order history will appear here',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.neutral500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/home-screen');
            },
            icon: CustomIconWidget(
              iconName: 'shopping_cart',
              color: Colors.white,
            ),
            label: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}
