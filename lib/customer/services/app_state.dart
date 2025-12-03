<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
import '../models/user.dart';
import '../models/movie.dart';
import '../models/booking.dart';

class AppState {
<<<<<<< HEAD
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===== Users =====
  
  // Login user
  static Future<User?> loginUser(String email, String password) async {
    try {
      final snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }
      
      final doc = snapshot.docs.first;
      final data = doc.data();
      
      // Verify password
      if (data['password'] != password) {
        return null;
      }
      
      return User(
        id: doc.id,
        fullName: data['fullName'] ?? data['fullname'] ?? '',
        email: data['email'] ?? '',
      );
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Register new user
  static Future<User?> registerUser(String email, String fullName, String password) async {
    try {
      // Check if user already exists
      final existing = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      
      if (existing.docs.isNotEmpty) {
        return null;
      }

      // Create new user
      final docRef = await _db.collection('users').add({
        'email': email,
        'fullName': fullName,
        'password': password, // In production, use Firebase Auth!
        'createdAt': FieldValue.serverTimestamp(),
      });

      final newUserDoc = await docRef.get();
      final data = newUserDoc.data()!;
      
      return User(
        id: newUserDoc.id,
        fullName: data['fullName'] ?? data['fullname'] ?? '',
        email: data['email'] ?? '',
      );
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  // Get user by ID
  static Future<User?> getUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      
      final data = doc.data()!;
      return User(
        id: doc.id,
        fullName: data['fullName'] ?? data['fullname'] ?? '',
        email: data['email'] ?? '',
      );
    } catch (e) {
      print('Get user error: $e');
      return null;
    }
  }

  // ===== Movies =====
  
  // Get all movies
  static Future<List<Movie>> getMovies() async {
    try {
      final snapshot = await _db.collection('movies').get();
      print('Firestore returned ${snapshot.docs.length} movie documents'); // Debug
      final movies = snapshot.docs.map((doc) {
        final data = doc.data();
        print('Movie data: ${data['title']} - ${data['posterUrl']}'); // Debug
        // Handle both string and int IDs
        int movieId;
        if (data['id'] != null) {
          movieId = data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0;
        } else {
          movieId = int.tryParse(doc.id) ?? 0;
        }
        
        return Movie(
          id: movieId,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          posterUrl: data['posterUrl'] ?? '',
          timeSlots: List<String>.from(data['timeSlots'] ?? []),
          totalSeats: data['totalSeats'] ?? 47,
        );
      }).toList();
      print('Returning ${movies.length} movies'); // Debug
      return movies;
    } catch (e) {
      print('Get movies error: $e');
      return [];
    }
  }

  // ===== Bookings =====
  
  // Get bookings for a specific movie and time slot
  static Future<List<Booking>> getBookings(String movieId, String timeSlot) async {
    try {
      final snapshot = await _db
          .collection('bookings')
          .where('movieId', isEqualTo: movieId)
          .where('timeSlot', isEqualTo: timeSlot)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        DateTime dateTime;
        if (data['dateTime'] is Timestamp) {
          dateTime = (data['dateTime'] as Timestamp).toDate();
        } else if (data['dateTime'] is String) {
          dateTime = DateTime.parse(data['dateTime']);
        } else {
          dateTime = DateTime.now();
        }
        
        return Booking(
          id: doc.id,
          userEmail: data['userEmail'] ?? '',
          movieId: data['movieId'] ?? '',
          seats: List<String>.from(data['seats'] ?? []),
          dateTime: dateTime,
          timeSlot: data['timeSlot'] ?? timeSlot,
        );
      }).toList();
    } catch (e) {
      print('Get bookings error: $e');
      return [];
    }
  }

  // Create a new booking
  static Future<void> createBooking(Booking booking) async {
    try {
      await _db.collection('bookings').add({
        'userEmail': booking.userEmail,
        'movieId': booking.movieId,
        'seats': booking.seats,
        'timeSlot': booking.timeSlot,
        'dateTime': Timestamp.fromDate(booking.dateTime),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Create booking error: $e');
      rethrow;
    }
  }
}
=======
  static final List<User> users = [
    User(email: 'user1@example.com', password: 'password123', name: 'User 1'),
    User(email: 'user2@example.com', password: 'password123', name: 'User 2'),
  ];

  static final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'The Dark Knight',
      description:
          'Batman must accept one of the greatest tests to fight injustice',
      emoji: '🦇',
      timeSlots: ['10:00 AM', '2:00 PM', '6:00 PM', '9:00 PM'],
    ),
    Movie(
      id: 2,
      title: 'Inception',
      description:
          'A thief who steals corporate secrets through dream-sharing technology',
      emoji: '🌀',
      timeSlots: ['11:00 AM', '3:00 PM', '7:00 PM'],
    ),
    Movie(
      id: 3,
      title: 'Interstellar',
      description: 'A team of explorers travel through a wormhole in space',
      emoji: '🚀',
      timeSlots: ['12:00 PM', '4:00 PM', '8:00 PM'],
    ),
  ];

  static Map<String, List<Booking>> bookings = {};
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import '../models/booking.dart';

