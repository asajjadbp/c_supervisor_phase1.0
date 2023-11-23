import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/data/models/visits_categories_model.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories/planogram_uc.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories/visit_before_fixing_uc.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories/visit_capture_photos_uc.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/visit_before_fixing_cubit.dart';

import '../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../domain/use_cases/visits_categories/availability_uc.dart';
import '../../../../domain/use_cases/visits_categories/rtv_uc.dart';
import '../../../../domain/use_cases/visits_categories/sos_uc.dart';
import '../../../../domain/use_cases/visits_categories/visit_expiry_uc.dart';
import '../../../../domain/use_cases/visits_categories/visit_price_uc.dart';
import '../../../../domain/use_cases/visits_categories/visit_stock_uc.dart';
import 'cubits/availability/availability_cubit.dart';
import 'cubits/planogram/planogram_cubit.dart';
import 'cubits/planogram/planogram_reasons_cubit.dart';
import 'cubits/rtv/rtv_cubit.dart';
import 'cubits/sos/sos_cubit.dart';
import 'cubits/visit_capture_photos_cubit.dart';
import 'cubits/visit_expiry/visit_expiry_cubit.dart';
import 'cubits/price_check/visit_price_cubit.dart';
import 'cubits/visit_stock/visit_stock_cubit.dart';
import 'index.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
    required this.moduleName,
    required this.teamVisitsHistoryModel,
    required this.visitsCategoriesModel,
  }) : super(key: key);
  final String moduleName;
  final TeamVisitsHistoryModel teamVisitsHistoryModel;
  final VisitsCategoriesModel visitsCategoriesModel;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvailabilityCubit>(
          create: (_) => AvailabilityCubit(
            availabilityUC: GetIt.I<AvailabilityUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<PlanoGramCubit>(
          create: (_) => PlanoGramCubit(
            planoGramUC: GetIt.I<PlanoGramUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider(
          create: (_) => PlanoGramReasonsCubit(GetIt.I<UpdateCategoryUC>())
            ..getPlanoGramReasonsList(),
        ),
        BlocProvider<RTVCubit>(
          create: (_) => RTVCubit(
            rtvUC: GetIt.I<RtvUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<SOSCubit>(
          create: (_) => SOSCubit(
            sosUC: GetIt.I<SosUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<VisitPriceCubit>(
          create: (_) => VisitPriceCubit(
            visitPriceUC: GetIt.I<VisitPriceUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<VisitExpiryCubit>(
          create: (_) => VisitExpiryCubit(
            visitExpiryUC: GetIt.I<VisitExpiryUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<VisitStockCubit>(
          create: (_) => VisitStockCubit(
            visitStockUC: GetIt.I<VisitStockUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<VisitCapturePhotosCubit>(
          create: (_) => VisitCapturePhotosCubit(
            visitCapturePhotosUC: GetIt.I<VisitCapturePhotosUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),
        BlocProvider<VisitBeforeFixingCubit>(
          create: (_) => VisitBeforeFixingCubit(
            visitBeforeFixingUC: GetIt.I<VisitBeforeFixingUC>(),
            visitID: teamVisitsHistoryModel.details?.visitID ?? 0,
            categoryID: visitsCategoriesModel.id ?? 0,
          )..loadItemsAtPage(),
        ),

      ],
      child: CategoryContent(
        moduleName: moduleName,
        teamVisitsHistoryModel: teamVisitsHistoryModel,
      ),
    );
  }
}
