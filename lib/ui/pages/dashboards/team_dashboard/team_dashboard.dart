import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/pages/dashboards/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'team_dashboard_content.dart';

class TeamDashboard extends StatelessWidget {
  const TeamDashboard({
    Key? key,
    required this.moduleName,
  }) : super(key: key);
  final String moduleName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(dashboardUC: GetIt.I<DashboardUC>())
        ..getTeamDashboard(
            userId:
                GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ??
                    0),
      child: TeamDashboardContent(
        moduleName: moduleName,
      ),
    );
  }
}
