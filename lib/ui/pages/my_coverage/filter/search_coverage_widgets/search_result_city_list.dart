import 'package:c_supervisor/data/models/city_list_model.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/cities_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_result_city_item_tile.dart';

import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../bloc/app_bloc_consumer.dart';

class SearchCityResultList<K extends CitiesCubit, T extends SelectCityItemCubit>
    extends StatelessWidget {
  const SearchCityResultList({
    super.key,
    required this.isMultipleSelection,
    required this.teamSearchPagingListViewKey,
  });
  final GlobalKey<PagingListViewState> teamSearchPagingListViewKey;
  //[isMultipleSelection] enable user to choose multiple search items
  final bool isMultipleSelection;

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<CitiesCubit, BaseResponse<CitiesListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final cityModel = state.value?.data?.dataList[index];

            return GestureDetector(
              onTap: () => context.read<T>().selectItem(
                    searchResultEntity: cityModel,
                    isMultipleSelection: isMultipleSelection,
                  ),
              child: SearchCityResultItemTile<T>(
                cityModel: cityModel,
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
