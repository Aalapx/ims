import 'package:flutter/foundation.dart';
import '../models/accommodation.dart';
import '../models/accommodation_booking_request.dart';
import '../services/api_service.dart';

class AccommodationProvider extends ChangeNotifier {
  final ApiService _apiService;
  List<Accommodation> _accommodations = [];
  bool _isLoading = false;
  String? _error;

  AccommodationProvider(this._apiService);

  List<Accommodation> get accommodations => _accommodations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAccommodations() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Mock data for testing - in a real app this would come from the API
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      _accommodations = [
        Accommodation(
          id: 1,
          type: 'Single Room',
          capacity: '1 Person',
          price: 45.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg',
        ),
        Accommodation(
          id: 2,
          type: 'Double Room',
          capacity: '2 People',
          price: 65.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271618/pexels-photo-271618.jpeg',
        ),
        Accommodation(
          id: 3,
          type: 'Suite',
          capacity: '2 People',
          price: 90.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271619/pexels-photo-271619.jpeg',
        ),
        Accommodation(
          id: 4,
          type: 'Shared Room',
          capacity: '4 People',
          price: 30.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg',
        ),
        Accommodation(
          id: 5,
          type: 'Studio Apartment',
          capacity: '1 Person',
          price: 75.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271618/pexels-photo-271618.jpeg',
        ),
        Accommodation(
          id: 6,
          type: 'Deluxe Room',
          capacity: '2 People',
          price: 85.0,
          isAvailable: true,
          imageUrl:
              'https://images.pexels.com/photos/271619/pexels-photo-271619.jpeg',
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch accommodations';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> bookAccommodation(AccommodationBookingRequest request) async {
    try {
      _isLoading = true;
      notifyListeners();

      // In a real app, this would call the API
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to book accommodation';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
