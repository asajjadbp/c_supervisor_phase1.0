import 'package:c_supervisor/ui/pages/team_visits_history/team_visits_history_result/cubits/audit_visit_action_cubit.dart';

import 'index.dart';

class TeamVisitsHistoryResultPage extends StatelessWidget {
  const TeamVisitsHistoryResultPage({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TeamVisitsHistoryCubit(GetIt.I<TeamVisitsHistoryUC>()),
        ),
        BlocProvider(
          create: (_) => AuditVisitActionCubit(GetIt.I<TeamVisitsHistoryUC>()),
        ),
      ],
      child: TeamVisitsHistoryResultContent(
        moduleName: moduleName,
      ),
    );
  }
}
