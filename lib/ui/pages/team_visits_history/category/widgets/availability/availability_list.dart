import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/availability/cancel_availability_cubit.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/availability_list_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../cubits/availability/availability_cubit.dart';
import '../index.dart';
final GlobalKey<RefreshIndicatorState> refreshIndicatorAvailableKey  =
GlobalKey<RefreshIndicatorState>();

class AvailabilityList extends StatelessWidget {
  const AvailabilityList({
    Key? key,
    required this.visitId,
  }) : super(key: key);
  final int visitId;
  Future<void> _refreshData(BuildContext context) async {
    context.read<AvailabilityCubit>().loadItemsAtPage();
  }
  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<AvailabilityCubit,
        BaseResponse<AvailabilityListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key:refreshIndicatorAvailableKey ,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final availabilityModel = state.value?.data?.dataList[index];

              return BlocProvider(
                create: (_) => CancelAvailabilityCubit(
                  updateCategoryUC: GetIt.I<UpdateCategoryUC>(),
                ),
                child: AvailabilityCard(
                  index: index,
                  availabilityModel: availabilityModel!,
                  visitId: visitId,
                ),
              );
            },
            itemCount: state.value?.data?.dataList.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(
              height: 20.h,
            ),
          ),
        );
      },
    );
    // return PagingListView(
    //   key: categoryContentPagingListViewKey,
    //   padding: EdgeInsets.zero,
    //   dataProvider: context.read<AvailabilityCubit>(),
    //   firstPageProgressBuilder: (ctx) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    //   itemBuilder: (context, item, index) {
    //     final availability = item;
    //     return Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 8.w),
    //         child: CategoryCard(
    //           index: index,
    //           availabilityModel: availability,
    //         ));
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
