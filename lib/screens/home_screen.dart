import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final position = await Geolocator.getCurrentPosition();
                  await firestoreService.addAttendance(
                    authService.userId!,
                    position.latitude,
                    position.longitude,
                    'check-in',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Check-in berhasil')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal check-in: $e')),
                  );
                }
              },
              child: const Text('Check In'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final position = await Geolocator.getCurrentPosition();
                  await firestoreService.addAttendance(
                    authService.userId!,
                    position.latitude,
                    position.longitude,
                    'check-out',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Check-out berhasil')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal check-out: $e')),
                  );
                }
              },
              child: const Text('Check Out'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report');
              },
              child: const Text('Buat Laporan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              child: const Text('Lihat Riwayat'),
            ),
          ],
        ),
      ),
    );
  }
}
