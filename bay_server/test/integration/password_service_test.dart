import 'package:test/test.dart';
import 'package:bay_server/src/services/password_service.dart';

void main() {
  group('PasswordService', () {
    group('Password Validation', () {
      test('valid password passes validation', () {
        final result = PasswordService.validatePassword('TestPass123!');

        expect(result.isValid, isTrue);
        expect(result.errors, isEmpty);
      });

      test('short password fails validation', () {
        final result = PasswordService.validatePassword('short');

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Password must be at least 8 characters'));
      });

      test('password without uppercase fails validation', () {
        final result = PasswordService.validatePassword('testpass123!');

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Password must contain at least one uppercase letter'));
      });

      test('password without lowercase fails validation', () {
        final result = PasswordService.validatePassword('TESTPASS123!');

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Password must contain at least one lowercase letter'));
      });

      test('password without number fails validation', () {
        final result = PasswordService.validatePassword('TestPassword!');

        expect(result.isValid, isFalse);
        expect(result.errors, contains('Password must contain at least one digit'));
      });
    });

    group('Password Hashing', () {
      test('hashing creates valid hash', () async {
        final password = 'TestPass123!';
        final hash = await PasswordService.hashPassword(password);

        expect(hash, isNotNull);
        expect(hash.length, greaterThan(20));
      });

      test('same password creates different hashes', () async {
        final password = 'TestPass123!';
        final hash1 = await PasswordService.hashPassword(password);
        final hash2 = await PasswordService.hashPassword(password);

        expect(hash1, isNot(equals(hash2)));
      });

      test('verify password with correct password returns true', () async {
        final password = 'TestPass123!';
        final hash = await PasswordService.hashPassword(password);

        final isValid = await PasswordService.verifyPassword(password, hash);
        expect(isValid, isTrue);
      });

      test('verify password with wrong password returns false', () async {
        final password = 'TestPass123!';
        final wrongPassword = 'WrongPass123!';
        final hash = await PasswordService.hashPassword(password);

        final isValid = await PasswordService.verifyPassword(wrongPassword, hash);
        expect(isValid, isFalse);
      });
    });
  });
}
