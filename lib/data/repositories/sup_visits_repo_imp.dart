import 'dart:io';

import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/image_response_model.dart';
import 'package:c_supervisor/data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import 'package:c_supervisor/data/models/sup_visits/modules/photos/jp_photos_list_model.dart';
import 'package:c_supervisor/data/models/sup_visits/sup_visits_list_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/add_photo_to_json_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/checklist_to_json_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/start_visit_to_json_model.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/sup_visits_to_json.dart';
import 'package:c_supervisor/data/models/sup_visits/visit_count/sup_visits_list_count_model.dart';

import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../domain/repositories/sup_visits.dart';
import '../data_sources/remote/application_remote_ds.dart';

class SupVisitsRepoImp implements SupVisitsRepo {
  ApplicationRemoteDS applicationRemoteDS;
  SupVisitsRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<SupVisitsCountListModel?>> getSupVisitsCount({
    required int userId,
  }) async {
    return applicationRemoteDS.getSupVisitsCount(userId: userId);
  }

  @override
  Future<BaseResponse<SupVisitsListModel?>> getSupVisits({
    required SupVisitsToJsonModel model,
  }) async {
    return applicationRemoteDS.getSupVisits(
      model: model,
    );
  }

  @override
  Future<BaseResponse<ImageResponseModel?>> uploadImageJP(
    List<File> files,
  ) async {
    return applicationRemoteDS.uploadImageJP(
      files,
    );
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> startVisitJP(
    StartVisitToJsonModel model,
  ) async {
    return applicationRemoteDS.startVisitJP(model);
  }

  @override
  Future<BaseResponse<JPPhotosListModel?>> getJPPhotos(
      {required int visitId}) async {
    return applicationRemoteDS.getJPPhotos(visitId: visitId);
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> addPhoto({
    required AddPhotoToJsonModel model,
  }) async {
    return applicationRemoteDS.addPhoto(model);
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> removePhoto({
    required int photoId,
  }) async {
    return applicationRemoteDS.removePhoto(photoId);
  }

  @override
  Future<BaseResponse<CheckListListModel?>> getCheckList({
    required int visitId,
  }) async {
    return applicationRemoteDS.getCheckList(visitId: visitId);
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> updateVisitCheckList({
    required UpdateCheckListToJsonModel model,
  }) async {
    return applicationRemoteDS.updateVisitCheckList(model);
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> finishVisit({
    required int visitId,
    required String comment,
  }) async {
    return applicationRemoteDS.finishVisit(
      visitId: visitId,
      comment: comment,
    );
  }
}
