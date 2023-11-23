import 'package:c_supervisor/data/models/visits_categories/visit_capture_photos_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

abstract class VisitCapturePhotosRepo {
  Future<BaseResponse<VisitCapturePhotosListModel?>> getVisitCapturePhotos({
    required int visitID,
    required int categoryID,
  });
}
