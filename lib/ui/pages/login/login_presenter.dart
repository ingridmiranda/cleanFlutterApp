abstract class LoginPresenter {
  Stream<String> get emailErrorStream;

  void validateEmail(String value);
  void validatePassword(String value);
}
