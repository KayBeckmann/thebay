import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import 'package:bay_server/src/web/routes/root.dart';
import 'package:bay_server/src/services/password_service.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();

  // Create admin account on first startup
  await _createAdminAccount(pod);
}

/// Creates the admin account from environment variables if it doesn't exist.
Future<void> _createAdminAccount(Serverpod pod) async {
  final adminUsername = Platform.environment['ADMIN_USERNAME'];
  final adminPassword = Platform.environment['ADMIN_PASSWORD'];

  if (adminUsername == null || adminPassword == null) {
    print('Warning: ADMIN_USERNAME or ADMIN_PASSWORD not set in environment');
    return;
  }

  final session = await pod.createSession();

  try {
    // Check if admin already exists
    final existingAdmin = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(adminUsername.toLowerCase()),
    );

    if (existingAdmin != null) {
      print('Admin account already exists');
      return;
    }

    // Create admin account
    final passwordHash = await PasswordService.hashPassword(adminPassword);
    final admin = User(
      username: adminUsername.toLowerCase(),
      passwordHash: passwordHash,
      role: UserRole.admin,
      createdAt: DateTime.now().toUtc(),
      acceptedTerms: true,
    );

    await User.db.insertRow(session, admin);
    print('Admin account created successfully');
  } catch (e) {
    print('Error creating admin account: $e');
  } finally {
    await session.close();
  }
}

