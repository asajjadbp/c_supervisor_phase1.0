import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class AuthRepoImp implements AuthRepo {
  final ApplicationRemoteDS applicationRemoteDS;
  final AppSecureStorageClient appSecureStorageClient;
  final AppSharedPrefsClient appSharedPrefsClient;

  AuthRepoImp({
    required this.applicationRemoteDS,
    required this.appSecureStorageClient,
    required this.appSharedPrefsClient,
  });

  @override
  Future<BaseResponse<UserDataModel?>> login(
      {required LoginModel loginModel}) async {
    final BaseResponse<UserDataModel?> response =
        await applicationRemoteDS.login(loginModel: loginModel);
    if (!response.hasError) {
      final data = response.data!;

      appSharedPrefsClient.saveCurrentUserInfo(data.userData?.userInfo);
      await appSecureStorageClient.updateUserDataModel(data);

      /// TODO : validate check in status before fetching
      try {
        final BaseResponse<CommonDataListModel?> baseCheckInResponse =
            await applicationRemoteDS.fetchCheckInList(langId: 1);
        appSharedPrefsClient
            .saveCurrentUserCheckInList(baseCheckInResponse.data);
      } catch (_) {}
    }
    return response;
  }

  @override
  Future<BaseResponse<LastUserCheckInStatusModel?>> validateSupervisorCheckIN({
    required int userId,
  }) {
    return applicationRemoteDS.validateSupervisorCheckIN(userId: userId);
  }
}
