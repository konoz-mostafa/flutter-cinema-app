import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../services/vendor_services.dart'; // استدعاء السيرفيس الجديد

class SeatsViewScreen extends StatefulWidget {
  final Movie movie;
  final String selectedTimeSlot;
  final bool isVendor; // true لو عرض فقط

  const SeatsViewScreen({
    super.key,
    required this.movie,
    required this.selectedTimeSlot,
    this.isVendor = false, // default false
  });

  @override
  State<SeatsViewScreen> createState() => _SeatsViewScreenState();
}

class _SeatsViewScreenState extends State<SeatsViewScreen> {
  List<int> bookedSeats = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (widget.isVendor) {
      _loadVendorBookings();
    } else {
      _loadCustomerBookings();
    }
  }

  void _loadCustomerBookings() {
    bookedSeats = List<int>.from(
      widget.movie.bookings[widget.selectedTimeSlot] ?? [],
    );
    _loading = false;
  }

  Future<void> _loadVendorBookings() async {
    try {
      final bookings = await VendorServices.getBookingsForVendor(
        widget.movie.id.toString(),
        widget.selectedTimeSlot,
      );
      final seats = bookings
          .expand((b) => b.seats)
          .map((s) => int.tryParse(s) ?? 0)
          .toSet()
          .toList();
      setState(() {
        bookedSeats = seats;
        _loading = false;
      });
    } catch (e) {
      print('Error loading vendor bookings: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${widget.isVendor ? 'View' : 'Manage'} Seats - ${widget.selectedTimeSlot}"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.isVendor ? 'View' : 'Manage'} Seats - ${widget.selectedTimeSlot}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: widget.movie.totalSeats,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final seatNumber = index + 1;
            final isBooked = bookedSeats.contains(seatNumber);

            return AbsorbPointer(
              absorbing: widget.isVendor, // يمنع الضغط لو vendor
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isBooked
                      ? Colors.red
                      : widget.isVendor
                          ? Colors.grey.shade400
                          : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  seatNumber.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: widget.isVendor
          ? null // لو vendor => نخفي زر الحفظ
          : FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () {
                widget.movie.bookings[widget.selectedTimeSlot] = bookedSeats;
                Navigator.pop(context);
              },
            ),
    );
  }
}
