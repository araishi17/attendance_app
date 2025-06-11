import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance.dart';
import '../models/report.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addAttendance(
    String userId,
    double latitude,
    double longitude,
    String type,
  ) async {
    await _db.collection('attendances').add({
      'userId': userId,
      'location': GeoPoint(latitude, longitude),
      'timestamp': Timestamp.now(),
      'type': type,
    });
  }

  Stream<QuerySnapshot> getAttendanceStream() {
    return _db.collection('attendances').snapshots();
  }

  Future<void> addReport(
    String userId,
    String task,
    int duration,
    String notes,
  ) async {
    await _db.collection('reports').add({
      'userId': userId,
      'task': task,
      'duration': duration,
      'notes': notes,
      'date': Timestamp.now(),
    });
  }
}
