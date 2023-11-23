import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

class TeamKPIPage extends StatelessWidget {
  const TeamKPIPage({Key? key, required this.moduleName}) : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    /// TODO : will used to load the chart
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamKPIChartDataCubit>(
          create: (context) =>
              TeamKPIChartDataCubit(teamKPIUC: GetIt.I<TeamKPIUC>())
                ..getTeamKPIChartData(
                  filterModel: FilterModel(
                    childsIDs: [],
                    startDate: dateFormat.format(DateTime.now()),
                    endDate: dateFormat.format(DateTime.now()),
                    userID: GetIt.I<AppSharedPrefsClient>()
                        .getCurrentUserInfo()
                        ?.userId,
                  ),
                ),
        ),
        BlocProvider<TeamKPICubit>(
            create: (context) => TeamKPICubit(GetIt.I<TeamKPIUC>())),
        BlocProvider<FeedbackListCubit>(
            create: (context) =>
                FeedbackListCubit(feedbackUC: GetIt.I<FeedbackUC>())),
        BlocProvider<InsertFeedbackCubit>(
            create: (context) =>
                InsertFeedbackCubit(feedbackUC: GetIt.I<FeedbackUC>())),
        BlocProvider<SelectionCubit>(create: (context) => SelectionCubit())
      ],
      child: TeamKPIContent(
        moduleName: moduleName,
      ),
    );
  }
}
