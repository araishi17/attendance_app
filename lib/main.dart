import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Attendance App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Consumer<AuthService>(
          builder: (context, auth, _) {
            return auth.isAuthenticated ? HomeScreen() : LoginScreen();
          },
        ),
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
