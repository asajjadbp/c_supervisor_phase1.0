import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_price/visit_pric_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/visit_price_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';
import '../../cubits/price_check/visit_price_cubit.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorPriceKey =
    GlobalKey<RefreshIndicatorState>();

class VisitPriceList extends StatefulWidget {
  const VisitPriceList({
    Key? key,
    required this.visitId,
  }) : super(key: key);
  final int visitId;

  @override
  State<VisitPriceList> createState() => _VisitPriceListState();
}

class _VisitPriceListState extends State<VisitPriceList> {
  Future<void> _refreshData(BuildContext context) async {
    context.read<VisitPriceCubit>().loadItemsAtPage();
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<VisitPriceCubit, BaseResponse<VisitPriceListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key: refreshIndicatorPriceKey,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final visitPriceModel = state.value?.data?.dataList[index];

              return VisitPriceCard(
                visitPriceModel: visitPriceModel,
                visitId:widget.visitId ,
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
