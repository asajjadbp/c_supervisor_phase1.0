import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_capture_photos_list_model.dart';
import '../../repositories/visits_categories/visit_capture_photos_repo.dart';

class VisitCapturePhotosUC {
  VisitCapturePhotosRepo visitCapturePhotosRepo;
  VisitCapturePhotosUC(this.visitCapturePhotosRepo);
  Future<BaseResponse<VisitCapturePhotosListModel?>> getVisitCapturePhotos(
      int visitID, int categoryID) {
    return visitCapturePhotosRepo.getVisitCapturePhotos(
      visitID: visitID,
      categoryID: categoryID,
    );
  }
}
