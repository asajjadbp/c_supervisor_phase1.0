import 'dart:io';

import 'package:c_supervisor/data/models/update_category/update_availability_model.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/data/models/update_category/update_stock_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/empty_model.dart';

import '../../../data/models/image_response_model.dart';
import '../../../data/models/planogram_reason/planogram_reasons_list_model.dart';
import '../../../data/models/update_category/update_freshness_model.dart';
import '../../../data/models/update_category/update_planogram_model.dart';
import '../../../data/models/update_category/update_price_model.dart';
import '../../repositories/update_category/update_category_repo.dart';

class UpdateCategoryUC {
  UpdateCategoryRepo updateCategoryRepo;
  UpdateCategoryUC(this.updateCategoryRepo);

  /// Availability
  Future<BaseResponse<EmptyModel?>> updateAvailability(
    UpdateAvailabilityModel model,
  ) {
    return updateCategoryRepo.updateAvailability(model);
  }

  Future<BaseResponse<ConfirmSuccessResponseModel?>> confirmUpdateAvailability({
    required int id,
    required int userId,
  }) {
    return updateCategoryRepo.confirmUpdateAvailability(
      id: id,
      userId: userId,
    );
  }

  Future<BaseResponse<EmptyModel?>> cancelUpdateAvailability({
    required int id,
    required int userId,
  }) {
    return updateCategoryRepo.cancelUpdateAvailability(
      id: id,
      userId: userId,
    );
  }

  ///
  Future<BaseResponse<EmptyModel?>> updateRtv(UpdateRtvModel model) {
    return updateCategoryRepo.updateRtv(model);
  }

  Future<BaseResponse<EmptyModel?>> updatePriceCheck(UpdatePriceModel model) {
    return updateCategoryRepo.updatePriceCheck(model);
  }

  Future<BaseResponse<EmptyModel?>> updateFreshness(
      UpdateFreshnessModel model) {
    return updateCategoryRepo.updateFreshness(model);
  }

  Future<BaseResponse<EmptyModel?>> updateVisitStock(UpdateStockModel model) {
    return updateCategoryRepo.updateVisitStock(model);
  }

  Future<BaseResponse<EmptyModel?>> updatePlanoGram(
      UpdatePlanoGramModel model) {
    return updateCategoryRepo.updatePlanoGram(model);
  }

  Future<BaseResponse<EmptyModel?>> updateSOS(UpdateSOSModel model) {
    return updateCategoryRepo.updateSOS(model);
  }

  Future<BaseResponse<PlanoGramReasonListModel?>> getPlanoGramReasonsList() {
    return updateCategoryRepo.getPlanoGramReasonsList();
  }

  /// upload images on sos
  Future<BaseResponse<ImageResponseModel?>> uploadImagesSOS(
      List<File> files) async {
    return await updateCategoryRepo.uploadImagesSOS(files);
  }
}
