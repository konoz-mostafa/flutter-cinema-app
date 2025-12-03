class Booking {
<<<<<<< HEAD
  final String id;
  final String userEmail;
  final String movieId;
  final List<String> seats;
  final DateTime dateTime;
  final String timeSlot;

  Booking({
    required this.id,
    required this.userEmail,
    required this.movieId,
    required this.seats,
    required this.dateTime,
    required this.timeSlot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'movieId': movieId,
      'seats': seats,
      'dateTime': dateTime.toIso8601String(),
      'timeSlot': timeSlot,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      userEmail: map['userEmail'] ?? '',
      movieId: map['movieId'] ?? '',
      seats: List<String>.from(map['seats'] ?? []),
      dateTime: map['dateTime'] is DateTime
          ? map['dateTime']
          : DateTime.parse(map['dateTime']?.toString() ?? DateTime.now().toIso8601String()),
      timeSlot: map['timeSlot'] ?? '',
    );
  }
=======
  final String userEmail;
  final List<String> seats;

  Booking({required this.userEmail, required this.seats});
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
}

// class Booking {
//   final String id;
//   final String userEmail;
//   final String movieId;
//   final List<String> seats;
//   final DateTime dateTime;

//   Booking({
//     required this.id,
//     required this.userEmail,
//     required this.movieId,
//     required this.seats,
//     required this.dateTime,
//   });

//   // تحويل للكلاود/JSON
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userEmail': userEmail,
//       'movieId': movieId,
//       'seats': seats,
//       'dateTime': dateTime.toIso8601String(),
//     };
//   }

//   // تحويل من الكلاود/JSON
//   factory Booking.fromMap(Map<String, dynamic> map) {
//     return Booking(
//       id: map['id'],
//       userEmail: map['userEmail'],
//       movieId: map['movieId'],
//       seats: List<String>.from(map['seats']),
//       dateTime: DateTime.parse(map['dateTime']),
//     );
//   }
// }
