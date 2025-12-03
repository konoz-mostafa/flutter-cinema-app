import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class SeatsViewScreen extends StatefulWidget {
  final Movie movie;

  const SeatsViewScreen({super.key, required this.movie});

  @override
  State<SeatsViewScreen> createState() => _SeatsViewScreenState();
}

class _SeatsViewScreenState extends State<SeatsViewScreen> {
  late List<int> bookedSeats;

  @override
  void initState() {
    super.initState();
    bookedSeats = widget.movie.bookedSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seats View")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: widget.movie.totalSeats,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 7 seats per row
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final seatNumber = index + 1;
            final isBooked = bookedSeats.contains(seatNumber);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isBooked) {
                    bookedSeats.remove(seatNumber);
                  } else {
                    bookedSeats.add(seatNumber);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isBooked ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  seatNumber.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
