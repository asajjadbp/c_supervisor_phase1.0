import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_stock/visit_stock_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/visit_stock_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';
import '../../cubits/visit_stock/visit_stock_cubit.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorStockListKey =
    GlobalKey<RefreshIndicatorState>();

class VisitStockList extends StatefulWidget {
  const VisitStockList({Key? key,required this.visitId,}) : super(key: key);
  final int visitId;
  @override
  VisitStockListState createState() => VisitStockListState();
}

class VisitStockListState extends State<VisitStockList> {
  final ScrollController _scrollController = ScrollController();
  double? _previousPosition;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    _previousPosition = _scrollController.position.pixels;
  }

  Future<void> _refreshData(BuildContext context) async {
    await context.read<VisitStockCubit>().loadItemsAtPage();
    await Future.delayed(const Duration(milliseconds: 100));
    if (_previousPosition != null) {
      _scrollController.jumpTo(_previousPosition ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<VisitStockCubit, BaseResponse<VisitStockListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key: refreshIndicatorStockListKey,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final visitStockModel = state.value?.data?.dataList[index];
              return VisitStockCard(
                visitStockModel: visitStockModel,
                visitId: widget.visitId,
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
