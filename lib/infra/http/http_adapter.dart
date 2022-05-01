import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/http/http.dart';
import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map?> request(
      {required String url, required String method, Map? body}) async {
    Response? response;
    try {
      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json'
      };
      final jsonBody = body != null ? jsonEncode(body) : null;
      response =
          await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      return _handleResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Map? _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      return null;
    }
  }
}
