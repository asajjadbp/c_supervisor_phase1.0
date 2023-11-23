import 'package:get_it/get_it.dart';

import '../../data/data_sources/local/app_shared_prefs_client.dart';

/// [UserInfoMixin] contain of some info about user
/// Ex: id,name,..etc
mixin UserInfoMixin {
  ///[getUserId] return user id

  int getUserId() {
    return GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
  }
}
