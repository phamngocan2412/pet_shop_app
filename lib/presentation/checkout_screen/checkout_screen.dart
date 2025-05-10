import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import '../../widgets/custom_image_widget.dart';
import './widgets/address_form_widget.dart';
import './widgets/address_item_widget.dart';
import './widgets/checkout_progress_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/payment_method_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  bool _isProcessingOrder = false;
  bool _showAddAddressForm = false;
  int _selectedAddressIndex = 0;
  int _selectedPaymentMethodIndex = 0;

  // Mock data for checkout
  final List<Map<String, dynamic>> _cartItems = [
    {
      "id": 1,
      "name": "Premium Dog Food",
      "description": "Organic grain-free formula for adult dogs",
      "price": 49.99,
      "quantity": 2,
      "image":
          "https://images.unsplash.com/photo-1589924691995-400dc9ecc119?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    },
    {
      "id": 2,
      "name": "Cat Scratching Post",
      "description": "Multi-level cat tree with sisal posts",
      "price": 89.99,
      "quantity": 1,
      "image":
          "https://images.pexels.com/photos/7788657/pexels-photo-7788657.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
    {
      "id": 3,
      "name": "Pet Carrier",
      "description": "Airline approved pet carrier for small pets",
      "price": 34.99,
      "quantity": 1,
      "image":
          "https://images.pexels.com/photos/6568501/pexels-photo-6568501.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
  ];

  final List<Map<String, dynamic>> _savedAddresses = [
    {
      "id": 1,
      "name": "John Doe",
      "street": "123 Main Street",
      "city": "San Francisco",
      "state": "CA",
      "zipCode": "94105",
      "country": "United States",
      "phone": "+1 (555) 123-4567",
      "isDefault": true,
    },
    {
      "id": 2,
      "name": "John Doe",
      "street": "456 Market Street, Apt 7B",
      "city": "San Francisco",
      "state": "CA",
      "zipCode": "94103",
      "country": "United States",
      "phone": "+1 (555) 987-6543",
      "isDefault": false,
    },
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      "id": 1,
      "type": "Credit Card",
      "icon": "credit_card",
      "name": "Visa ending in 4242",
      "expiryDate": "05/25",
      "isDefault": true,
    },
    {
      "id": 2,
      "type": "PayPal",
      "icon": "account_balance_wallet",
      "name": "john.doe@example.com",
      "isDefault": false,
    },
    {
      "id": 3,
      "type": "Add New Card",
      "icon": "add_circle",
      "name": "Add a new payment method",
      "isDefault": false,
    },
  ];

  double get _subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }

  double get _tax {
    return _subtotal * 0.08; // 8% tax
  }

  double get _shipping {
    return _subtotal > 100 ? 0 : 9.99; // Free shipping over $100
  }

  double get _total {
    return _subtotal + _tax + _shipping;
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
        _showAddAddressForm = false;
      });
    } else {
      _placeOrder();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _showAddAddressForm = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _selectAddress(int index) {
    setState(() {
      _selectedAddressIndex = index;
    });
  }

  void _toggleAddAddressForm() {
    setState(() {
      _showAddAddressForm = !_showAddAddressForm;
    });
  }

  void _addNewAddress(Map<String, dynamic> address) {
    setState(() {
      final newAddress = {
        ...address,
        "id": _savedAddresses.length + 1,
        "isDefault": _savedAddresses.isEmpty,
      };
      _savedAddresses.add(newAddress);
      _selectedAddressIndex = _savedAddresses.length - 1;
      _showAddAddressForm = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address added successfully'),
        backgroundColor: AppTheme.success600,
      ),
    );
  }

  void _selectPaymentMethod(int index) {
    setState(() {
      _selectedPaymentMethodIndex = index;
    });
  }

  void _placeOrder() async {
    // Validate if we have all required information
    if (_savedAddresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add a delivery address'),
          backgroundColor: AppTheme.error600,
        ),
      );
      return;
    }

    if (_selectedPaymentMethodIndex == 2) {
      // "Add New Card" option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add a payment method'),
          backgroundColor: AppTheme.error600,
        ),
      );
      return;
    }

    setState(() {
      _isProcessingOrder = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isProcessingOrder = false;
    });

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.success100,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.success600,
                size: 48,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Order Placed Successfully!',
              style: AppTheme.lightTheme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Your order #ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)} has been placed successfully.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushNamed(context, '/order-tracking-screen');
              },
              child: Text('Track Order'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.popUntil(
                    context, ModalRoute.withName('/cart-screen'));
              },
              child: Text('Back to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        leading: IconButton(
          icon: CustomIconWidget(iconName: 'arrow_back', color: Colors.white),
          onPressed: _previousStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            CheckoutProgressWidget(currentStep: _currentStep),

            // Main content
            Expanded(
              child: _isProcessingOrder
                  ? _buildProcessingOrderView()
                  : _buildStepContent(),
            ),

            // Order summary and action button
            OrderSummaryWidget(
              subtotal: _subtotal,
              tax: _tax,
              shipping: _shipping,
              total: _total,
              buttonText: _getButtonText(),
              onButtonPressed: _currentStep == 2 ? _placeOrder : _nextStep,
              isExpanded: _currentStep == 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDeliveryStep();
      case 1:
        return _buildPaymentStep();
      case 2:
        return _buildReviewStep();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildDeliveryStep() {
    return _showAddAddressForm
        ? AddressFormWidget(
            onSave: _addNewAddress,
            onCancel: _toggleAddAddressForm,
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Address',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                SizedBox(height: 16),
                if (_savedAddresses.isEmpty)
                  _buildEmptyAddressState()
                else
                  Column(
                    children: [
                      ...List.generate(
                        _savedAddresses.length,
                        (index) => AddressItemWidget(
                          address: _savedAddresses[index],
                          isSelected: _selectedAddressIndex == index,
                          onSelect: () => _selectAddress(index),
                        ),
                      ),
                      SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _toggleAddAddressForm,
                        icon: CustomIconWidget(
                          iconName: 'add',
                          color: AppTheme.primary700,
                        ),
                        label: Text('Add New Address'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
  }

  Widget _buildEmptyAddressState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.neutral100,
            shape: BoxShape.circle,
          ),
          child: CustomIconWidget(
            iconName: 'location_on',
            color: AppTheme.neutral400,
            size: 48,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'No Saved Addresses',
          style: AppTheme.lightTheme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Add a delivery address to continue with your order',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _toggleAddAddressForm,
          icon: CustomIconWidget(
            iconName: 'add',
            color: Colors.white,
          ),
          label: Text('Add New Address'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 48),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          ...List.generate(
            _paymentMethods.length,
            (index) => PaymentMethodWidget(
              paymentMethod: _paymentMethods[index],
              isSelected: _selectedPaymentMethodIndex == index,
              onSelect: () => _selectPaymentMethod(index),
            ),
          ),
          SizedBox(height: 16),
          if (_selectedPaymentMethodIndex == 2) // "Add New Card" option
            _buildAddCardForm(),
        ],
      ),
    );
  }

  Widget _buildAddCardForm() {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppTheme.primary200),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Card',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                prefixIcon: CustomIconWidget(
                  iconName: 'credit_card',
                  color: AppTheme.neutral600,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                _CardNumberFormatter(),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      _ExpiryDateFormatter(),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '123',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    obscureText: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                hintText: 'John Doe',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Expanded(
                  child: Text(
                    'Save this card for future payments',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Add a mock card to payment methods
                  _paymentMethods.insert(2, {
                    "id": _paymentMethods.length,
                    "type": "Credit Card",
                    "icon": "credit_card",
                    "name": "Mastercard ending in 3456",
                    "expiryDate": "12/25",
                    "isDefault": false,
                  });
                  _selectedPaymentMethodIndex = 2;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Card added successfully'),
                    backgroundColor: AppTheme.success600,
                  ),
                );
              },
              child: Text('Add Card'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewStep() {
    final selectedAddress = _savedAddresses[_selectedAddressIndex];
    final selectedPayment = _paymentMethods[_selectedPaymentMethodIndex];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Review',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 16),

          // Order items
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items (${_cartItems.length})',
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart-screen');
                        },
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                  Divider(),
                  ...List.generate(
                    _cartItems.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomImageWidget(
                              imageUrl: _cartItems[index]["image"],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _cartItems[index]["name"],
                                  style:
                                      AppTheme.lightTheme.textTheme.titleSmall,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Qty: ${_cartItems[index]["quantity"]}',
                                  style:
                                      AppTheme.lightTheme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${(_cartItems[index]["price"] * _cartItems[index]["quantity"]).toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Delivery address
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentStep = 0;
                          });
                        },
                        child: Text('Change'),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: AppTheme.primary700,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedAddress["name"],
                              style: AppTheme.lightTheme.textTheme.titleSmall,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${selectedAddress["street"]}, ${selectedAddress["city"]}, ${selectedAddress["state"]} ${selectedAddress["zipCode"]}',
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 4),
                            Text(
                              selectedAddress["phone"],
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Payment method
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentStep = 1;
                          });
                        },
                        child: Text('Change'),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: selectedPayment["icon"],
                        color: AppTheme.primary700,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedPayment["type"],
                              style: AppTheme.lightTheme.textTheme.titleSmall,
                            ),
                            SizedBox(height: 4),
                            Text(
                              selectedPayment["name"],
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          // Delivery options
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Options',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  Divider(),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'local_shipping',
                        color: AppTheme.primary700,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _shipping == 0
                                  ? 'Free Shipping'
                                  : 'Standard Shipping',
                              style: AppTheme.lightTheme.textTheme.titleSmall,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Estimated delivery: ${DateTime.now().add(Duration(days: 3)).day}-${DateTime.now().add(Duration(days: 5)).day} ${DateTime.now().add(Duration(days: 3)).month}',
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _shipping == 0
                            ? 'FREE'
                            : '\$${_shipping.toStringAsFixed(2)}',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: _shipping == 0 ? AppTheme.success600 : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingOrderView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 24),
          Text(
            'Processing Your Order...',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 8),
          Text(
            'Please wait while we process your payment',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    switch (_currentStep) {
      case 0:
        return 'Continue to Payment';
      case 1:
        return 'Review Order';
      case 2:
        return 'Place Order • \$${_total.toStringAsFixed(2)}';
      default:
        return 'Continue';
    }
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newText = StringBuffer();
    for (int i = 0; i < newValue.text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write(' ');
      }
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newText = StringBuffer();
    for (int i = 0; i < newValue.text.length; i++) {
      if (i == 2) {
        newText.write('/');
      }
      newText.write(newValue.text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
