import 'dart:io';

import 'package:c_supervisor/data/index.dart';
import 'package:c_supervisor/data/models/companies_category_data_list_model.dart';
import 'package:c_supervisor/data/models/companies_data_list_model.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/rate/rate_model.dart';
import 'package:c_supervisor/data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import 'package:c_supervisor/data/models/team_journey_plan_list_model.dart';
import 'package:c_supervisor/data/models/team_visits_history_list_model.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/data/models/update_category/update_sos_model.dart';
import 'package:c_supervisor/data/models/update_category/update_stock_model.dart';
import 'package:c_supervisor/data/models/visits_categories/planogram_list_model.dart';
import 'package:c_supervisor/data/models/visits_categories_list_model.dart';
import 'package:networking/client/networking_models/config_models/route_config.dart';
import 'package:networking/client/networking_models/index.dart';
import 'package:get_it/get_it.dart';

/// base remote hold reference for [networkManager]
import 'package:networking/networking.dart';
import '../../../di/injectors/dependancy_injector.dart';
import '../../models/add_file_model.dart';
import '../../models/planogram_reason/planogram_reasons_list_model.dart';
import '../../models/sup_visits/modules/photos/jp_photos_list_model.dart';
import '../../models/sup_visits/sup_visits_list_model.dart';
import '../../models/sup_visits/to_json/add_photo_to_json_model.dart';
import '../../models/sup_visits/to_json/checklist_to_json_model.dart';
import '../../models/sup_visits/to_json/start_visit_to_json_model.dart';
import '../../models/sup_visits/to_json/sup_visits_to_json.dart';
import '../../models/sup_visits/visit_count/sup_visits_list_count_model.dart';
import '../../models/update_category/update_availability_model.dart';
import '../../models/update_category/update_freshness_model.dart';
import '../../models/update_category/update_planogram_model.dart';
import '../../models/update_category/update_price_model.dart';
import '../../models/visits_categories/availability_list_model.dart';
import '../../models/knowledge_base_categories_list_model.dart';
import '../../models/companies_brand_data_list_model.dart';
import '../../models/companies_sku_data_list_model.dart';
import '../../models/chains_list_model.dart';
import '../../models/city_list_model.dart';
import '../../models/company_list_model.dart';
import '../../models/region_list_model.dart';
import '../../models/visits_categories/rtv_list_model.dart';
import '../../models/visits_categories/sos_list_model.dart';
import '../../models/visits_categories/visit_before_fixing_list_model.dart';
import '../../models/visits_categories/visit_capture_photos_list_model.dart';
import '../../models/visits_categories/visit_expiry_list_model.dart';
import '../../models/visits_categories/visit_price_list_model.dart';
import '../../models/visits_categories/visit_stock_list_model.dart';
import '../local/app_shared_prefs_client.dart';

/// [ApplicationRemoteDS] hold logic for frontend apis
class ApplicationRemoteDS {
  final NetworkManager networkManager;

  ApplicationRemoteDS(this.networkManager);

  Future<BaseResponse<UserDataModel?>> login({
    required LoginModel loginModel,
  }) async {
    final response = await networkManager.request<UserDataModel, UserDataModel>(
      RouteConfig(
        path: APIEndpoints.login,
        requestType: RequestType.post,
        isTokenRequired: false,
        body: loginModel.toJson(),
      ),
      UserDataModel(),
    );

    return response;
  }

  Future<BaseResponse<CommonDataListModel?>> fetchCheckInList({
    required int langId,
  }) async {
    final response =
        await networkManager.request<CommonDataListModel, CommonDataListModel>(
      RouteConfig(
          path: APIEndpoints.checkInList,
          requestType: RequestType.get,
          parameters: {"LangId": langId}),
      CommonDataListModel(),
    );

    return response;
  }

  Future<BaseResponse<CommonDataListModel?>> fetchActionTypeList({
    required bool isAttend,
  }) async {
    final response =
        await networkManager.request<CommonDataListModel, CommonDataListModel>(
      RouteConfig(
          path: APIEndpoints.actionList,
          requestType: RequestType.get,
          parameters: {"isAttend": isAttend}),
      CommonDataListModel(),
    );

    return response;
  }

  Future<BaseResponse<CommonDataListModel?>> fetchFeedbackList() async {
    final response =
        await networkManager.request<CommonDataListModel, CommonDataListModel>(
      RouteConfig(
        path: APIEndpoints.feedbackList,
        requestType: RequestType.get,
      ),
      CommonDataListModel(),
    );

    return response;
  }

