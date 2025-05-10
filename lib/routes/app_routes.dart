import 'package:flutter/material.dart';
import '../presentation/pet_management_screen/pet_management_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/order_tracking_screen/order_tracking_screen.dart';
import '../presentation/cart_screen/cart_screen.dart';
import '../presentation/store_inventory_screen/store_inventory_screen.dart';
import '../presentation/pet_details_screen/pet_details_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/checkout_screen/checkout_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String petManagementScreen = '/pet-management-screen';
  static const String homeScreen = '/home-screen';
  static const String userProfileScreen = '/user-profile-screen';
  static const String storeInventoryScreen = '/store-inventory-screen';
  static const String petDetailsScreen = '/pet-details-screen';
  static const String cartScreen = '/cart-screen';
  static const String orderTrackingScreen = '/order-tracking-screen';
  static const String loginScreen = '/login-screen';
  static const String registrationScreen = '/registration-screen';
  static const String checkoutScreen = '/checkout-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeScreen(),
    petManagementScreen: (context) => const PetManagementScreen(),
    homeScreen: (context) => const HomeScreen(),
    orderTrackingScreen: (context) => const OrderTrackingScreen(),
    cartScreen: (context) => const CartScreen(),
    storeInventoryScreen: (context) => const StoreInventoryScreen(),
    petDetailsScreen: (context) => const PetDetailsScreen(petId: 1),
    userProfileScreen: (context) => const UserProfileScreen(),
    loginScreen: (context) => const LoginScreen(),
    registrationScreen: (context) => const RegistrationScreen(),
    checkoutScreen: (context) => const CheckoutScreen(),
  };
}
