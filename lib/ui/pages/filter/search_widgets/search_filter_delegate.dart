import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/index.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/pages/filter/search_widgets/search_result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/paging/paging_list_view.dart';
import 'package:get_it/get_it.dart';

import '../cubit/selection_search_item_cubit.dart';
import '../cubit/team_filter_search_cubit.dart';

/// [SearchFilterDelegate] is generic search used to retrieve filter search values
class SearchFilterDelegate<K extends TeamFilterSearchCubit,
    T extends SelectSearchItemCubit> extends SearchDelegate {
  SearchFilterDelegate({
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
      child: SearchResultList<K, T>(
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
      child: SearchResultList<K, T>(
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

    currentArgs.addEntries([
      MapEntry(
          'filterModel',
          FilterByNameModel(
              pageNumber: 1,
              pageSize: APIEndpoints.pageSize,
              userID:
                  GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId,
              search: query,
              roleId: ''))
    ]);
    teamSearchPagingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);
  }
}
