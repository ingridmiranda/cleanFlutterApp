abstract class LoginPresenter {
  Stream<String?>? get emailErrorStream;
  Stream<String?>? get passwordErrorStream;
  Stream<bool?>? get isFormValidStream;

  void validateEmail(String value);
  void validatePassword(String value);
  void auth();
}
