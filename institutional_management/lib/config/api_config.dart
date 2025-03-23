import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class ApiConfig {
  // Use appropriate base URL depending on platform
  static String get baseUrl {
    // Use localhost for web and desktop platforms
    if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return 'http://127.0.0.1:8090';
    }
    // Use 10.0.2.2 for Android emulator
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8090';
    }
    // Use localhost for iOS simulator
    if (Platform.isIOS) {
      return 'http://localhost:8090';
    }
    // Default to localhost
    return 'http://127.0.0.1:8090';
  }

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';

  // Canteen endpoints
  static const String foodItems = '/api/canteen/food-items';
  static const String orders = '/api/canteen/orders';
  static const String orderHistory = '/api/canteen/orders/history';

  // Accommodation endpoints
  static const String rooms = '/api/accommodation/rooms';
  static const String bookings = '/api/accommodation/bookings';
  static const String bookingHistory = '/api/accommodation/bookings/history';

  // Hall endpoints
  static const String halls = '/api/halls';
  static const String hallBookings = '/api/halls/bookings';
  static const String hallBookingHistory = '/api/halls/bookings/history';

  // User endpoints
  static const String userProfile = '/api/users/profile';
  static const String updateProfile = '/api/users/profile/update';
}
