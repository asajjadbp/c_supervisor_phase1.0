import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/pages/filter/cubit/team_filter_search_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import 'cubit/roles_filter_search_cubit.dart';
import 'cubit/selection_search_item_cubit.dart';
import 'filter_content.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({
    Key? key,
    required this.filterArgs,
  }) : super(key: key);
  final FilterArgs filterArgs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeamFilterSearchCubit>(
            create: (context) => TeamFilterSearchCubit(GetIt.I<FilterUC>())),
        BlocProvider<RolesFilterSearchCubit>(
            create: (context) => RolesFilterSearchCubit(GetIt.I<FilterUC>())
              ..loadItemsAtPage(1)),
        BlocProvider<SelectSearchItemCubit>(
            create: (context) => SelectSearchItemCubit()),
      ],
      child: FilterContent(
        filterArgs: filterArgs,
      ),
    );
  }
}
