import 'package:c_supervisor/domain/use_cases/team_journey_plan_uc.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/team_journey_plan_content.dart';

import '../team_kpi/index.dart';
import 'cubits/charts_data_cubit.dart';
import 'index.dart';

class TeamJourneyPlanPage extends StatelessWidget {
  const TeamJourneyPlanPage({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamJourneyPlanCubit>(
            create: (_) => TeamJourneyPlanCubit(GetIt.I<TeamJourneyPlanUC>())),
        BlocProvider<TeamJPChartDataCubit>(
          create: (context) => TeamJPChartDataCubit(
              teamJourneyPlanUC: GetIt.I<TeamJourneyPlanUC>())
            ..getTeamJPChartsData(
              filterModel: FilterModel(
                pageNumber: 1,
                pageSize: 20,
                chainIDs: [],
                cityIDs: [],
                regionIDs: [],
                companyIDs: [],
                childsIDs: [],
                visitsDate: dateFormat.format(DateTime.now()),
                status: 4,
                userID: GetIt.I<AppSharedPrefsClient>()
                    .getCurrentUserInfo()
                    ?.userId,
              ),
            ),
        ),
      ],
      child: TeamJourneyPlanContent(
        moduleName: moduleName,
      ),
    );
  }
}
