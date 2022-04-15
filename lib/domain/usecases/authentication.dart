import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  late final String email;
  late final String password;

  AuthenticationParams({
    required this.email,
    required this.password,
  });
}
