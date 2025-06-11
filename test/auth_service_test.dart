import 'package:flutter_test/flutter_test.dart';
import 'package:attendance_app/services/auth_service.dart';

void main() {
  test('AuthService should initialize unauthenticated', () {
    final authService = AuthService();
    expect(authService.isAuthenticated, false);
  });
}