  Future<BaseResponse<MainDashboardModel?>> getMainDashboard({
    required int userId,
    required int langId,
  }) async {
    final response =
        await networkManager.request<MainDashboardModel, MainDashboardModel>(
      RouteConfig(
          path: APIEndpoints.mainDashboard,
          requestType: RequestType.get,
          parameters: {"UserId": userId, "LangId": langId}),
      MainDashboardModel(),
    );
    return response;
  }

  Future<BaseResponse<TeamDashboardModel?>> getTeamDashboard({
    required int userId,
    required int langId,
  }) async {
    final response =
        await networkManager.request<TeamDashboardModel, TeamDashboardModel>(
      RouteConfig(
          path: APIEndpoints.teamDashboard,
          requestType: RequestType.get,
          parameters: {"UserId": userId, "LangId": langId}),
      TeamDashboardModel(),
    );
    return response;
  }

  Future<BaseResponse<TeamListModel?>> getTeamAttendance(
      FilterModel filterModel) async {
    final response = await networkManager.request<TeamListModel, TeamListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamAttendance,
        body: filterModel.toJson(),
      ),
      TeamListModel(),
    );
    return response;
  }

  Future<BaseResponse<TeamKPIListModel?>> getTeamKPIData(
      FilterModel filterModel) async {
    final response =
        await networkManager.request<TeamKPIListModel, TeamKPIListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamKPI,
        body: filterModel.toJson(),
      ),
      TeamKPIListModel(),
    );
    return response;
  }

  Future<BaseResponse<MyCoverageListModel?>> getMyCoverage({
    required FilterModel filterModel,
  }) async {
    final response =
        await networkManager.request<MyCoverageListModel, MyCoverageListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.myCoverage,
        body: filterModel.toMyCoverage(),
      ),
      MyCoverageListModel(),
    );
    return response;
  }

  /// Visits Categories
  Future<BaseResponse<AvailabilityListModel?>> getAvailability(
      int visitID, int categoryID) async {
    final response = await networkManager
        .request<AvailabilityListModel, AvailabilityListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.availability(294178, categoryID),
      ),
      AvailabilityListModel(),
    );
    return response;
  }

  Future<BaseResponse<PlanoGramListModel?>> getPlanoGram(
      int visitID, int categoryID) async {
    final response =
        await networkManager.request<PlanoGramListModel, PlanoGramListModel>(
      RouteConfig(
        requestType: RequestType.get,

        ///todo
        path: APIEndpoints.planoGram(visitID, categoryID),
      ),
      PlanoGramListModel(),
    );
    return response;
  }

  Future<BaseResponse<RTVListModel?>> getRTV(
      int visitID, int categoryID) async {
    final response = await networkManager.request<RTVListModel, RTVListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.rtv(visitID, categoryID),
      ),
      RTVListModel(),
    );
    return response;
  }

  Future<BaseResponse<SOSListModel?>> getSOS(
      int visitID, int categoryID) async {
    final response = await networkManager.request<SOSListModel, SOSListModel>(
      RouteConfig(
        requestType: RequestType.get,

        ///todo
        path: APIEndpoints.sos(visitID, categoryID),
      ),
      SOSListModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitPriceListModel?>> getVisitPrice(
      int visitID, int categoryID) async {
    final response =
        await networkManager.request<VisitPriceListModel, VisitPriceListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.visitPrice(294178, categoryID),
      ),
      VisitPriceListModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitExpiryListModel?>> getVisitExpiry(
      int visitID, int categoryID) async {
    final response = await networkManager
        .request<VisitExpiryListModel, VisitExpiryListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.visitExpiry(294178, categoryID),
      ),
      VisitExpiryListModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitStockListModel?>> getVisitStock(
      int visitID, int categoryID) async {
    final response =
        await networkManager.request<VisitStockListModel, VisitStockListModel>(
      RouteConfig(
        requestType: RequestType.get,

        ///todo
        path: APIEndpoints.visitStock(visitID, categoryID),
      ),
      VisitStockListModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitCapturePhotosListModel?>> getVisitCapturePhotos(
      int visitID, int categoryID) async {
    final response = await networkManager
        .request<VisitCapturePhotosListModel, VisitCapturePhotosListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.visitCapturePhotos(294178, categoryID),
      ),
      VisitCapturePhotosListModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitBeforeFixingListModel?>> getVisitBeforeFixing(
      int visitID, int categoryID) async {
    final response = await networkManager
        .request<VisitBeforeFixingListModel, VisitBeforeFixingListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.visitBeforeFixing(visitID, categoryID),
      ),
      VisitBeforeFixingListModel(),
    );
    return response;
  }

  ///

  Future<BaseResponse<TeamVisitsHistoryListModel?>> getTeamVisitsHistory({
    required FilterModel filterModel,
  }) async {
    final response = await networkManager
        .request<TeamVisitsHistoryListModel, TeamVisitsHistoryListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.visitsHistory,
        body: filterModel.toVisitHistoryJson(),
      ),
      TeamVisitsHistoryListModel(),
    );
    return response;
  }

  ///294178
  ///301954
  Future<BaseResponse<SuccessResponseModel?>> startAdtVisit({
    required int visitId,
  }) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.startAdtVisit(visitId),
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> finishAdtVisit({
    required int visitId,
  }) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.finishAdtVisit(visitId),
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<VisitsCategoriesListModel?>> getVisitsCategories({
    required int visitsID,
  }) async {
    final response = await networkManager
        .request<VisitsCategoriesListModel, VisitsCategoriesListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.visitsCategories(visitsID),
      ),
      VisitsCategoriesListModel(),
    );
    return response;
  }

  Future<BaseResponse<TeamJourneyPlanListModel?>> getTeamJourneyPlan({
    required FilterModel filterModel,
  }) async {
    final response = await networkManager
        .request<TeamJourneyPlanListModel, TeamJourneyPlanListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamJourneyPlan,
        body: filterModel.toTeamJPJson(),
      ),
      TeamJourneyPlanListModel(),
    );
    return response;
  }

  Future<BaseResponse<ChartDataList?>> getTeamJPChartsData(
      FilterModel filterModel) async {
    final response = await networkManager.request<ChartDataList, ChartDataList>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamJPChart,
        body: filterModel.toTeamJPJson(),
      ),
      ChartDataList(),
    );
    return response;
  }

  Future<BaseResponse<RegionsListModel?>> getRegions({
    required int userID,
    required int langID,
  }) async {
    final response =
        await networkManager.request<RegionsListModel, RegionsListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.regions(userID, langID),
      ),
      RegionsListModel(),
    );
    return response;
  }

  Future<BaseResponse<ChartDataList?>> getTeamKPIChartsData(
      FilterModel filterModel) async {
    final response = await networkManager.request<ChartDataList, ChartDataList>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamKPIChart,
        body: filterModel.toJson(),
      ),
      ChartDataList(),
    );
    return response;
  }

  Future<BaseResponse<TeamFilterListModel?>> getTeamSearchFilter(
      FilterByNameModel filterModel) async {
    final response =
        await networkManager.request<TeamFilterListModel, TeamFilterListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamFilterSearch,
        body: filterModel.toJson(),
      ),
      TeamFilterListModel(),
    );
    return response;
  }

  Future<BaseResponse<ChartDataList?>> getTeamAttendanceChartsData(
      FilterModel filterModel) async {
    final response = await networkManager.request<ChartDataList, ChartDataList>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.teamAttendanceChart,
        body: filterModel.toJson(),
      ),
      ChartDataList(),
    );
    return response;
  }

  Future<BaseResponse<TeamRolesListModel?>> getRolesSearchFilter() async {
    final response =
        await networkManager.request<TeamRolesListModel, TeamRolesListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.teamRoles(
            GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0),
      ),
      TeamRolesListModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> changePassword(OtpModel otpModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.changePassword,
        body: otpModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> verifyCode(OtpModel otpModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.verifyCode,
        body: otpModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> forgetPassword(String userName) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.forgetPassword,
        parameters: {"UserName": userName},
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> insertCheckIn(
      UserCheckInModel attendanceModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.insertCheckIn,
        body: attendanceModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> addRate(RateModel rateModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.addRate,
        body: rateModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  /// update categories
  /// Availability
  Future<BaseResponse<EmptyModel?>> updateAvailability(
    UpdateAvailabilityModel model,
  ) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateAvailability,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> cancelUpdateAvailability({
    required int id,
    required int userId,
  }) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.cancelUpdateAvailability,
        body: {"id": id, "userId": userId},
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<ConfirmSuccessResponseModel?>> confirmUpdateAvailability({
    required int id,
    required int userId,
  }) async {
    final response = await networkManager
        .request<ConfirmSuccessResponseModel, ConfirmSuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.confirmUpdateAvailability,
        body: {"id": id, "userId": userId},
      ),
      ConfirmSuccessResponseModel(),
    );
    return response;
  }

  ///
  Future<BaseResponse<EmptyModel?>> updateRtv(UpdateRtvModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateRtv,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> updatePriceCheck(
      UpdatePriceModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updatePriceCheck,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }


  Future<BaseResponse<EmptyModel?>> updateFreshness(
      UpdateFreshnessModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateFreshness,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> updateVisitStock(
      UpdateStockModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateVisitStock,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> updateSOS(UpdateSOSModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateSOS,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<PlanoGramReasonListModel?>>
      getPlanoGramReasonsList() async {
    final response = await networkManager
        .request<PlanoGramReasonListModel, PlanoGramReasonListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.getPlanoGramReasonsList,
      ),
      PlanoGramReasonListModel(),
    );
    return response;
  }

  /// upload images on sos
  Future<BaseResponse<ImageResponseModel?>> uploadImagesSOS(
      List<File> files) async {
    final response =
        await networkManager.request<ImageResponseModel, ImageResponseModel>(
      RouteConfig(
        requestType: RequestType.upload,
        path: APIEndpoints.uploadImageSOS,
        files: files,

        /// todo
        baseUrl: "https://testapi.catalist-me.com/",
        filesArrayName: '',
      ),
      ImageResponseModel(),
    );
    return response;
  }

  ///

  Future<BaseResponse<EmptyModel?>> updatePlanoGram(
      UpdatePlanoGramModel model) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updatePlanoGram,
        body: model.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  ///

  Future<BaseResponse<EmptyModel?>> insertActionType(
    AddActionTypeModel addActionTypeModel,
  ) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.addActionType,
        body: addActionTypeModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> insertFeedback(
      FeedBackModel feedBackModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.addFeedback,
        body: feedBackModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<ImageResponseModel?>> uploadImages(
      List<File> files) async {
    final response =
        await networkManager.request<ImageResponseModel, ImageResponseModel>(
      RouteConfig(
          requestType: RequestType.upload,
          path: APIEndpoints.uploadFileImages,
          files: files,
          filesArrayName: ''),
      ImageResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<KnowledgeBaseCategoriesListModel?>>
      getKnowledgeBaseCategories() async {
    final response = await networkManager.request<
        KnowledgeBaseCategoriesListModel, KnowledgeBaseCategoriesListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.knowledgeBaseCategories,
      ),
      KnowledgeBaseCategoriesListModel(),
    );
    return response;
  }

  Future<BaseResponse<EmptyModel?>> addFile(AddFileModel addFileModel) async {
    final response = await networkManager.request<EmptyModel, EmptyModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.addFile,
        body: addFileModel.toJson(),
      ),
      EmptyModel(),
    );
    return response;
  }

  Future<BaseResponse<ImageResponseModel?>> uploadFiles(
      List<File> files) async {
    final response =
        await networkManager.request<ImageResponseModel, ImageResponseModel>(
      RouteConfig(
          requestType: RequestType.upload,
          path: APIEndpoints.uploadFiles,
          files: files,
          filesArrayName: ''),
      ImageResponseModel(),
    );
    return response;
  }

  /// Filter Methods
  Future<BaseResponse<CitiesListModel?>> getCities({
    required int userID,
    required int langID,
  }) async {
    final response =
        await networkManager.request<CitiesListModel, CitiesListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.cities(userID, langID),
      ),
      CitiesListModel(),
    );
    return response;
  }

  Future<BaseResponse<CompanyListModel?>> getCompanies({
    required int userID,
    required int langID,
  }) async {
    final response =
        await networkManager.request<CompanyListModel, CompanyListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.companies(userID, langID),
      ),
      CompanyListModel(),
    );
    return response;
  }

  Future<BaseResponse<ChainsListModel?>> getChains({
    required int pageNumber,
    required int pageSize,
    required int userID,
    // required String? chainID,
    // required String? channelId,
    // required String? companyId,
    required int landID,
  }) async {
    final response =
        await networkManager.request<ChainsListModel, ChainsListModel>(
      RouteConfig(
          requestType: RequestType.post,
          path: APIEndpoints.chains,
          body: {
            "pageNumber": pageNumber,
            "pageSize": pageSize,
            "userID": userID,
            // "chainId": chainID,
            // "channelId": channelId,
            // "companyId": companyId,
            "langID": landID
          }),
      ChainsListModel(),
    );
    return response;
  }

  Future<BaseResponse<LastUserCheckInStatusModel?>> validateSupervisorCheckIN({
    required int userId,
  }) async {
    final response = await networkManager
        .request<LastUserCheckInStatusModel, LastUserCheckInStatusModel>(
      RouteConfig(
        path: APIEndpoints.checkSupervisorCheckIN(userId),
        requestType: RequestType.get,
      ),
      LastUserCheckInStatusModel(),
    );

    return response;
  }

  Future<BaseResponse<CompaniesDataListModel?>> getCompaniesData({
    required int userID,
    required int langID,
  }) async {
    final response = await networkManager
        .request<CompaniesDataListModel, CompaniesDataListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.companiesData(userID, langID),
      ),
      CompaniesDataListModel(),
    );
    return response;
  }

  Future<BaseResponse<CompaniesSkuDataListModel?>> getCompaniesSkuData({
    required int companyID,
    required int langID,
  }) async {
    final response = await networkManager
        .request<CompaniesSkuDataListModel, CompaniesSkuDataListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.companiesSkuData(companyID, langID),
      ),
      CompaniesSkuDataListModel(),
    );
    return response;
  }

  Future<BaseResponse<CompaniesCategoryDataListModel?>>
      getCompaniesCategoryData({
    required int companyID,
    required int langID,
  }) async {
    final response = await networkManager.request<
        CompaniesCategoryDataListModel, CompaniesCategoryDataListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.companiesCategoryData(companyID, langID),
      ),
      CompaniesCategoryDataListModel(),
    );
    return response;
  }

  Future<BaseResponse<CompaniesBrandDataListModel?>> getCompaniesBrandData({
    required int companyID,
    required int langID,
  }) async {
    final response = await networkManager
        .request<CompaniesBrandDataListModel, CompaniesBrandDataListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.companiesBrandData(companyID, langID),
      ),
      CompaniesBrandDataListModel(),
    );
    return response;
  }

  /// sup visits
  Future<BaseResponse<SupVisitsListModel?>> getSupVisits({
    required SupVisitsToJsonModel model,
  }) async {
    final response =
        await networkManager.request<SupVisitsListModel, SupVisitsListModel>(
      RouteConfig(
          requestType: RequestType.post,
          path: APIEndpoints.supVisits,
          body: model.toJson(),
          baseUrl: 'https://supapitest.catalist-me.com/'),
      SupVisitsListModel(),
    );
    return response;
  }

  Future<BaseResponse<SupVisitsCountListModel?>> getSupVisitsCount({
    required int userId,
  }) async {
    final response = await networkManager
        .request<SupVisitsCountListModel, SupVisitsCountListModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.supVisitsCount,
        body: {"userID": userId},
      ),
      SupVisitsCountListModel(),
    );
    return response;
  }

  Future<BaseResponse<ImageResponseModel?>> uploadImageJP(
      List<File> files) async {
    final response =
        await networkManager.request<ImageResponseModel, ImageResponseModel>(
      RouteConfig(
        requestType: RequestType.upload,
        path: APIEndpoints.uploadFileImagesJP,
        files: files,
        filesArrayName: '',
        baseUrl: 'https://supapitest.catalist-me.com/',
      ),
      ImageResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> startVisitJP(
      StartVisitToJsonModel model) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.startVisit,
        body: model.toJson(),
        baseUrl: 'https://supapitest.catalist-me.com/',
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<JPPhotosListModel?>> getJPPhotos({
    required int visitId,
  }) async {
    final response =
        await networkManager.request<JPPhotosListModel, JPPhotosListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.jPPhotos(visitId),
        baseUrl: 'https://supapitest.catalist-me.com/',
      ),
      JPPhotosListModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> addPhoto(
      AddPhotoToJsonModel model) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.addPhoto,
        body: model.toJson(),
        baseUrl: 'https://supapitest.catalist-me.com/',
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> removePhoto(int photoId) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.removePhoto(photoId),
        baseUrl: 'https://supapitest.catalist-me.com/',
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<CheckListListModel?>> getCheckList({
    required int visitId,
  }) async {
    final response =
        await networkManager.request<CheckListListModel, CheckListListModel>(
      RouteConfig(
        requestType: RequestType.get,
        path: APIEndpoints.checkList(visitId),
      ),
      CheckListListModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> updateVisitCheckList(
      UpdateCheckListToJsonModel model) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.updateVisitCheckList,
        baseUrl: 'https://supapitest.catalist-me.com/',
        body: model.toJson(),
      ),
      SuccessResponseModel(),
    );
    return response;
  }

  Future<BaseResponse<SuccessResponseModel?>> finishVisit({
    required int visitId,
    required String comment,
  }) async {
    final response = await networkManager
        .request<SuccessResponseModel, SuccessResponseModel>(
      RouteConfig(
        requestType: RequestType.post,
        path: APIEndpoints.finishVisit(comment: comment, visitId: visitId),
      ),
      SuccessResponseModel(),
    );

    return response;
  }

  ///
}
