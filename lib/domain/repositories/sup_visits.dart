import 'package:c_supervisor/data/models/sup_visits/modules/photos/jp_photos_list_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/add_photo_to_json_model.dart';

import '../../data/models/empty_model.dart';
import '../../data/models/image_response_model.dart';
import '../../data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import '../../data/models/sup_visits/sup_visits_list_model.dart';
import '../../data/models/sup_visits/to_json/checklist_to_json_model.dart';
import '../../data/models/sup_visits/to_json/start_visit_to_json_model.dart';
import '../../data/models/sup_visits/to_json/sup_visits_to_json.dart';
import '../../data/models/sup_visits/visit_count/sup_visits_list_count_model.dart';
import '../../ui/pages/index.dart';

abstract class SupVisitsRepo {
  Future<BaseResponse<SupVisitsCountListModel?>> getSupVisitsCount({
    required int userId,
  });

  Future<BaseResponse<SupVisitsListModel?>> getSupVisits({
    required SupVisitsToJsonModel model,
  });
  Future<BaseResponse<ImageResponseModel?>> uploadImageJP(
    List<File> files,
  );
  Future<BaseResponse<SuccessResponseModel?>> startVisitJP(
    StartVisitToJsonModel model,
  );

  /// photos module
  Future<BaseResponse<JPPhotosListModel?>> getJPPhotos({
    required int visitId,
  });
  Future<BaseResponse<SuccessResponseModel?>> addPhoto({
    required AddPhotoToJsonModel model,
  });
  Future<BaseResponse<SuccessResponseModel?>> removePhoto({
    required int photoId,
  });

  /// check list module
  Future<BaseResponse<CheckListListModel?>> getCheckList({
    required int visitId,
  });
  Future<BaseResponse<SuccessResponseModel?>> updateVisitCheckList({
    required UpdateCheckListToJsonModel model,
  });

  /// finish visit
  Future<BaseResponse<SuccessResponseModel?>> finishVisit({
    required int visitId,
    required String comment,
  });
}
