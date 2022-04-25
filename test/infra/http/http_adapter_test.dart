import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(
      {required String url, required String method, Map? body}) async {
    try {
      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json'
      };
      await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('Should call post with correct values', () async {
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });
  });
}
