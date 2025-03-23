import 'package:flutter/material.dart';
import 'package:institutional_management/models/hall.dart';
import 'package:provider/provider.dart';
import '../providers/hall_provider.dart';
import '../widgets/hall_card.dart';
import '../models/hall_booking_request.dart';
import '../providers/auth_provider.dart';

class HallBookingPage extends StatefulWidget {
  const HallBookingPage({Key? key}) : super(key: key);

  @override
  _HallBookingPageState createState() => _HallBookingPageState();
}

class _HallBookingPageState extends State<HallBookingPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startTime;
  DateTime? _endTime;
  final _purposeController = TextEditingController();
  final _attendeesController = TextEditingController();
  final _specialReqController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HallProvider>().fetchHalls();
  }

  @override
  void dispose() {
    _purposeController.dispose();
    _attendeesController.dispose();
    _specialReqController.dispose();
    super.dispose();
  }

  Future<void> _bookHall(BuildContext context, Hall hall) async {
    if (!_formKey.currentState!.validate()) return;

    if (_startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a start time')),
      );
      return;
    }

    if (_endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an end time')),
      );
      return;
    }

    if (_endTime!.isBefore(_startTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    final userId = context.read<AuthProvider>().currentUser?.id.toString();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login to book a hall')),
      );
      return;
    }

    final request = HallBookingRequest(
      hallId: hall.id,
      userId: userId,
      startTime: _startTime!,
      endTime: _endTime!,
      purpose: _purposeController.text,
      expectedAttendees: int.parse(_attendeesController.text),
      specialRequirements: _specialReqController.text.isEmpty 
          ? null 
          : _specialReqController.text,
    );

    try {
      final success = await context.read<HallProvider>().bookHall(request);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hall booked successfully!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.read<HallProvider>().error ?? 
              'Failed to book hall. Please try again.',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HallProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text('Hall Booking')),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text('Hall Booking')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.halls.length,
                  itemBuilder: (context, index) {
                    final hall = provider.halls[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: hall.imageUrl.isNotEmpty
                            ? Image.network(
                                hall.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.meeting_room, size: 50),
                        title: Text(hall.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hall.description),
                            Text('Capacity: ${hall.capacity} people'),
                            Text('Price: \$${hall.pricePerHour}/hour'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: hall.isAvailable
                              ? () => _showBookingDialog(context, hall)
                              : null,
                          child: Text(
                            hall.isAvailable ? 'Book Now' : 'Not Available',
                          ),
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              ),
              if (provider.error != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    provider.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showBookingDialog(BuildContext context, Hall hall) {
    // Reset form values
    _startTime = null;
    _endTime = null;
    _purposeController.clear();
    _attendeesController.clear();
    _specialReqController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book ${hall.name}'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Select Start Time'),
                  subtitle: Text(_startTime?.toString() ?? 'Not selected'),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _startTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                ),
                ListTile(
                  title: Text('Select End Time'),
                  subtitle: Text(_endTime?.toString() ?? 'Not selected'),
                  onTap: () async {
                    if (_startTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select start time first')),
                      );
                      return;
                    }
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _startTime!,
                      firstDate: _startTime!,
                      lastDate: _startTime!.add(Duration(days: 30)),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _endTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                ),
                TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(labelText: 'Purpose'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter purpose' : null,
                ),
                TextFormField(
                  controller: _attendeesController,
                  decoration: InputDecoration(labelText: 'Expected Attendees'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter expected attendees';
                    }
                    final attendees = int.tryParse(value!);
                    if (attendees == null) {
                      return 'Please enter a valid number';
                    }
                    if (attendees > hall.capacity) {
                      return 'Exceeds hall capacity of ${hall.capacity}';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _specialReqController,
                  decoration: InputDecoration(
                    labelText: 'Special Requirements (Optional)',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _bookHall(context, hall),
            child: Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
