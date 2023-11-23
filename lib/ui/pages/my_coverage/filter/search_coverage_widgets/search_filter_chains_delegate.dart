import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/index.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/chains_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_chain_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_result_chain_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/paging/paging_list_view.dart';
import 'package:get_it/get_it.dart';

/// [SearchFilterChainsDelegate] is generic search used to retrieve filter search values
class SearchFilterChainsDelegate<K extends ChainsCubit,
    T extends SelectChainItemCubit> extends SearchDelegate {
  SearchFilterChainsDelegate({
    required this.parentContext,
    required this.isMultipleSelection,
  });

  final BuildContext parentContext;
  final GlobalKey<PagingListViewState> teamSearchPagingListViewKey =
      GlobalKey<PagingListViewState>();

  ///[isMultipleSelection] enable user to choose multiple items
  final bool isMultipleSelection;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      else
        const SizedBox(),
      IconButton(
        tooltip: 'Done',
        icon: const Icon(Icons.done),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _querySearch();
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => parentContext.read<K>()),
        BlocProvider<K>.value(
          value: BlocProvider.of<K>(parentContext),
        ),
        BlocProvider<T>.value(
          value: BlocProvider.of<T>(parentContext),
        )
      ],
      child: SearchChainResultList<K, T>(
        isMultipleSelection: isMultipleSelection,
        teamSearchPagingListViewKey: teamSearchPagingListViewKey,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _querySearch();

    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => parentContext.read<K>()),
        BlocProvider<K>.value(
          value: BlocProvider.of<K>(parentContext),
        ),
        BlocProvider<T>.value(
          value: BlocProvider.of<T>(parentContext),
        )
      ],
      child: SearchChainResultList<K, T>(
        isMultipleSelection: isMultipleSelection,
        teamSearchPagingListViewKey: teamSearchPagingListViewKey,
      ),
    );
  }

  /// called whenever user hit query
  void _querySearch() {
    final currentArgs =
        (teamSearchPagingListViewKey.currentState?.pagingController.args ??
            <dynamic, dynamic>{}) as Map<dynamic, dynamic>;

    // currentArgs.addEntries([
    //   MapEntry(
    //       'filterModel',
    //       FilterByNameModel(
    //           pageNumber: 1,
    //           pageSize: APIEndpoints.pageSize,
    //           userID:
    //               GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId,
    //           search: query,
    //           roleId: ''))
    // ]);
    var newArgs = Map<String, dynamic>.from(currentArgs);

    newArgs['filterModel'] = FilterByNameModel(
        pageNumber: 1,
        pageSize: APIEndpoints.pageSize,
        userID: GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId,
        search: query,
        roleId: '');
    teamSearchPagingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);
  }
}
