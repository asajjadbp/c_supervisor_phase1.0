import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/add_photo_to_json_model.dart';

import '../../data/models/image_response_model.dart';
import '../../data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import '../../data/models/sup_visits/modules/photos/jp_photos_list_model.dart';
import '../../data/models/sup_visits/sup_visits_list_model.dart';
import '../../data/models/sup_visits/to_json/checklist_to_json_model.dart';
import '../../data/models/sup_visits/to_json/start_visit_to_json_model.dart';
import '../../data/models/sup_visits/to_json/sup_visits_to_json.dart';
import '../../data/models/sup_visits/visit_count/sup_visits_list_count_model.dart';
import '../../ui/pages/clients_sku/index.dart';
import '../repositories/sup_visits.dart';

class SupVisitsUC {
  SupVisitsRepo supVisitsRepo;
  SupVisitsUC(this.supVisitsRepo);
  Future<BaseResponse<SupVisitsCountListModel?>> getSupVisitsCount({
    required int userId,
  }) {
    return supVisitsRepo.getSupVisitsCount(
      userId: userId,
    );
  }

  Future<BaseResponse<SupVisitsListModel?>> getSupVisits({
    required SupVisitsToJsonModel model,
  }) {
    return supVisitsRepo.getSupVisits(
      model: model,
    );
  }

  Future<BaseResponse<ImageResponseModel?>> uploadImageJP(
    List<File> files,
  ) async {
    return await supVisitsRepo.uploadImageJP(files);
  }

  Future<BaseResponse<SuccessResponseModel?>> startVisitJP({
    required StartVisitToJsonModel model,
  }) async {
    return await supVisitsRepo.startVisitJP(model);
  }

  ///  photos module
  Future<BaseResponse<JPPhotosListModel?>> getJPPhotos({
    required int visitId,
  }) {
    return supVisitsRepo.getJPPhotos(
      visitId: visitId,
    );
  }

  Future<BaseResponse<SuccessResponseModel?>> addPhoto({
    required AddPhotoToJsonModel model,
  }) {
    return supVisitsRepo.addPhoto(
      model: model,
    );
  }

  Future<BaseResponse<SuccessResponseModel?>> removePhoto({
    required int photoId,
  }) {
    return supVisitsRepo.removePhoto(
      photoId: photoId,
    );
  }

  /// check list module
  Future<BaseResponse<CheckListListModel?>> getCheckList({
    required int visitId,
  }) {
    return supVisitsRepo.getCheckList(
      visitId: visitId,
    );
  }

  Future<BaseResponse<SuccessResponseModel?>> updateVisitCheckList({
    required UpdateCheckListToJsonModel model,
  }) {
    return supVisitsRepo.updateVisitCheckList(
      model: model,
    );
  }

  /// finish model
  Future<BaseResponse<SuccessResponseModel?>> finishVisit({
    required int visitId,
    required String comment,
  }) {
    return supVisitsRepo.finishVisit(
      visitId: visitId,
      comment: comment,
    );
  }
}
