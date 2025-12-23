import 'package:test/test.dart';
import 'package:bay_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given AuthEndpoint', (sessionBuilder, endpoints) {
    group('User Registration', () {
      test('when registering with valid data then user is created', () async {
        final result = await endpoints.auth.register(
          sessionBuilder,
          username: 'testuser',
          password: 'TestPass123!',
          acceptedTerms: true,
        );

        expect(result, isNotNull);
        expect(result?.username, 'testuser');
        expect(result?.role, UserRole.user);
      });

      test('when registering with short password then returns null', () async {
        final result = await endpoints.auth.register(
          sessionBuilder,
          username: 'testuser2',
          password: 'short',
          acceptedTerms: true,
        );

        expect(result, isNull);
      });

      test('when registering without accepting terms then returns null',
          () async {
        final result = await endpoints.auth.register(
          sessionBuilder,
          username: 'testuser3',
          password: 'TestPass123!',
          acceptedTerms: false,
        );

        expect(result, isNull);
      });

      test('when registering duplicate username then returns null', () async {
        // Create first user
        await endpoints.auth.register(
          sessionBuilder,
          username: 'duplicate',
          password: 'TestPass123!',
          acceptedTerms: true,
        );

        // Try to create duplicate
        final result = await endpoints.auth.register(
          sessionBuilder,
          username: 'duplicate',
          password: 'TestPass123!',
          acceptedTerms: true,
        );

        expect(result, isNull);
      });
    });

    group('User Login', () {
      setUp(() async {
        // Create test user for login tests
        await endpoints.auth.register(
          sessionBuilder,
          username: 'loginuser',
          password: 'TestPass123!',
          acceptedTerms: true,
        );
      });

      test('when logging in with correct credentials then returns session',
          () async {
        final session = await endpoints.auth.login(
          sessionBuilder,
          username: 'loginuser',
          password: 'TestPass123!',
          rememberMe: false,
        );

        expect(session, isNotNull);
        expect(session?.user?.username, 'loginuser');
      });

      test('when logging in with wrong password then returns null', () async {
        final session = await endpoints.auth.login(
          sessionBuilder,
          username: 'loginuser',
          password: 'WrongPassword',
          rememberMe: false,
        );

        expect(session, isNull);
      });

      test('when logging in with non-existent user then returns null',
          () async {
        final session = await endpoints.auth.login(
          sessionBuilder,
          username: 'nonexistent',
          password: 'TestPass123!',
          rememberMe: false,
        );

        expect(session, isNull);
      });
    });
  });
}
