import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String userId;
  final String task;
  final int duration;
  final String notes;
  final DateTime date;

  Report({
    required this.id,
    required this.userId,
    required this.task,
    required this.duration,
    required this.notes,
    required this.date,
  });

  factory Report.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Report(
      id: doc.id,
      userId: data['userId'],
      task: data['task'],
      duration: data['duration'],
      notes: data['notes'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'task': task,
      'duration': duration,
      'notes': notes,
      'date': Timestamp.fromDate(date),
    };
  }
}
