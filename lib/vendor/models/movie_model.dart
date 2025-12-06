class Movie {
  String id; // <-- جديد
  String title;
  String description;
  String imagePath;
  List<String> timeSlots;
  int totalSeats;

  // New structure: each time slot has its own booked seats
  Map<String, List<int>> bookings;

  Movie({
    required this.id, // لازم هنا
    required this.title,
    required this.description,
    required this.imagePath,
    required this.timeSlots,
    this.totalSeats = 47,
    Map<String, List<int>>? bookings,
  }) : bookings = bookings ?? {
          for (var slot in timeSlots) slot: [],
        };
}
