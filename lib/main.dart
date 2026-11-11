import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/attendance_camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase (make sure google-services.json is configured)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init note: $e");
  }
  runApp(const VentureTechApp());
}

class VentureTechApp extends StatelessWidget {
  const VentureTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VentureTech Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
        useMaterial3: true,
      ),
      home: const AttendanceCameraScreen(),
    );
  }
}
