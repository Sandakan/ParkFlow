import 'package:flutter_test/flutter_test.dart';
import 'package:parkflow/models/auth/user_model.dart';

void main() {
  group('UserModel', () {
    test('should parse from JSON correctly', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'name': 'Test User',
        'role': 'user',
        'vehicles': [],
        'paymentMethods': [],
      };

      final user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.role, 'user');
      expect(user.vehicles, isEmpty);
    });

    test('should convert to JSON correctly', () {
      const user = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
        role: 'user',
      );

      final json = user.toJson();

      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'Test User');
      expect(json['role'], 'user');
    });
  });
}
