import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/clients_sku/cubits/companies_data_cubit.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../data/models/companies_data_list_model.dart';
import '../../../bloc/app_bloc_consumer.dart';
import 'index.dart';
class ClientsSkuList extends StatelessWidget {
  const ClientsSkuList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBlocConsumer<CompaniesDataCubit, BaseResponse<CompaniesDataListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final companiesDataModel = state.value?.data?.dataList[index];

            return ClientsSkuCard(companiesDataModel: companiesDataModel!, index: index,);
          },
          itemCount: state.value?.data?.dataList.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(
            height: 20.h,
          ),
        );
      },
    );

    //
    // return PagingListView(
    //   key: clientsSkuPagingListViewKey,
    //   padding: EdgeInsets.zero,
    //   dataProvider: context.read<CompaniesDataCubit>(),
    //   firstPageProgressBuilder: (ctx) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   itemBuilder: (context, item, index) {
    //     final companiesDataModel = item;
    //     return Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 8.w),
    //         child: ClientsSkuCard(
    //           companiesDataModel:companiesDataModel ,
    //         index: index,
    //       ));
    //   },
    //   args: {},
    //   emptyPlaceholderWidget: const Center(
    //       child: Text('No Data')) /*CustomEmptyPlaceHolder.withEmptyIcon()*/,
    //   unAuthorizedNavigatorBlock: () {},
    //   properties: PagingListViewProperties.defaultProperties(
    //     context,
    //     noItemsFound: "No Items Found",
    //   ),
    // );
  }
}
