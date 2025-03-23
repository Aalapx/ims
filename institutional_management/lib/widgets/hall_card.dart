import 'package:flutter/material.dart';
import '../models/hall.dart';

class HallCard extends StatelessWidget {
  final Hall hall;
  final VoidCallback onSelected;

  const HallCard({Key? key, required this.hall, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (hall.imageUrl.isNotEmpty)
            Image.network(
              hall.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hall.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                Text(hall.description),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Capacity: ${hall.capacity} people',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: \$${hall.pricePerHour}/hour',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: hall.isAvailable ? onSelected : null,
                      child: Text(
                        hall.isAvailable ? 'Book Now' : 'Not Available',
                      ),
                    ),
                  ],
                ),
                if (hall.amenities.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Text(
                    'Amenities:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8,
                    children: hall.amenities
                        .map((amenity) => Chip(label: Text(amenity)))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
