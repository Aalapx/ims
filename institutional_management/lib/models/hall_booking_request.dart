import '../models/hall.dart';
import '../models/user.dart';

class HallBookingRequest {
  final int hallId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String purpose;
  final int expectedAttendees;
  final String? specialRequirements;

  HallBookingRequest({
    required this.hallId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.purpose,
    required this.expectedAttendees,
    this.specialRequirements,
  });

  Map<String, dynamic> toJson() {
    return {
      'hallId': hallId,
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'purpose': purpose,
      'expectedAttendees': expectedAttendees,
      'specialRequirements': specialRequirements,
    };
  }
}

class HallBooking {
  final int id;
  final Hall hall;
  final User user;
  final DateTime startTime;
  final DateTime endTime;
  final String purpose;
  final int expectedAttendees;
  final String? specialRequirements;
  final String status;
  final DateTime createdAt;

  HallBooking({
    required this.id,
    required this.hall,
    required this.user,
    required this.startTime,
    required this.endTime,
    required this.purpose,
    required this.expectedAttendees,
    this.specialRequirements,
    required this.status,
    required this.createdAt,
  });

  factory HallBooking.fromJson(Map<String, dynamic> json) {
    return HallBooking(
      id: json['id'] as int,
      hall: Hall.fromJson(json['hall'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      purpose: json['purpose'] as String,
      expectedAttendees: json['expectedAttendees'] as int,
      specialRequirements: json['specialRequirements'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hall': hall.toJson(),
      'user': user.toJson(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'purpose': purpose,
      'expectedAttendees': expectedAttendees,
      'specialRequirements': specialRequirements,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 