import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../../services/payment_service.dart';

/// Web-Route für PayPal IPN (Instant Payment Notification).
/// PayPal ruft diese URL auf, wenn eine Zahlung eingeht.
class RoutePayPalIpn extends WidgetRoute {
  @override
  Future<AbstractWidget> build(Session session, HttpRequest request) async {
    // Lese den POST-Body
    final body = await utf8.decoder.bind(request).join();

    // Parse die IPN-Daten
    final ipnData = <String, String>{};
    for (final pair in body.split('&')) {
      final parts = pair.split('=');
      if (parts.length == 2) {
        final key = Uri.decodeComponent(parts[0]);
        final value = Uri.decodeComponent(parts[1]);
        ipnData[key] = value;
      }
    }

    session.log('PayPal IPN empfangen: ${ipnData.length} Parameter');

    // Verifiziere die IPN-Nachricht
    // TODO: sandbox aus Konfiguration lesen
    final isValid = await PaymentService.verifyPayPalIpn(
      ipnData,
      sandbox: true,
    );

    if (!isValid) {
      session.log('PayPal IPN: Verifizierung fehlgeschlagen');
      return WidgetText('INVALID');
    }

    // Verarbeite die Zahlung
    final success = await PaymentService.processPayPalPayment(session, ipnData);

    if (success) {
      session.log('PayPal IPN: Zahlung erfolgreich verarbeitet');
      return WidgetText('OK');
    } else {
      session.log('PayPal IPN: Zahlung konnte nicht verarbeitet werden');
      return WidgetText('ERROR');
    }
  }
}

/// Einfaches Text-Widget für die Antwort.
class WidgetText extends AbstractWidget {
  final String text;

  WidgetText(this.text);

  @override
  Future<String> generateHtml(
    Session session,
    HttpRequest request,
  ) async {
    return text;
  }
}
