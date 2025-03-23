import 'package:flutter/foundation.dart';
import '../models/hall.dart';
import '../models/hall_booking_request.dart';
import '../services/api_service.dart';
import '../config/api_config.dart';

class HallProvider extends ChangeNotifier {
  final ApiService _apiService;
  List<Hall> _halls = [];
  Hall? _selectedHall;
  bool _isLoading = false;
  String? _error;

  HallProvider(this._apiService);

  // Getters
  List<Hall> get halls => _halls;
  Hall? get selectedHall => _selectedHall;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setSelectedHall(Hall hall) {
    _selectedHall = hall;
    notifyListeners();
  }

  Future<void> fetchHalls() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.get(
        ApiConfig.halls,
        (json) => (json as List)
            .map((item) => Hall.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      _halls = response;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> bookHall(HallBookingRequest request) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _apiService.post(
        ApiConfig.hallBookings,
        request.toJson(),
        (json) => HallBooking.fromJson(json as Map<String, dynamic>),
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
