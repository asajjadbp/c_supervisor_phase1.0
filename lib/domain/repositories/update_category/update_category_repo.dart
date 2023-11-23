import 'dart:io';

import 'package:c_supervisor/data/models/update_category/update_availability_model.dart';
import 'package:c_supervisor/data/models/update_category/update_freshness_model.dart';
import 'package:c_supervisor/data/models/update_category/update_planogram_model.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/data/models/update_category/update_stock_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/empty_model.dart';
import '../../../data/models/image_response_model.dart';
import '../../../data/models/planogram_reason/planogram_reasons_list_model.dart';
import '../../../data/models/update_category/update_price_model.dart';

abstract class UpdateCategoryRepo {
  /// Availability
  Future<BaseResponse<EmptyModel?>> updateAvailability(
    UpdateAvailabilityModel model,
  );
  Future<BaseResponse<ConfirmSuccessResponseModel?>> confirmUpdateAvailability({
    required int id,
    required int userId,
  });
  Future<BaseResponse<EmptyModel?>> cancelUpdateAvailability({
    required int id,
    required int userId,
  });

  Future<BaseResponse<EmptyModel?>> updateRtv(
    UpdateRtvModel model,
  );
  Future<BaseResponse<EmptyModel?>> updatePriceCheck(
    UpdatePriceModel model,
  );
  Future<BaseResponse<EmptyModel?>> updateFreshness(
    UpdateFreshnessModel model,
  );
  Future<BaseResponse<EmptyModel?>> updateVisitStock(
    UpdateStockModel model,
  );
  Future<BaseResponse<EmptyModel?>> updatePlanoGram(
    UpdatePlanoGramModel model,
  );
  Future<BaseResponse<EmptyModel?>> updateSOS(
    UpdateSOSModel model,
  );

  /// [getPlanoGramReasonsList]get list of planoGram reasons to update on planoGram
  Future<BaseResponse<PlanoGramReasonListModel?>> getPlanoGramReasonsList();

  /// upload images on sos
  Future<BaseResponse<ImageResponseModel?>> uploadImagesSOS(List<File> files);
}
