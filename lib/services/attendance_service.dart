import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> recordAttendance({
    required String rollNo,
    required String studentName,
    required String branch,
    required String course,
    required String type, // 'IN' or 'OUT'
  }) async {
    final now = DateTime.now();
    final isLate = now.hour > 9 || (now.hour == 9 && now.minute > 15);

    await _firestore.collection('attendance_logs').add({
      'roll_no': rollNo,
      'student_name': studentName,
      'branch': branch,
      'course': course,
      'type': type,
      'status': isLate ? 'Late' : 'On-Time',
      'verified_by': 'Face + GPS',
      'timestamp': FieldValue.serverTimestamp(),
      'date': "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}",
    });
  }

  static Future<List<Map<String, dynamic>>> getAllRegisteredStudents() async {
    final snapshot = await _firestore.collection('students').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
