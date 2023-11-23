import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../data/models/visits_categories/visit_capture_photos_list_model.dart';
import '../../../../../domain/use_cases/visits_categories/visit_capture_photos_uc.dart';

class VisitCapturePhotosCubit extends BaseAppCubit<VisitCapturePhotosListModel> {
  final VisitCapturePhotosUC visitCapturePhotosUC;
  final int visitID;
  final int categoryID;
  VisitCapturePhotosCubit({
    required this.visitCapturePhotosUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<VisitCapturePhotosListModel> loadItemsAtPage() async {
    final BaseResponse<VisitCapturePhotosListModel?> result;

    result = await networkCall(
      () => visitCapturePhotosUC.getVisitCapturePhotos(visitID, categoryID),
    );

    return result.data ?? VisitCapturePhotosListModel();
  }
}
