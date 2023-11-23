import 'package:c_supervisor/data/models/company_list_model.dart';

import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/cubits/selection_company_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/widgets/search_result_company_item_tile.dart';

import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../bloc/app_bloc_consumer.dart';
import '../cubits/company_cubit.dart';

class SearchCompanyResultList<K extends CompanyCubit, T extends SelectCompanyItemCubit>
    extends StatelessWidget {
  const SearchCompanyResultList({
    super.key,
    required this.isMultipleSelection,
    required this.teamSearchPagingListViewKey,
  });
  final GlobalKey<PagingListViewState> teamSearchPagingListViewKey;
  //[isMultipleSelection] enable user to choose multiple search items
  final bool isMultipleSelection;

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<CompanyCubit, BaseResponse<CompanyListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final companyModel = state.value?.data?.dataList[index];

            return GestureDetector(
              onTap: () => context.read<T>().selectItem(
                searchResultEntity: companyModel,
                isMultipleSelection: isMultipleSelection,
              ),
              child: SearchCompanyResultItemTile<T>(
                companyModel: companyModel,
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
