import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/pages/filter/cubit/selection_search_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/search_widgets/search_result_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/paging/paging_list_view_properties.dart';
import '../cubit/team_filter_search_cubit.dart';

class SearchResultList<K extends TeamFilterSearchCubit,
    T extends SelectSearchItemCubit> extends StatelessWidget {
  const SearchResultList({
    super.key,
    required this.isMultipleSelection,
    required this.teamSearchPagingListViewKey,
  });
  final GlobalKey<PagingListViewState> teamSearchPagingListViewKey;
  //[isMultipleSelection] enable user to choose multiple search items
  final bool isMultipleSelection;

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: teamSearchPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<TeamFilterSearchCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final teamFilterResultModel = item as TeamFilterResultModel;
        return GestureDetector(
          onTap: () => context.read<T>().selectItem(
                searchResultEntity: teamFilterResultModel,
                isMultipleSelection: isMultipleSelection,
              ),
          child: SearchResultItemTile<T>(
            teamFilterResultModel: teamFilterResultModel,
          ),
        );
      },
      args: const {
        // TODO add args here
      },
      emptyPlaceholderWidget: Container(
        child: const Center(child: Text('No Data')),
      ) /*CustomEmptyPlaceHolder.withEmptyIcon()*/,
      unAuthorizedNavigatorBlock: () {},
      properties: PagingListViewProperties.defaultProperties(
        context,
        noItemsFound: "No Items Found",
      ),
    );
  }
}
