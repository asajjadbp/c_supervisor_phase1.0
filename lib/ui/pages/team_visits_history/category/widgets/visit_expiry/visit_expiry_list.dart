import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_expiry/visit_expiry_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/visit_expiry_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';
import '../../cubits/visit_expiry/visit_expiry_cubit.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorFreshnessKey =
    GlobalKey<RefreshIndicatorState>();

class VisitExpiryList extends StatelessWidget {
  const VisitExpiryList({
    Key? key,
    required this.visitId,
  }) : super(key: key);
  final int visitId;
  Future<void> _refreshData(BuildContext context) async {
    context.read<VisitExpiryCubit>().loadItemsAtPage();
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<VisitExpiryCubit,
        BaseResponse<VisitExpiryListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key: refreshIndicatorFreshnessKey,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final visitExpiryModel = state.value?.data?.dataList[index];

              return VisitExpiryCard(
                visitExpiryModel: visitExpiryModel,
                visitId: visitId,
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
  }
}
