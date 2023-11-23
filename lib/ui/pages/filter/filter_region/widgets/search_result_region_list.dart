import 'package:c_supervisor/data/models/region_list_model.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/selection_region_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/widgets/search_result_region_item_tile.dart';

import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../bloc/app_bloc_consumer.dart';
import '../cubits/region_cubit.dart';

class SearchRegionResultList<K extends RegionCubit, T extends SelectRegionItemCubit>
    extends StatelessWidget {
  const SearchRegionResultList({
    super.key,
    required this.isMultipleSelection,
    required this.teamSearchPagingListViewKey,
  });
  final GlobalKey<PagingListViewState> teamSearchPagingListViewKey;
  //[isMultipleSelection] enable user to choose multiple search items
  final bool isMultipleSelection;

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<RegionCubit, BaseResponse<RegionsListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final regionModel = state.value?.data?.dataList[index];

            return GestureDetector(
              onTap: () => context.read<T>().selectItem(
                searchResultEntity: regionModel,
                isMultipleSelection: isMultipleSelection,
              ),
              child: SearchRegionResultItemTile<T>(
                regionModel: regionModel,
              ),
            );
          },
          itemCount: state.value?.data?.dataList.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(
            height: 0.h,
          ),
        );
      },
    );
  }
}
