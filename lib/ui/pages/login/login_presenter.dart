abstract class LoginPresenter {
  Stream<String?>? get emailErrorStream;
  Stream<String?>? get passwordErrorStream;

  void validateEmail(String value);
  void validatePassword(String value);
}
