import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:cleanflutterapp/presentation/presenters/presenters.dart';
import 'package:cleanflutterapp/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  StreamLoginPresenter? sut;
  ValidationSpy? validation;
  String? email;

  When mockValidationCall(String? field) => when(() => validation?.validate(
      field: field ?? any(named: 'field'), value: any(named: 'value')));

  void mockValidation(String? field, String? value) {
    mockValidationCall(field ?? "").thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation(null, null);
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
      mockValidation("email", 'error');

      sut?.emailErrorStream
          .listen(expectAsync1((error) => expect(error, 'error')));

      expectLater(sut?.emailErrorStream, emitsInOrder(['error']));

      sut?.validateEmail(email ?? "");
      sut?.validateEmail(email ?? "");
    },
  );
}
