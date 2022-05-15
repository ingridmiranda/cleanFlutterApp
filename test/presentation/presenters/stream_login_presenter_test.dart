import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class Validation {
  String? validate({String field, String value});
}

class LoginState {
  String? emailError;
}

class StreamLoginPresenter {
  final Validation? validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError ?? "");

  StreamLoginPresenter({this.validation});

  void validateEmail(String email) {
    _state.emailError = validation?.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  StreamLoginPresenter? sut;
  ValidationSpy? validation;
  String? email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test(
    'Should call Validation with correct email',
    () {
      sut?.validateEmail(email ?? "");

      verify(() => validation?.validate(field: 'email', value: email ?? ""))
          .called(1);
    },
  );

  test(
    'Should emit email error if validation fails',
    () {
      when(() => validation?.validate(
          field: any(named: 'field'),
          value: any(named: 'value'))).thenReturn('error');

      expectLater(sut?.emailErrorStream, emits('error'));

      sut?.validateEmail(email ?? "");
    },
  );
}