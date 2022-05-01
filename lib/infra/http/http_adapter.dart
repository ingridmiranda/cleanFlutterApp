import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map?> request(
      {required String url, required String method, Map? body}) async {
    Response? response;
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return _handleResponse(response);
  }

  Map? _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else if (response.statusCode == 204) {
      return null;
    } else {
      throw HttpError.badRequest;
    }
  }
}
