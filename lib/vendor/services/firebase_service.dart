import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save a movie to Firebase
  static Future<void> addMovie(Movie movie) async {
    try {
      final movieId = DateTime.now().millisecondsSinceEpoch;
      
      await _db.collection('movies').add({
        'id': movieId,
        'title': movie.title,
        'description': movie.description,
        'posterUrl': movie.imagePath, // Map imagePath to posterUrl for customer app
        'timeSlots': movie.timeSlots,
        'totalSeats': movie.totalSeats,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Movie saved to Firebase: ${movie.title}');
    } catch (e) {
      print('Error saving movie to Firebase: $e');
      rethrow;
    }
  }

  // Get all movies from Firebase with document IDs
  static Future<Map<String, Movie>> getMoviesWithIds() async {
    try {
      final snapshot = await _db.collection('movies').get();
      print('Firestore returned ${snapshot.docs.length} movie documents');
      final Map<String, Movie> moviesMap = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();
        moviesMap[doc.id] = Movie(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          imagePath: data['posterUrl'] ?? data['imagePath'] ?? '',
          timeSlots: List<String>.from(data['timeSlots'] ?? []),
          totalSeats: data['totalSeats'] ?? 47,
        );
      }
      print('Returning ${moviesMap.length} movies');
      return moviesMap;
    } catch (e) {
      print('Error getting movies from Firebase: $e');
      return {};
    }
  }

  // Delete movie by document ID
  static Future<void> deleteMovieById(String docId) async {
    try {
      await _db.collection('movies').doc(docId).delete();
      print('Movie deleted from Firebase');
    } catch (e) {
      print('Error deleting movie from Firebase: $e');
      rethrow;
    }
  }
}
