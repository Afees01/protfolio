import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactService {
  static Future<void> sendEmail({
    required String name,
    required String email,
    required String phone,
    required String message,
    required String categories,
  }) async {
    const serviceId = 'service_4duqbd4';
    const mainTemplateId = 'template_qa3sh72';
    const autoReplyTemplateId = 'template_iasmrb7';
    const publicKey = 'APnQTeJNjZ11DYx1J';

    final url = Uri.parse(
      'https://api.emailjs.com/api/v1.0/email/send',
    );

    final params = {
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'categories': categories,
    };

    try {
      // SEND TO YOU
      final mainResponse = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': mainTemplateId,
          'user_id': publicKey,
          'template_params': params,
        }),
      );

      // AUTO REPLY TO CLIENT
      final autoReplyResponse = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': autoReplyTemplateId,
          'user_id': publicKey,
          'template_params': params,
        }),
      );

      if (mainResponse.statusCode == 200 &&
          autoReplyResponse.statusCode == 200) {
        debugPrint('SUCCESS');
      } else {
        debugPrint(mainResponse.body);
        debugPrint(autoReplyResponse.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
