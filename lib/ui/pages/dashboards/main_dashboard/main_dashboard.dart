import 'dart:io';

import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/dashboards/cubit/dashboard_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/my_jp_count_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'main_dashboard_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (context) =>
              DashboardCubit(dashboardUC: GetIt.I<DashboardUC>())
                ..getMainDashboard(
                    userId: GetIt.I<AppSharedPrefsClient>()
                            .getCurrentUserInfo()
                            ?.userId ??
                        0),
        ),
        BlocProvider<MyJPCountCubit>(
          create: (context) =>
              MyJPCountCubit(supVisitsUC: GetIt.I<SupVisitsUC>())
                ..getSupVisitsCount(
                    userId: GetIt.I<AppSharedPrefsClient>()
                            .getCurrentUserInfo()
                            ?.userId ??
                        0),
        ),
      ],
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to leave ?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      exit(0);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: const MainDashboardContent(),
      ),
    );
  }
}
