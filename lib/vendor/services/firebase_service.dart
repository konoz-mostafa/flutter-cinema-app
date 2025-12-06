// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/movie_model.dart';

// class FirebaseService {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Save a movie to Firebase
//   static Future<void> addMovie(Movie movie) async {
//     try {
//       final movieId = DateTime.now().millisecondsSinceEpoch;

//       await _db.collection('movies').add({
//         'id': movieId,
//         'title': movie.title,
//         'description': movie.description,
//         'posterUrl': movie.imagePath, // Map imagePath to posterUrl for customer app
//         'timeSlots': movie.timeSlots,
//         'totalSeats': movie.totalSeats,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       print('Movie saved to Firebase: ${movie.title}');
//     } catch (e) {
//       print('Error saving movie to Firebase: $e');
//       rethrow;
//     }
//   }

//   // Get all movies from Firebase with document IDs
//   static Future<Map<String, Movie>> getMoviesWithIds() async {
//     try {
//       final snapshot = await _db.collection('movies').get();
//       print('Firestore returned ${snapshot.docs.length} movie documents');
//       final Map<String, Movie> moviesMap = {};
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         moviesMap[doc.id] = Movie(
//           title: data['title'] ?? '',
//           description: data['description'] ?? '',
//           imagePath: data['posterUrl'] ?? data['imagePath'] ?? '',
//           timeSlots: List<String>.from(data['timeSlots'] ?? []),
//           totalSeats: data['totalSeats'] ?? 47,
//         );
//       }
//       print('Returning ${moviesMap.length} movies');
//       return moviesMap;
//     } catch (e) {
//       print('Error getting movies from Firebase: $e');
//       return {};
//     }
//   }

//   // Update movie by document ID
//   static Future<void> updateMovieById(String docId, Movie movie) async {
//     try {
//       await _db.collection('movies').doc(docId).update({
//         'title': movie.title,
//         'description': movie.description,
//         'posterUrl': movie.imagePath,
//         'timeSlots': movie.timeSlots,
//         'totalSeats': movie.totalSeats,
//         'updatedAt': FieldValue.serverTimestamp(),
//       });
//       print('Movie updated in Firebase: ${movie.title}');
//     } catch (e) {
//       print('Error updating movie in Firebase: $e');
//       rethrow;
//     }
//   }

//   // Delete movie by document ID
//   static Future<void> deleteMovieById(String docId) async {
//     try {
//       await _db.collection('movies').doc(docId).delete();
//       print('Movie deleted from Firebase');
//     } catch (e) {
//       print('Error deleting movie from Firebase: $e');
//       rethrow;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_model.dart';
import '../models/booking_model.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ==================== MOVIES ====================

  // Save a movie to Firebase
  static Future<void> addMovie(Movie movie) async {
    try {
      final movieId = DateTime.now().millisecondsSinceEpoch;

      await _db.collection('movies').add({
        'id': movieId,
        'title': movie.title,
        'description': movie.description,
        'posterUrl': movie.imagePath,
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
      print('🎬 Firestore returned ${snapshot.docs.length} movie documents');
      final Map<String, Movie> moviesMap = {};
      for (var doc in snapshot.docs) {
        final data = doc.data();

        // استخدم الـ 'id' field من داخل الـ document (نفس اللي الـ Customer بيستخدمه)
        String movieId = '';
        if (data['id'] != null) {
          movieId = data['id'].toString();
        } else {
          movieId = doc.id; // fallback
        }

        print(
          '🎬 Movie: ${data['title']} - Movie ID (field): $movieId - Doc ID: ${doc.id}',
        );

        moviesMap[doc.id] = Movie(
          id: movieId, // ✅ استخدم الـ field value
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          imagePath: data['posterUrl'] ?? data['imagePath'] ?? '',
          timeSlots: List<String>.from(data['timeSlots'] ?? []),
          totalSeats: data['totalSeats'] ?? 47,
        );
      }
      print('🎬 Returning ${moviesMap.length} movies');
      return moviesMap;
    } catch (e) {
      print('❌ Error getting movies from Firebase: $e');
      return {};
    }
  }

  // Update movie by document ID
  static Future<void> updateMovieById(String docId, Movie movie) async {
    try {
      await _db.collection('movies').doc(docId).update({
        'title': movie.title,
        'description': movie.description,
        'posterUrl': movie.imagePath,
        'timeSlots': movie.timeSlots,
        'totalSeats': movie.totalSeats,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('Movie updated in Firebase: ${movie.title}');
    } catch (e) {
      print('Error updating movie in Firebase: $e');
      rethrow;
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

  // ==================== BOOKINGS ====================

  /// جلب الحجوزات حسب movieId و timeSlot
  static Future<List<Booking>> getBookings(
    String movieId,
    String timeSlot,
  ) async {
    try {
      print('🔍 Fetching bookings for movie: $movieId, timeSlot: $timeSlot');

      // جرب الاتنين: movieId بيساوي الـ document ID أو الـ field جوا الـ document
      final querySnapshot = await _db
          .collection('bookings')
          .where('movieId', isEqualTo: movieId)
          .where('timeSlot', isEqualTo: timeSlot)
          .get();

      print('🔍 Found ${querySnapshot.docs.length} bookings');

      if (querySnapshot.docs.isEmpty) {
        print('⚠️ No bookings found. Checking all bookings...');
        // لو مش لاقي حاجة، اطبع كل الحجوزات الموجودة للـ debug
        final allBookings = await _db.collection('bookings').limit(5).get();
        print('📋 Sample bookings in database:');
        for (var doc in allBookings.docs) {
          print('  - Doc ID: ${doc.id}');
          print('    Data: ${doc.data()}');
        }
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        print('✅ Booking found - seats: ${data['seats']}');
        return Booking(
          id: doc.id,
          userEmail: data['userEmail'] ?? '',
          movieId: data['movieId'] ?? '',
          seats: List<String>.from(data['seats'] ?? []),
          dateTime:
              (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          timeSlot: data['timeSlot'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('❌ Error fetching bookings: $e');
      return [];
    }
  }

  /// إنشاء حجز جديد
  static Future<void> createBooking(Booking booking) async {
    try {
      // التحقق من توفر الكراسي أولاً
      final available = await areSeatsAvailable(
        booking.movieId,
        booking.timeSlot,
        booking.seats,
      );

      if (!available) {
        throw Exception('Some seats are already booked');
      }

      await _db.collection('bookings').add({
        'userEmail': booking.userEmail,
        'movieId': booking.movieId,
        'seats': booking.seats,
        'dateTime': Timestamp.fromDate(booking.dateTime),
        'timeSlot': booking.timeSlot,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('Booking created successfully for ${booking.userEmail}');
    } catch (e) {
      print('Error creating booking: $e');
      throw Exception('Failed to create booking: $e');
    }
  }

  /// جلب حجوزات المستخدم
  static Future<List<Booking>> getUserBookings(String userEmail) async {
    try {
      final querySnapshot = await _db
          .collection('bookings')
          .where('userEmail', isEqualTo: userEmail)
          .orderBy('dateTime', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Booking(
          id: doc.id,
          userEmail: data['userEmail'] ?? '',
          movieId: data['movieId'] ?? '',
          seats: List<String>.from(data['seats'] ?? []),
          dateTime:
              (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          timeSlot: data['timeSlot'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching user bookings: $e');
      return [];
    }
  }

  /// حذف حجز
  static Future<void> deleteBooking(String bookingId) async {
    try {
      await _db.collection('bookings').doc(bookingId).delete();
      print('Booking deleted successfully');
    } catch (e) {
      print('Error deleting booking: $e');
      throw Exception('Failed to delete booking: $e');
    }
  }

  /// جلب كل حجوزات فيلم معين (كل المواعيد)
  static Future<List<Booking>> getMovieBookings(String movieId) async {
    try {
      final querySnapshot = await _db
          .collection('bookings')
          .where('movieId', isEqualTo: movieId)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Booking(
          id: doc.id,
          userEmail: data['userEmail'] ?? '',
          movieId: data['movieId'] ?? '',
          seats: List<String>.from(data['seats'] ?? []),
          dateTime:
              (data['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
          timeSlot: data['timeSlot'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error fetching movie bookings: $e');
      return [];
    }
  }

  /// التحقق من توفر الكراسي قبل الحجز
  static Future<bool> areSeatsAvailable(
    String movieId,
    String timeSlot,
    List<String> seats,
  ) async {
    try {
      final bookings = await getBookings(movieId, timeSlot);

      for (var booking in bookings) {
        for (var seat in seats) {
          if (booking.seats.contains(seat)) {
            print('Seat $seat is already booked');
            return false;
          }
        }
      }

      return true;
    } catch (e) {
      print('Error checking seat availability: $e');
      return false;
    }
  }

  /// جلب إحصائيات الحجوزات لفيلم معين
  static Future<Map<String, dynamic>> getBookingStats(String movieId) async {
    try {
      final bookings = await getMovieBookings(movieId);

      int totalSeatsBooked = 0;
      int totalCustomers = bookings.length;
      Map<String, int> bookingsByTimeSlot = {};

      for (var booking in bookings) {
        totalSeatsBooked += booking.seats.length;

        if (bookingsByTimeSlot.containsKey(booking.timeSlot)) {
          bookingsByTimeSlot[booking.timeSlot] =
              bookingsByTimeSlot[booking.timeSlot]! + booking.seats.length;
        } else {
          bookingsByTimeSlot[booking.timeSlot] = booking.seats.length;
        }
      }

      return {
        'totalSeatsBooked': totalSeatsBooked,
        'totalCustomers': totalCustomers,
        'bookingsByTimeSlot': bookingsByTimeSlot,
      };
    } catch (e) {
      print('Error getting booking stats: $e');
      return {
        'totalSeatsBooked': 0,
        'totalCustomers': 0,
        'bookingsByTimeSlot': {},
      };
    }
  }
}
