import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getAttendanceStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada riwayat'));
          }
          final attendances = snapshot.data!.docs;
          return ListView.builder(
            itemCount: attendances.length,
            itemBuilder: (context, index) {
              final attendance = attendances[index].data() as Map<String, dynamic>;
              final timestamp = (attendance['timestamp'] as Timestamp).toDate();
              return ListTile(
                title: Text(attendance['type']),
                subtitle: Text(timestamp.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
