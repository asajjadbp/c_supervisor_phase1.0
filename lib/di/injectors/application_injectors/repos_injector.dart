import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/repositories/index.dart';
import 'package:c_supervisor/data/repositories/my_coverage_repo_imp.dart';
import 'package:c_supervisor/data/repositories/sup_visits_repo_imp.dart';
import 'package:c_supervisor/data/repositories/team_visits_history_repo_imp.dart';
import 'package:c_supervisor/di/base_injector.dart';
import 'package:c_supervisor/di/injectors/dependancy_injector.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/domain/repositories/clients_sku_repo.dart';
import 'package:c_supervisor/domain/repositories/knowledge_share_repo.dart';
import 'package:c_supervisor/domain/repositories/my_coverage_repo.dart';
import 'package:c_supervisor/domain/repositories/rate_repo.dart';
import 'package:c_supervisor/domain/repositories/team_visits_history_repo.dart';
import 'package:c_supervisor/domain/repositories/visits_categories/planogram_repo.dart';
import 'package:c_supervisor/domain/repositories/visits_categories/visit_capture_photos_repo.dart';
import 'package:c_supervisor/domain/repositories/visits_categories/visit_stock_repo.dart';

import '../../../data/repositories/rate_repo_imp.dart';
import '../../../data/repositories/update_category_repo_imp.dart';
import '../../../data/repositories/visits_categories/availability_repo_imp.dart';
import '../../../data/repositories/knowledge_share_imp.dart';
import '../../../data/repositories/clients_sku_epo_imp.dart';
import '../../../data/repositories/filter_methods_imp.dart';
import '../../../data/repositories/team_journey_plan_repo_imp.dart';
import '../../../data/repositories/visits_categories/planogram_repo_imp.dart';
import '../../../data/repositories/visits_categories/rtv_repo_imp.dart';
import '../../../data/repositories/visits_categories/sos_repo_imp.dart';
import '../../../data/repositories/visits_categories/visit_before_fixing_repo_imp.dart';
import '../../../data/repositories/visits_categories/visit_capture_photos_repo_imp.dart';
import '../../../data/repositories/visits_categories/visit_expiry_repo_imp.dart';
import '../../../data/repositories/visits_categories/visit_price_repo_imp.dart';
import '../../../data/repositories/visits_categories/visit_stock_repo_imp.dart';
import '../../../data/repositories/visits_categories_repo-imp.dart';
import '../../../domain/repositories/sup_visits.dart';
import '../../../domain/repositories/update_category/update_category_repo.dart';
import '../../../domain/repositories/visits_categories/availability_repo.dart';
import '../../../domain/repositories/filter_methods_repo.dart';
import '../../../domain/repositories/team_journey_plan_repo.dart';
import '../../../domain/repositories/visits_categories/rtv_repo.dart';
import '../../../domain/repositories/visits_categories/sos_repo.dart';
import '../../../domain/repositories/visits_categories/visit_before_fixing_repo.dart';
import '../../../domain/repositories/visits_categories/visit_expiry_repo.dart';
import '../../../domain/repositories/visits_categories/visit_price_repo.dart';
import '../../../domain/repositories/visits_categories_repo.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector extends BaseInjector {
  static final reposInjectors = [
    () => diInstance.registerLazySingleton<AuthRepo>(
          () => AuthRepoImp(
            applicationRemoteDS: diInstance<ApplicationRemoteDS>(),
            appSecureStorageClient: diInstance<AppSecureStorageClient>(),
            appSharedPrefsClient: diInstance<AppSharedPrefsClient>(),
          ),
        ),
    () => diInstance.registerLazySingleton<DashboardRepo>(
          () => DashboardRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamAttendanceRepo>(
          () => TeamAttendanceRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamKPIRepo>(
          () => TeamKPIRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UserCheckInRepo>(
          () => UserCheckInRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UploadImageRepo>(
          () => UploadImageRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ActionTypeRepo>(
          () => ActionTypesRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<RateRepo>(
          () => RateRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UpdateCategoryRepo>(
          () => UpdateCategoryRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FilterRepo>(
          () => FilterRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FeedbackRepo>(
          () => FeedbackRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ResetPasswordRepo>(
          () => ResetPasswordRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<MyCoverageRepo>(
          () => MyCoverageRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamJourneyPlanRepo>(
          () => TeamJourneyPlanRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamVisitsHistoryRepo>(
          () => TeamVisitsHistoryImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitsCategoriesRepo>(
          () => VisitsCategoriesImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<AvailabilityRepo>(
          () => AvailabilityRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<PlanoGramRepo>(
          () => PlanoGramRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<RTVRepo>(
          () => RTVRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SOSRepo>(
          () => SOSRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitPriceRepo>(
          () => VisitPriceRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitExpiryRepo>(
          () => VisitExpiryRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitStockRepo>(
          () => VisitStockRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitCapturePhotosRepo>(
          () => VisitCapturePhotosRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitBeforeFixingRepo>(
          () => VisitBeforeFixingRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<KnowledgeShareRepo>(
          () => KnowledgeShareRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FilterMethodsRepo>(
          () => FilterMethodsRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ClientsSkuRepo>(
          () => ClientsSkuRepoImp(
            diInstance<ApplicationRemoteDS>(),
          ),
        ),
        () => diInstance.registerLazySingleton<SupVisitsRepo>(
          () => SupVisitsRepoImp(
        diInstance<ApplicationRemoteDS>(),
      ),
    ),
  ];

  /// iterate and inject all repos
  @override
  void injectModules() {
    for (final repoInjector in reposInjectors) {
      repoInjector.call();
    }
  }
}
