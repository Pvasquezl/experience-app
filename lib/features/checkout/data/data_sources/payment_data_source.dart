import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentDataSource {
  PaymentDataSource({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl =
      'https://processpayment-sfdkfoab2q-uc.a.run.app';

  final http.Client _client;

  Future<Map<String, dynamic>> processPayment({
    required double amount,
    required String cardNumber,
  }) async {
    final response = await _client.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'amount': amount,
        'cardNumber': cardNumber,
        'currency': 'USD',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'No se pudo procesar el pago. Código: ${response.statusCode}',
      );
    }

    final body = jsonDecode(response.body);
    if (body is Map<String, dynamic>) {
      return body;
    }

    if (body is Map) {
      return Map<String, dynamic>.from(body);
    }

    return {};
  }
}
