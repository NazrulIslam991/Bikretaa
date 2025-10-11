import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? body;
  final String? errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.body,
    this.errorMessage,
  });
}

class NetworkCaller {
  static const String _defaultErrorMessage = "Something went wrong!";
  static const String brevoApiKey =
      "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";

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
    bool isBrevoRequest = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      final headers = <String, String>{
        "accept": "application/json",
        "content-type": "application/json",
      };

      if (isBrevoRequest) {
        headers["api-key"] = brevoApiKey;
      }

      _logRequest(url, body, headers);

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      _logResponse(url, response);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      } else {
        String errorMsg = _defaultErrorMessage;
        try {
          final decodedJson = jsonDecode(response.body);
          if (decodedJson['message'] != null) {
            errorMsg = decodedJson['message'];
          } else if (decodedJson['data'] != null) {
            errorMsg = decodedJson['data'];
          }
        } catch (_) {}
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: errorMsg,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ) {
    debugPrint(
      '===== Request Start =====\nUrl: $url\nHeaders: $headers\nBody: $body\n===== Request End =====',
    );
  }

  static void _logResponse(String url, http.Response response) {
    debugPrint(
      '===== Response Start =====\nUrl: $url\nStatus: ${response.statusCode}\nBody: ${response.body}\n===== Response End =====',
    );
  }
}
