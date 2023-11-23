class APIEndpoints {
  //region API Config
  static const pageSize = 20;

  //endregion

  //region base paths
  static const frontEnd = '/api/Supervisors/';
  static const userPath = '/api/User/';
  static const authPath = '/api/';
  static const uploadImages = 'api/Photo/';

  //endregion

  static const String login = "/api/SupervisorLogin/Login";

  static const String mainDashboard = "${frontEnd}MainDashboard";

  static const String checkInList = "${userPath}CheckINLists";

  static const String insertCheckIn = "${userPath}InsertUserCheckIn";
  static const String addRate = "${frontEnd}SupervisorRate";

  /// update categories
  static const String updateAvailability = "${frontEnd}ADT_UpdateAvailability";
  static const String confirmUpdateAvailability =
      "${frontEnd}ADT_ConfirmUpdateAvailability";
  static const String cancelUpdateAvailability =
      "${frontEnd}ADT_CancelUpdateAvailability";

  ///
  static const String updateRtv = "${frontEnd}UpdateRTV";
  static const String updatePriceCheck = "${frontEnd}UpdatePrice";

  ///
  static const String updateFreshness = "${frontEnd}ADT_UpdateExpiry";

  ///
  static const String updateVisitStock = "${frontEnd}UpdateStock";
  static const String updateSOS = "${frontEnd}UpdateSOS";
  static const String getPlanoGramReasonsList =
      "${uploadImages}PlanogramReasons";
  static const String updatePlanoGram = "${frontEnd}UpdatePlanogram";

  ///
  static String checkSupervisorCheckIN(int userId) =>
      "${frontEnd}CheckSupervisorCheckIN/$userId";

  static const String uploadFileImages =
      "${uploadImages}UploadSupervisorPhotos";
  static const String uploadFileImagesJP =
      "${uploadImages}UploadSupervisorVisitPhotos";
  static const String uploadFiles = "${uploadImages}UploadKnowledgebase";
  static const String uploadImageSOS = "${uploadImages}UploadImage";

  static const String teamDashboard = "${frontEnd}TeamDashboard";

  static const String teamAttendance = "${frontEnd}TeamAttendance";
  static const String visitsHistory = "${frontEnd}VisitHistory";
  static String startAdtVisit(int visitId) =>
      "${frontEnd}ADT_SupStartVisit?visitId=$visitId";
  static String finishAdtVisit(int visitId) =>
      "${frontEnd}ADT_SupFinishVisit?visitId=$visitId";
  static String visitsCategories(int userId) =>
      "${frontEnd}VisitCategories/$userId";

  static String companiesData(int userId, int langID) =>
      "${frontEnd}CompaniesData/$userId/$langID";
  static String companiesCategoryData(int companyID, int langID) =>
      "${frontEnd}CompaniesCategoryData/$companyID/$langID";
  static String companiesBrandData(int companyID, int langID) =>
      "${frontEnd}CompaniesBrandData/$companyID/$langID";
  static String companiesSkuData(int companyID, int langID) =>
      "${frontEnd}CompaniesProductBarCodeData/$companyID/$langID";

  static String teamRoles(int userId) => "${frontEnd}TeamRoles?UserId=$userId";

  /// todo caID
  static String availability(int visitID, int categoryID) =>
      "${frontEnd}VisitAvalability?visitId=$visitID";

  /// todo caID
  static String planoGram(int visitID, int categoryID) =>
      "${frontEnd}VisitPlanogram?visitId=$visitID";

  /// todo caID
  static String rtv(int visitID, int categoryID) =>
      "${frontEnd}VisitRTV?visitId=$visitID";

  /// todo caID
  static String sos(int visitID, int categoryID) =>
      "${frontEnd}VisitSOS?visitId=$visitID";

  /// todo caID
  static String visitPrice(int visitID, int categoryID) =>
      "${frontEnd}VisitPrice?visitId=$visitID";

  /// todo caID
  static String visitExpiry(int visitID, int categoryID) =>
      "${frontEnd}VisitExpiry?visitId=$visitID";

  /// todo caID
  static String visitStock(int visitID, int categoryID) =>

      /// todo caID
      "${frontEnd}VisitStock?visitId=$visitID";

  /// todo caID
  static String visitCapturePhotos(int visitID, int categoryID) =>
      "${frontEnd}VisitCapturePhotos?visitId=$visitID";

  /// todo caID
  static String visitBeforeFixing(int visitID, int categoryID) =>
      "${frontEnd}VisitBeforFixing?visitId=$visitID";
  static const String teamKPI = "${frontEnd}TeamKPIs";

  static const String myCoverage = "${frontEnd}MyCoverge";
  static const String teamJourneyPlan = "${frontEnd}TeamJP";
  static String regions(int userID, int langID) =>
      "${frontEnd}Regions?UserId=$userID&langID=$langID";
  static String cities(int userID, int langID) =>
      "${frontEnd}Cities?UserId=$userID&LangId=$langID";
  static String companies(int userID, int langID) =>
      "${frontEnd}Companies?UserId=$userID&LangId=$langID";
  static String chains = "${frontEnd}Chains";

  static const String teamFilterSearch = "${frontEnd}Team";
  static const String knowledgeBaseCategories =
      "${frontEnd}KnowledgebaseCategories";
  static const String addFile = "${frontEnd}AddFile";
  static const String teamJPChart = "${frontEnd}TeamJPChart";

  static const String actionList = "${frontEnd}TeamAttendanceActionList";

  static const String feedbackList = "${frontEnd}TeamFeedBackList";

  static const String addActionType = "${frontEnd}AddActionType";

  static const String addFeedback = "${frontEnd}AddFeedBack";

  static const String teamAttendanceChart = "${frontEnd}TeamAttendanceChart";

  static const String teamKPIChart = "${frontEnd}TeamKPIsChart";

  static const String forgetPassword = "${userPath}ForgetPassword";

  static const String changePassword = "${userPath}ChangPasswordByCode";
  static const String verifyCode = "${userPath}VerifyCode";

  /// sup visits
  static const String supVisits = "${frontEnd}SupGetVistis";
  static const String supVisitsCount = "${frontEnd}SupGetVistisCounts";
  static const String startVisit = "${frontEnd}SupStartVisit";
  static const String addPhoto = "${frontEnd}SupAddVisitPhoto";
  static String removePhoto(int photoId) =>
      "${frontEnd}SupRemoveVisitPhoto?supVisitPhotoId=$photoId";
  static String jPPhotos(int visitId) =>
      "${frontEnd}SupGetVisitCapturePhotos?visitId=$visitId";
  static String checkList(int visitId) =>
      "${frontEnd}SupGetVisitCheckList?visitId=$visitId";
  static const String updateVisitCheckList =
      "${frontEnd}SupUpdateVisitCheckList";
  static String finishVisit({required String comment, required int visitId}) =>
      "${frontEnd}SupFinishVisit?visitId=$visitId&comment=$comment";
}
