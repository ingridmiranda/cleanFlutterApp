import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:cleanflutterapp/data/http/http_client.dart';

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
    } catch (e) {
      debugPrint(e.toString());
    }
    final requestResponse = (response != null && response.body.isNotEmpty)
        ? jsonDecode(response.body)
        : null;
    return requestResponse;
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
    registerFallbackValue(Uri.parse(url));
  });

  group('post', () {
    test('Should call post with correct values', () async {
      when(() => client.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      when(() => client.post(any(),
              headers: any(named: 'headers'), body: any(named: 'body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url), headers: any(named: 'headers')));
    });

    test('Should return data if post returns 200', () async {
      when(() => client.post(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      when(() => client.post(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
