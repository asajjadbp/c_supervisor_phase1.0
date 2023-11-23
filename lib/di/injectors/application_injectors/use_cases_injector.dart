import 'package:c_supervisor/di/base_injector.dart';
import 'package:c_supervisor/di/injectors/dependancy_injector.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/domain/repositories/clients_sku_repo.dart';
import 'package:c_supervisor/domain/repositories/knowledge_share_repo.dart';
import 'package:c_supervisor/domain/repositories/my_coverage_repo.dart';
import 'package:c_supervisor/domain/repositories/team_journey_plan_repo.dart';
import 'package:c_supervisor/domain/repositories/team_visits_history_repo.dart';
import 'package:c_supervisor/domain/repositories/visits_categories_repo.dart';
import 'package:c_supervisor/domain/use_cases/add_rate_uc.dart';
import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:c_supervisor/domain/use_cases/knowledge_share_uc.dart';
import 'package:c_supervisor/domain/use_cases/my_coverage_uc.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/domain/use_cases/team_visits_history_uc.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories/planogram_uc.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories_uc.dart';

import '../../../domain/repositories/rate_repo.dart';
import '../../../domain/repositories/sup_visits.dart';
import '../../../domain/repositories/update_category/update_category_repo.dart';
import '../../../domain/repositories/visits_categories/availability_repo.dart';
import '../../../domain/repositories/filter_methods_repo.dart';
import '../../../domain/repositories/visits_categories/planogram_repo.dart';
import '../../../domain/repositories/visits_categories/rtv_repo.dart';
import '../../../domain/repositories/visits_categories/sos_repo.dart';
import '../../../domain/repositories/visits_categories/visit_before_fixing_repo.dart';
import '../../../domain/repositories/visits_categories/visit_capture_photos_repo.dart';
import '../../../domain/repositories/visits_categories/visit_expiry_repo.dart';
import '../../../domain/repositories/visits_categories/visit_price_repo.dart';
import '../../../domain/repositories/visits_categories/visit_stock_repo.dart';
import '../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../domain/use_cases/visits_categories/availability_uc.dart';
import '../../../domain/use_cases/filter_methods_uc.dart';
import '../../../domain/use_cases/team_journey_plan_uc.dart';
import '../../../domain/use_cases/visits_categories/rtv_uc.dart';
import '../../../domain/use_cases/visits_categories/sos_uc.dart';
import '../../../domain/use_cases/visits_categories/visit_before_fixing_uc.dart';
import '../../../domain/use_cases/visits_categories/visit_capture_photos_uc.dart';
import '../../../domain/use_cases/visits_categories/visit_expiry_uc.dart';
import '../../../domain/use_cases/visits_categories/visit_price_uc.dart';
import '../../../domain/use_cases/visits_categories/visit_stock_uc.dart';

class UseCasesInjector extends BaseInjector {
  static final useCasesInjectors = [
    () => diInstance.registerLazySingleton<LoginUC>(
          () => LoginUC(
            diInstance<AuthRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<DashboardUC>(
          () => DashboardUC(
            diInstance<DashboardRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamAttendanceUC>(
          () => TeamAttendanceUC(
            diInstance<TeamAttendanceRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamKPIUC>(
          () => TeamKPIUC(
            diInstance<TeamKPIRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UserCheckInUC>(
          () => UserCheckInUC(
            diInstance<UserCheckInRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UploadImageUC>(
          () => UploadImageUC(
            diInstance<UploadImageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ActionTypesUC>(
          () => ActionTypesUC(
            diInstance<ActionTypeRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<RateUC>(
          () => RateUC(
            diInstance<RateRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UpdateCategoryUC>(
          () => UpdateCategoryUC(
            diInstance<UpdateCategoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FeedbackUC>(
          () => FeedbackUC(
            diInstance<FeedbackRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FilterUC>(
          () => FilterUC(
            diInstance<FilterRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ResetPasswordUC>(
          () => ResetPasswordUC(
            diInstance<ResetPasswordRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<MyCoverageUC>(
          () => MyCoverageUC(
            diInstance<MyCoverageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamJourneyPlanUC>(
          () => TeamJourneyPlanUC(
            diInstance<TeamJourneyPlanRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<TeamVisitsHistoryUC>(
          () => TeamVisitsHistoryUC(
            diInstance<TeamVisitsHistoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitsCategoriesUC>(
          () => VisitsCategoriesUC(
            diInstance<VisitsCategoriesRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<AvailabilityUC>(
          () => AvailabilityUC(
            diInstance<AvailabilityRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<PlanoGramUC>(
          () => PlanoGramUC(
            diInstance<PlanoGramRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<RtvUC>(
          () => RtvUC(
            diInstance<RTVRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SosUC>(
          () => SosUC(
            diInstance<SOSRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitPriceUC>(
          () => VisitPriceUC(
            diInstance<VisitPriceRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitExpiryUC>(
          () => VisitExpiryUC(
            diInstance<VisitExpiryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitStockUC>(
          () => VisitStockUC(
            diInstance<VisitStockRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitBeforeFixingUC>(
          () => VisitBeforeFixingUC(
            diInstance<VisitBeforeFixingRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<VisitCapturePhotosUC>(
          () => VisitCapturePhotosUC(
            diInstance<VisitCapturePhotosRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ClientsSkuUC>(
          () => ClientsSkuUC(
            diInstance<ClientsSkuRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<FilterMethodsUC>(
          () => FilterMethodsUC(
            diInstance<FilterMethodsRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<KnowledgeShareUC>(
          () => KnowledgeShareUC(
            diInstance<KnowledgeShareRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SupVisitsUC>(
          () => SupVisitsUC(
            diInstance<SupVisitsRepo>(),
          ),
        ),
  ];

  /// iterate and inject all Use cases
  @override
  void injectModules() {
    for (final useCase in useCasesInjectors) {
      useCase.call();
    }
  }
}
