import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class ApiConfig {
  // Use appropriate base URL depending on platform
  static String get baseUrl {
    // Use localhost for web and desktop platforms
    if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'http://127.0.0.1:8090/api';
    }
    // Use 10.0.2.2 for Android emulator
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8090/api';
    }
    // Use localhost for iOS simulator
    if (Platform.isIOS) {
      return 'http://localhost:8090/api';
    }
    // Default to localhost
    return 'http://127.0.0.1:8090/api';
  }

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  // Canteen endpoints
  static const String foodItems = '/canteen/food-items';
  static const String orders = '/canteen/orders';
  static const String orderHistory = '/canteen/orders/history';

  // Accommodation endpoints
  static const String rooms = '/accommodation/rooms';
  static const String bookings = '/accommodation/bookings';
  static const String bookingHistory = '/accommodation/bookings/history';

  // User endpoints
  static const String userProfile = '/users/profile';
  static const String updateProfile = '/users/profile/update';
}
