import 'package:c_supervisor/ui/pages/filter/cubit/selection_search_item_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../../../domain/use_cases/filter_uc.dart';

import '../../filter/cubit/team_filter_search_cubit.dart';
import '../../filter/filter_args.dart';
import 'filter_team_attendance_content.dart';

class FilterTeamAttendancePage extends StatelessWidget {
  const FilterTeamAttendancePage({
    Key? key,
    required this.filterArgs,
  }) : super(key: key);
  final FilterArgs filterArgs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamFilterSearchCubit>(
          create: (context) => TeamFilterSearchCubit(GetIt.I<FilterUC>()),
        ),
        BlocProvider<SelectSearchItemCubit>(
          create: (context) => SelectSearchItemCubit(),
        ),
      ],
      child: FilterTeamAttendanceContent(
        filterArgs: filterArgs,
      ),
    );
  }
}
