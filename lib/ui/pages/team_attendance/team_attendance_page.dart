
import 'package:c_supervisor/domain/index.dart';

import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/action_types_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/charts_data_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/insert_action_type_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/team_attendance_cubit.dart';

import 'package:intl/intl.dart';

class TeamAttendancePage extends StatelessWidget {
  const TeamAttendancePage({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamAttendanceCubit>(
            create: (context) =>
                TeamAttendanceCubit(GetIt.I<TeamAttendanceUC>())),
        BlocProvider<ChartDataCubit>(
            create: (context) =>
                ChartDataCubit(teamAttendanceUC: GetIt.I<TeamAttendanceUC>())
                  ..getTeamAttendanceChartsData(
                      filterModel: FilterModel(
                          childsIDs: [],
                          startDate: dateFormat.format(DateTime.now()),
                          endDate: dateFormat.format(DateTime.now()),
                          userID: GetIt.I<AppSharedPrefsClient>()
                              .getCurrentUserInfo()
                              ?.userId))),
        BlocProvider<ActionTypesCubit>(
            create: (context) =>
                ActionTypesCubit(actionTypesUC: GetIt.I<ActionTypesUC>())),
        BlocProvider<InsertActionTypeCubit>(
            create: (context) =>
                InsertActionTypeCubit(actionTypesUC: GetIt.I<ActionTypesUC>())),
        BlocProvider<SelectionCubit>(create: (context) => SelectionCubit())
      ],
      child: TeamAttendanceContent(
        moduleName: moduleName,
      ),
    );
  }
}
