import 'package:c_supervisor/ui/pages/my_coverage/cubits/chains_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_chain_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_result_chain_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/paging/paging_list_view_properties.dart';

class SearchChainResultList<K extends ChainsCubit,
    T extends SelectChainItemCubit> extends StatelessWidget {
  const SearchChainResultList({
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
      dataProvider: context.read<ChainsCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final searchModel = item;
        return GestureDetector(
          onTap: () => context.read<T>().selectItem(
                searchResultEntity: searchModel,
                isMultipleSelection: isMultipleSelection,
              ),
          child: SearchChainResultItemTile<T>(
            chainModel: searchModel,
          ),
        );
      },
      args: const {

      },
      emptyPlaceholderWidget: const Center(
        child: Text('No Data'),
      ) /*CustomEmptyPlaceHolder.withEmptyIcon()*/,
      unAuthorizedNavigatorBlock: () {},
      properties: PagingListViewProperties.defaultProperties(
        context,
        noItemsFound: "No Items Found",
      ),
    );
  }
}
