class Hall {
  final int id;
  final String name;
  final String description;
  final int capacity;
  final double pricePerHour;
  final List<String> amenities;
  final String imageUrl;
  final bool isAvailable;

  Hall({
    required this.id,
    required this.name,
    required this.description,
    required this.capacity,
    required this.pricePerHour,
    this.amenities = const [],
    required this.imageUrl,
    required this.isAvailable,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      capacity: json['capacity'] as int,
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      amenities: (json['amenities'] as List<dynamic>?)?.cast<String>() ?? [],
      imageUrl: json['imageUrl'] as String? ?? '',
      isAvailable: json['available'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
      'pricePerHour': pricePerHour,
      'amenities': amenities,
      'imageUrl': imageUrl,
      'available': isAvailable,
    };
  }
}

class TimeSlot {
  final String date;
  final String time;
  final bool isAvailable;

  TimeSlot({required this.date, required this.time, required this.isAvailable});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      date: json['date'],
      time: json['time'],
      isAvailable: json['isAvailable'],
    );
  }
}
