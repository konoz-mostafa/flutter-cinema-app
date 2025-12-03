class Movie {
  final int id;
  final String title;
  final String description;
<<<<<<< HEAD
  final String posterUrl;
=======
  final String emoji;
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
  final List<String> timeSlots;
  final int totalSeats;

  Movie({
    required this.id,
    required this.title,
    required this.description,
<<<<<<< HEAD
    required this.posterUrl,
    required this.timeSlots,
    this.totalSeats = 47,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'posterUrl': posterUrl,
      'timeSlots': timeSlots,
      'totalSeats': totalSeats,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '0') ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      posterUrl: map['posterUrl'] ?? '',
      timeSlots: List<String>.from(map['timeSlots'] ?? []),
      totalSeats: map['totalSeats'] ?? 47,
    );
  }
=======
    required this.emoji,
    required this.timeSlots,
    this.totalSeats = 47,
  });
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
}

// class Movie {
//   final int id;
//   final String title;
//   final String description;
//   final String posterUrl;
//   final List<String> timeSlots;
//   final int totalSeats;

//   Movie({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.posterUrl,
//     required this.timeSlots,
//     this.totalSeats = 47,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'posterUrl': posterUrl,
//       'timeSlots': timeSlots,
//       'totalSeats': totalSeats,
//     };
//   }

//   factory Movie.fromMap(Map<String, dynamic> map) {
//     return Movie(
//       id: map['id'],
//       title: map['title'],
//       description: map['description'],
//       posterUrl: map['posterUrl'],
//       timeSlots: List<String>.from(map['timeSlots']),
//       totalSeats: map['totalSeats'] ?? 47,
//     );
//   }
// }
