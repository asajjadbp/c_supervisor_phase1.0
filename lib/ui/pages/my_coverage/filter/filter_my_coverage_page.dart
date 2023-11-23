import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';

import '../../../../domain/use_cases/filter_methods_uc.dart';
import '../../filter/filter_args.dart';
import '../cubits/chains_cubit.dart';
import '../cubits/cities_cubit.dart';
import '../cubits/selection_chain_item_cubit.dart';
import 'filter_my_coverage_content.dart';

class FilterMyCoveragePage extends StatelessWidget {
  const FilterMyCoveragePage({
    Key? key,
     required this.filterArgs,
  }) : super(key: key);
  final FilterArgs filterArgs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChainsCubit>(
          create: (context) => ChainsCubit(GetIt.I<FilterMethodsUC>()),
        ),
        BlocProvider<CitiesCubit>(
          create: (context) => CitiesCubit(GetIt.I<FilterMethodsUC>())..loadItemsAtPage(),
        ),
        BlocProvider<SelectChainItemCubit>(
          create: (context) => SelectChainItemCubit(),
        ),
        BlocProvider<SelectCityItemCubit>(
          create: (context) => SelectCityItemCubit(),
        ),

      ],
      child: FilterMyCoverageContent(
          filterArgs: filterArgs,
          ),
    );
  }
}
