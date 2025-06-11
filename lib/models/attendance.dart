import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String id;
  final String userId;
  final GeoPoint location;
  final DateTime timestamp;
  final String type; // 'check-in' or 'check-out'

  Attendance({
    required this.id,
    required this.userId,
    required this.location,
    required this.timestamp,
    required this.type,
  });

  factory Attendance.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Attendance(
      id: doc.id,
      userId: data['userId'],
      location: data['location'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      type: data['type'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'location': location,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type,
    };
  }
}
