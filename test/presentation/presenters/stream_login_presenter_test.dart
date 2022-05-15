import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

abstract class Validation {
  String? validate({String field, String value});
}

class StreamLoginPresenter {
  final Validation validation;
  StreamLoginPresenter({required this.validation});
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  test(
    'Should call Validation with correct email',
    () {
      final validation = ValidationSpy();
      final sut = StreamLoginPresenter(validation: validation);
      final email = faker.internet.email();

      sut.validateEmail(email);

      verify(() => validation.validate(field: 'email', value: email)).called(1);
    },
  );
}
