// import 'package:flutter/material.dart';
// import '../models/movie_model.dart';

// class SeatsViewScreen extends StatefulWidget {
//   final Movie movie;

//   const SeatsViewScreen({super.key, required this.movie});

//   @override
//   State<SeatsViewScreen> createState() => _SeatsViewScreenState();
// }

// class _SeatsViewScreenState extends State<SeatsViewScreen> {
//   late List<int> bookedSeats;

//   @override
//   void initState() {
//     super.initState();
//     bookedSeats = widget.movie.bookedSeats;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Seats View"),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFE0BBE4), // موف فاتح
//                 Color(0xFF957DAD),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           itemCount: widget.movie.totalSeats,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 7, // 7 seats per row
//             childAspectRatio: 1,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//           ),
//           itemBuilder: (context, index) {
//             final seatNumber = index + 1;
//             final isBooked = bookedSeats.contains(seatNumber);
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   if (isBooked) {
//                     bookedSeats.remove(seatNumber);
//                   } else {
//                     bookedSeats.add(seatNumber);
//                   }
//                 });
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: isBooked ? Colors.red : Colors.green,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   seatNumber.toString(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class SeatsViewScreen extends StatelessWidget {
  final Movie movie;

  const SeatsViewScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    List<int> bookedSeats = movie.bookedSeats;

    Widget buildSeat(int seatNumber) {
      final isBooked = bookedSeats.contains(seatNumber);
      return Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBooked ? Colors.grey.shade400 : Colors.white,
          border: Border.all(color: Colors.grey.shade600, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          seatNumber.toString(),
          style: TextStyle(
            color: isBooked ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Seats View"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0BBE4), Color(0xFF957DAD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شاشة العرض SCREEN
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                "SCREEN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    ...List.generate(4, (row) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(5, (col) {
                                final seatNumber = row * 9 + col + 1;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: buildSeat(seatNumber),
                                );
                              }),
                            ),
                            const SizedBox(width: 40),
                            Row(
                              children: List.generate(4, (col) {
                                final seatNumber = row * 9 + 5 + col + 1;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: buildSeat(seatNumber),
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                    // الصف الأخير 11 كرسي متصل
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: List.generate(11, (col) {
                          final seatNumber = 4 * 9 + col + 1;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: buildSeat(seatNumber),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // الشرح أسفل الكراسي
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: const EdgeInsets.only(right: 6),
                    ),
                    const Text("Available"),
                  ],
                ),
                const SizedBox(width: 30),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: const EdgeInsets.only(right: 6),
                    ),
                    const Text("Booked"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
