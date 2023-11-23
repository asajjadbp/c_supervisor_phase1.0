import 'package:c_supervisor/ui/pages/filter/cubit/selection_search_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/cubits/company_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/cubits/selection_company_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/region_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/selection_region_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../../../domain/use_cases/filter_methods_uc.dart';
import '../../../../../domain/use_cases/filter_uc.dart';
import '../../../filter/cubit/team_filter_search_cubit.dart';
import '../../../filter/filter_args.dart';
import '../../../my_coverage/cubits/cities_cubit.dart';
import 'filter_my_visit_history_content.dart';

class FilterMyVisitHistoryPage extends StatelessWidget {
  const FilterMyVisitHistoryPage({
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
        BlocProvider<CitiesCubit>(
          create: (context) =>
              CitiesCubit(GetIt.I<FilterMethodsUC>())..loadItemsAtPage(),
        ),
        BlocProvider<SelectCityItemCubit>(
          create: (context) => SelectCityItemCubit(),
        ),
        BlocProvider<RegionCubit>(
          create: (context) =>
              RegionCubit(GetIt.I<FilterMethodsUC>())..loadItemsAtPage(),
        ),
        BlocProvider<SelectRegionItemCubit>(
          create: (context) => SelectRegionItemCubit(),
        ),
        BlocProvider<CompanyCubit>(
          create: (context) =>
              CompanyCubit(GetIt.I<FilterMethodsUC>())..loadItemsAtPage(),
        ),
        BlocProvider<SelectCompanyItemCubit>(
          create: (context) => SelectCompanyItemCubit(),
        ),
      ],
      child: FilterMyVisitHistoryContent(
        filterArgs: filterArgs,
      ),
    );
  }
}
