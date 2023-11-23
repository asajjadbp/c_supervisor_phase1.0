import 'package:c_supervisor/domain/repositories/visits_categories/visit_capture_photos_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data_sources/remote/application_remote_ds.dart';
import '../../models/visits_categories/visit_capture_photos_list_model.dart';

class VisitCapturePhotosRepoImp implements VisitCapturePhotosRepo {
  ApplicationRemoteDS applicationRemoteDS;
  VisitCapturePhotosRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<VisitCapturePhotosListModel?>> getVisitCapturePhotos(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getVisitCapturePhotos(
      visitID,
      categoryID,
    );
  }
}
