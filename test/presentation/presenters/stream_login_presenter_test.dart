import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class Validation {
  String? validate({String field, String value});
}

class StreamLoginPresenter {
  final Validation? validation;
  StreamLoginPresenter({this.validation});
  void validateEmail(String email) {
    validation?.validate(field: 'email', value: email);
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
}