// class AppState {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // ===== Users =====

//   // تسجيل الدخول
//   static Future<User?> loginUser(String email, String password) async {
//     final snapshot = await _db
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .where('password', isEqualTo: password)
//         .get();

//     if (snapshot.docs.isEmpty) return null;
//     final doc = snapshot.docs.first;
//     return User.fromMap(doc.data());
//   }

//   // تسجيل مستخدم جديد
//   static Future<User?> registerUser(String email, String fullName, String password) async {
//     final existing = await _db.collection('users').where('email', isEqualTo: email).get();
//     if (existing.docs.isNotEmpty) return null;

//     final docRef = await _db.collection('users').add({
//       'email': email,
//       'fullName': fullName,
//       'password': password,
//     });

//     final newUserDoc = await docRef.get();
//     return User.fromMap(newUserDoc.data()!);
//   }

//   // جلب مستخدم حسب الـ uid (doc id)
//   static Future<User?> getUser(String userId) async {
//     final doc = await _db.collection('users').doc(userId).get();
//     if (!doc.exists) return null;
//     return User.fromMap(doc.data()!);
//   }

//   // ===== Movies =====

//   // جلب كل الأفلام
//   static Future<List<Movie>> getMovies() async {
//     final snapshot = await _db.collection('movies').get();
//     return snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList();
//   }

//   // ===== Bookings =====

//   // جلب الحجوزات لفيلم معين و timeSlot معين
//   static Future<List<Booking>> getBookings(String movieId, String timeSlot) async {
//     final snapshot = await _db
//         .collection('bookings')
//         .where('movieId', isEqualTo: movieId)
//         .where('timeSlot', isEqualTo: timeSlot)
//         .get();

//     return snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList();
//   }

//   // إضافة حجز جديد
//   static Future<void> createBooking(Booking booking) async {
//     await _db.collection('bookings').add(booking.toMap());
//   }
// }

//واحد تانى بيقول  اصح
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user.dart';
// import '../models/movie.dart';
// import '../models/booking.dart';

// class AppState {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // ===== Users =====
//   static Future<User?> loginUser(String email, String password) async {
//     final snapshot = await _db
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .where('password', isEqualTo: password)
//         .get();

//     if (snapshot.docs.isEmpty) return null;
//     final doc = snapshot.docs.first;
//     return User.fromMap({
//       ...doc.data(),
//       'id': doc.id, // إضافة الـ docId
//     });
//   }

//   static Future<User?> registerUser(String email, String fullName, String password) async {
//     final existing = await _db.collection('users').where('email', isEqualTo: email).get();
//     if (existing.docs.isNotEmpty) return null;

//     final docRef = await _db.collection('users').add({
//       'email': email,
//       'fullName': fullName,
//       'password': password,
//     });

//     final newUserDoc = await docRef.get();
//     return User.fromMap({
//       ...newUserDoc.data()!,
//       'id': newUserDoc.id,
//     });
//   }

//   static Future<User?> getUser(String userId) async {
//     final doc = await _db.collection('users').doc(userId).get();
//     if (!doc.exists) return null;
//     return User.fromMap({
//       ...doc.data()!,
//       'id': doc.id,
//     });
//   }

//   // ===== Movies =====
//   static Future<List<Movie>> getMovies() async {
//     final snapshot = await _db.collection('movies').get();
//     return snapshot.docs.map((doc) => Movie.fromMap({
//       ...doc.data(),
//       'id': doc.id, // docId أو رقم
//     })).toList();
//   }

//   // ===== Bookings =====
//   static Future<List<Booking>> getBookings(String movieId, String timeSlot) async {
//     final snapshot = await _db
//         .collection('bookings')
//         .where('movieId', isEqualTo: movieId)
//         .where('timeSlot', isEqualTo: timeSlot)
//         .get();

//     return snapshot.docs.map((doc) => Booking.fromMap({
//       ...doc.data(),
//       'id': doc.id,
//     })).toList();
//   }

//   static Future<Booking?> createBooking(Booking booking) async {
//     final docRef = await _db.collection('bookings').add(booking.toMap());
//     final newBookingDoc = await docRef.get();
//     return Booking.fromMap({
//       ...newBookingDoc.data()!,
//       'id': newBookingDoc.id,
//     });
//   }
// }
>>>>>>> f099a548568129d8536f635149133ad46a1f80fe
