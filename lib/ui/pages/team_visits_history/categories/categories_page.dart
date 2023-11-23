import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories_uc.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/categories/cubits/visits_categories_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../domain/use_cases/team_visits_history_uc.dart';
import '../team_visits_history_result/cubits/audit_visit_action_cubit.dart';
import '../team_visits_history_result/cubits/team_visits_history_cubit.dart';
import 'index.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({
    Key? key,
    required this.moduleName,
    required this.visitsID,
    required this.teamVisitsHistoryModel,
  }) : super(key: key);
  final String moduleName;
  final int visitsID;
  final TeamVisitsHistoryModel teamVisitsHistoryModel;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              VisitsCategoriesCubit(GetIt.I<VisitsCategoriesUC>(), visitsID),
        ),
        BlocProvider(
          create: (_) => TeamVisitsHistoryCubit(GetIt.I<TeamVisitsHistoryUC>()),
        ),
        BlocProvider(
          create: (_) => AuditVisitActionCubit(GetIt.I<TeamVisitsHistoryUC>()),
        ),
      ],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CategoriesContent(
            moduleName: moduleName,
            teamVisitsHistoryModel: teamVisitsHistoryModel,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.0.h),
            child: AppBlocConsumer<AuditVisitActionCubit,
                BaseResponse<SuccessResponseModel?>>(
              onSuccessBuilder: (context, state) {
                return LoadingButton(
                  text: 'Finish Visit',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  isLoading: _isLoading.value,
                  borderRadius: 7.r,
                  btnColor: primaryColor,
                  btnHeight: 50.h,
                  btnWidth: 310.w,
                  colorScheme: colorScheme,
                  isDisabled: false,
                  onPressed: () {
                    /// TODO : replace this navigate
                    finishAuditVisit(context);
                  },
                );
              },
              isConsumerAction: true,
            ),
          )
        ],
      ),
    );
  }

  Future<void> finishAuditVisit(BuildContext context) async {
    _isLoading.value = true;

    final result = await context.read<AuditVisitActionCubit>().finishAdtVisit(
          visitId: teamVisitsHistoryModel.details?.visitID ?? 0,
        );

    if (result.message == "Success") {
      showSuccessMessage();
      Navigator.pop(context);
      refresh();
      _isLoading.value = false;
    }
    _isLoading.value = false;
  }

  void showSuccessMessage() {
    "Visit Finished Successfully".showToast(
      backgroundColor: Colors.green,
      gravity: ToastGravity.CENTER,
    );
  }

  void refresh() {
    teamVisitsHistoryPagingListViewKey.currentState?.refresh();
  }
}
