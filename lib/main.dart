// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'customer/screens/login_screen.dart';
// import 'role_selector.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print('✅ Firebase initialized successfully');
//   } catch (e) {
//     print('❌ Firebase initialization error: $e');
//     // Continue anyway - app will show error if needed
//   }
//   runApp(const CinemaBookingApp());
// }

// class CinemaBookingApp extends StatelessWidget {
//   const CinemaBookingApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cinema Booking',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
//       home: const RoleSelector(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'role_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RoleSelector(),
    );
  }
}
