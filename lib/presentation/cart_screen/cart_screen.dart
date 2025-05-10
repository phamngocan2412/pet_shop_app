import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/cart_item_widget.dart';
import './widgets/coupon_field_widget.dart';
import './widgets/empty_cart_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/shipping_option_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  String? appliedCoupon;
  String selectedShippingOption = 'standard';

  // Mock data for cart items
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Golden Retriever Puppy",
      "type": "Pet",
      "category": "Dog",
      "price": 1200.00,
      "quantity": 1,
      "imageUrl":
          "https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z29sZGVuJTIwcmV0cmlldmVyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "attributes": ["Male", "3 months old", "Vaccinated"],
    },
    {
      "id": 2,
      "name": "Premium Dog Food",
      "type": "Product",
      "category": "Pet Food",
      "price": 45.99,
      "quantity": 2,
      "imageUrl":
          "https://images.pexels.com/photos/6568501/pexels-photo-6568501.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "attributes": ["Organic", "5kg bag", "All breeds"],
    },
    {
      "id": 3,
      "name": "Plush Dog Bed",
      "type": "Product",
      "category": "Accessories",
      "price": 35.50,
      "quantity": 1,
      "imageUrl":
          "https://images.pexels.com/photos/6568748/pexels-photo-6568748.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "attributes": ["Medium size", "Machine washable", "Memory foam"],
    }
  ];

  // Mock data for shipping options
  final List<Map<String, dynamic>> shippingOptions = [
    {
      "id": "standard",
      "name": "Standard Shipping",
      "price": 5.99,
      "estimatedDelivery": "3-5 business days",
      "icon": "local_shipping",
    },
    {
      "id": "express",
      "name": "Express Shipping",
      "price": 12.99,
      "estimatedDelivery": "1-2 business days",
      "icon": "delivery_dining",
    },
    {
      "id": "pickup",
      "name": "Store Pickup",
      "price": 0.00,
      "estimatedDelivery": "Available tomorrow",
      "icon": "store",
    },
  ];

  // Mock data for suggested pets
  final List<Map<String, dynamic>> suggestedPets = [
    {
      "id": 4,
      "name": "Siamese Kitten",
      "category": "Cat",
      "price": 850.00,
      "imageUrl":
          "https://images.unsplash.com/photo-1555685812-4b8f59697ef3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2lhbWVzZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "attributes": ["Female", "2 months old", "Playful"],
    },
    {
      "id": 5,
      "name": "Cockatiel",
      "category": "Bird",
      "price": 120.00,
      "imageUrl":
          "https://images.unsplash.com/photo-1591198936750-16d8e15edc9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y29ja2F0aWVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "attributes": ["Male", "1 year old", "Trained"],
    },
    {
      "id": 6,
      "name": "Holland Lop Rabbit",
      "category": "Small Pet",
      "price": 75.00,
      "imageUrl":
          "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cmFiYml0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
      "attributes": ["Female", "6 months old", "Friendly"],
    },
  ];

  // Mock coupon data
  final Map<String, double> validCoupons = {
    "WELCOME10": 0.10,
    "PETLOVER20": 0.20,
    "FREESHIP": 1.0, // 100% off shipping
  };

  double get subtotal {
    return cartItems.fold(
        0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }

  double get tax {
    return subtotal * 0.08; // 8% tax rate
  }

  double get shippingCost {
    if (appliedCoupon == "FREESHIP") return 0;

    final selectedOption = shippingOptions.firstWhere(
      (option) => option["id"] == selectedShippingOption,
      orElse: () => shippingOptions.first,
    );

    return selectedOption["price"];
  }

  double get discount {
    if (appliedCoupon == null) return 0;
    if (appliedCoupon == "FREESHIP")
      return 0; // This is applied to shipping, not as a discount

    final discountRate = validCoupons[appliedCoupon] ?? 0;
    return subtotal * discountRate;
  }

  double get total {
    return subtotal + tax + shippingCost - discount;
  }

  void updateQuantity(int itemId, int newQuantity) {
    if (newQuantity < 1) return;

    setState(() {
      final index = cartItems.indexWhere((item) => item["id"] == itemId);
      if (index != -1) {
        cartItems[index]["quantity"] = newQuantity;
      }
    });
  }

  void removeItem(int itemId) {
    setState(() {
      cartItems.removeWhere((item) => item["id"] == itemId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed from cart'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // This would require storing the removed item temporarily
            setState(() {
              // For simplicity, we're not implementing the actual undo functionality
              // in this example, but in a real app, you would restore the item here
            });
          },
        ),
      ),
    );
  }

  void applyCoupon(String code) {
    if (validCoupons.containsKey(code)) {
      setState(() {
        appliedCoupon = code;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coupon applied successfully!'),
          backgroundColor: AppTheme.success600,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid coupon code'),
          backgroundColor: AppTheme.error600,
        ),
      );
    }
  }

  void removeCoupon() {
    setState(() {
      appliedCoupon = null;
    });
  }

  void selectShippingOption(String optionId) {
    setState(() {
      selectedShippingOption = optionId;
    });
  }

  void proceedToCheckout() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: AppTheme.warning600,
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/checkout-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart',
            style: AppTheme.lightTheme.textTheme.titleLarge
                ?.copyWith(color: Colors.white)),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: CustomIconWidget(
                  iconName: 'delete_sweep', color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Clear Cart?'),
                    content: Text(
                        'Are you sure you want to remove all items from your cart?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('CANCEL'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            cartItems.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: Text('CLEAR',
                            style: TextStyle(color: AppTheme.error600)),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'Clear cart',
            ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? EmptyCartWidget(
                  onContinueShopping: () =>
                      Navigator.pushNamed(context, '/home-screen'),
                  suggestedPets: suggestedPets,
                )
              : _buildCartContent(),
      bottomNavigationBar: cartItems.isEmpty ? null : _buildCheckoutButton(),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Items (${cartItems.length})',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 16),

            // Cart items list
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Dismissible(
                  key: Key(item["id"].toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    color: AppTheme.error600,
                    child: CustomIconWidget(
                      iconName: 'delete',
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  onDismissed: (direction) {
                    removeItem(item["id"]);
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm"),
                          content: Text(
                              "Are you sure you want to remove this item?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("CANCEL"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("REMOVE",
                                  style: TextStyle(color: AppTheme.error600)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CartItemWidget(
                    item: item,
                    onUpdateQuantity: updateQuantity,
                    onRemove: removeItem,
                  ),
                );
              },
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),

            // Shipping options
            Text(
              'Shipping Options',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: shippingOptions.length,
              itemBuilder: (context, index) {
                final option = shippingOptions[index];
                final isSelected = selectedShippingOption == option["id"];

                return ShippingOptionWidget(
                  option: option,
                  isSelected: isSelected,
                  onSelect: () => selectShippingOption(option["id"]),
                  isFreeShipping: appliedCoupon == "FREESHIP",
                );
              },
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),

            // Coupon field
            CouponFieldWidget(
              appliedCoupon: appliedCoupon,
              onApplyCoupon: applyCoupon,
              onRemoveCoupon: removeCoupon,
            ),

            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),

            // Order summary
            OrderSummaryWidget(
              subtotal: subtotal,
              tax: tax,
              shipping: shippingCost,
              discount: discount,
              total: total,
            ),

            SizedBox(height: 80), // Space for bottom button
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: proceedToCheckout,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              CustomIconWidget(
                iconName: 'arrow_forward',
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
