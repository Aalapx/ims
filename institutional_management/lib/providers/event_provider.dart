import 'package:flutter/foundation.dart';
import '../models/event.dart';
import '../services/api_service.dart';

class EventProvider extends ChangeNotifier {
  final ApiService _apiService;
  List<Event> _events = [];
  bool _isLoading = false;
  String? _error;

  EventProvider(this._apiService);

  List<Event> get events => _events;
  List<Event> get upcomingEvents =>
      _events.where((event) => event.isUpcoming).toList();
  List<Event> get liveEvents => _events.where((event) => event.isLive).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvents() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Mock data for testing - in a real app this would come from the API
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      final now = DateTime.now();

      _events = [
        Event(
          id: '1',
          title: 'Annual Technology Conference',
          description:
              'Join us for the annual technology conference featuring keynote speakers from leading tech companies. The event will cover topics such as AI, blockchain, and cybersecurity.',
          startDate: now.add(Duration(days: 15)),
          endDate: now.add(Duration(days: 17)),
          location: 'Main Auditorium',
          isLive: false,
          imageUrl:
              'https://images.pexels.com/photos/2774556/pexels-photo-2774556.jpeg',
        ),
        Event(
          id: '2',
          title: 'Career Fair 2023',
          description:
              'Connect with recruiters from top companies across various industries. Bring your resume and be prepared for on-the-spot interviews.',
          startDate: now.add(Duration(days: 5)),
          endDate: now.add(Duration(days: 6)),
          location: 'Campus Grounds',
          isLive: false,
          imageUrl:
              'https://images.pexels.com/photos/1181396/pexels-photo-1181396.jpeg',
        ),
        Event(
          id: '3',
          title: 'Online Programming Workshop',
          description:
              'Learn the basics of Python programming in this hands-on workshop designed for beginners. No prior programming experience required.',
          startDate: now.subtract(Duration(hours: 1)),
          endDate: now.add(Duration(hours: 3)),
          location: 'Virtual - Zoom',
          isLive: true,
          imageUrl:
              'https://images.pexels.com/photos/1181345/pexels-photo-1181345.jpeg',
        ),
        Event(
          id: '4',
          title: 'Literary Festival',
          description:
              'Celebrate literature with author readings, book signings, and panel discussions. Featured authors include award-winning novelists and poets.',
          startDate: now.add(Duration(days: 20)),
          endDate: now.add(Duration(days: 22)),
          location: 'Library Courtyard',
          isLive: false,
          imageUrl:
              'https://images.pexels.com/photos/1181354/pexels-photo-1181354.jpeg',
        ),
        Event(
          id: '5',
          title: 'Science Exhibition',
          description:
              'Explore innovative projects created by our students across various scientific disciplines. Interactive demonstrations and experiments will be available.',
          startDate: now.subtract(Duration(hours: 2)),
          endDate: now.add(Duration(hours: 10)),
          location: 'Science Building',
          isLive: true,
          imageUrl:
              'https://images.pexels.com/photos/1181371/pexels-photo-1181371.jpeg',
        ),
      ];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch events';
      _isLoading = false;
      notifyListeners();
    }
  }

  Event getEventById(String id) {
    return _events.firstWhere((event) => event.id == id);
  }
}
