import '../../domain/entities/account_entity.dart';

import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map? json) {
    if (json != null && !json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json != null ? json['accessToken'] : "");
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
