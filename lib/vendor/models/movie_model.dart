class Movie {
  String title;
  String description;
  String imagePath; // local path or asset
  List<String> timeSlots;
  int totalSeats;
  List<int> bookedSeats; // List of booked seat numbers

  Movie({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.timeSlots,
    this.totalSeats = 47,
    List<int>? bookedSeats,
  }) : bookedSeats = bookedSeats ?? [];
}
