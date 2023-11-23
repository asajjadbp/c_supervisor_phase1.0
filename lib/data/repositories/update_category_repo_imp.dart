import 'dart:io';

import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/planogram_reason/planogram_reasons_list_model.dart';
import 'package:c_supervisor/data/models/update_category/update_availability_model.dart';
import 'package:c_supervisor/data/models/update_category/update_freshness_model.dart';
import 'package:c_supervisor/data/models/update_category/update_planogram_model.dart';
import 'package:c_supervisor/data/models/update_category/update_price_model.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/data/models/update_category/update_stock_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../domain/repositories/update_category/update_category_repo.dart';
import '../data_sources/remote/application_remote_ds.dart';
import '../models/image_response_model.dart';

class UpdateCategoryRepoImp implements UpdateCategoryRepo {
  ApplicationRemoteDS applicationRemoteDS;
  UpdateCategoryRepoImp(this.applicationRemoteDS);

  /// Availability
  @override
  Future<BaseResponse<EmptyModel?>> updateAvailability(
    UpdateAvailabilityModel model,
  ) async {
    return applicationRemoteDS.updateAvailability(model);
  }

  @override
  Future<BaseResponse<ConfirmSuccessResponseModel?>> confirmUpdateAvailability({
    required int id,
    required int userId,
  }) async {
    return applicationRemoteDS.confirmUpdateAvailability(
      id: id,
      userId: userId,
    );
  }

  @override
  Future<BaseResponse<EmptyModel?>> cancelUpdateAvailability({
    required int id,
    required int userId,
  }) {
    return applicationRemoteDS.cancelUpdateAvailability(
      id: id,
      userId: userId,
    );
  }

  ///

  @override
  Future<BaseResponse<EmptyModel?>> updateRtv(UpdateRtvModel model) async {
    return applicationRemoteDS.updateRtv(model);
  }

  @override
  Future<BaseResponse<EmptyModel?>> updatePriceCheck(
      UpdatePriceModel model) async {
    return applicationRemoteDS.updatePriceCheck(model);
  }

  @override
  Future<BaseResponse<EmptyModel?>> updateFreshness(
      UpdateFreshnessModel model) async {
    return applicationRemoteDS.updateFreshness(model);
  }

  @override
  Future<BaseResponse<EmptyModel?>> updateVisitStock(
      UpdateStockModel model) async {
    return applicationRemoteDS.updateVisitStock(model);
  }

  @override
  Future<BaseResponse<EmptyModel?>> updatePlanoGram(
      UpdatePlanoGramModel model) async {
    return applicationRemoteDS.updatePlanoGram(model);
  }

  @override
  Future<BaseResponse<PlanoGramReasonListModel?>>
      getPlanoGramReasonsList() async {
    return applicationRemoteDS.getPlanoGramReasonsList();
  }

  @override
  Future<BaseResponse<EmptyModel?>> updateSOS(UpdateSOSModel model) async {
    return applicationRemoteDS.updateSOS(model);
  }

  @override
  Future<BaseResponse<ImageResponseModel?>> uploadImagesSOS(
      List<File> files) async {
    return applicationRemoteDS.uploadImagesSOS(files);
  }
}
