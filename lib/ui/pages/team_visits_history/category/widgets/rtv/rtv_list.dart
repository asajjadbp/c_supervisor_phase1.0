import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/rtv/rtv_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/rtv_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../cubits/rtv/rtv_cubit.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorRtvKey =
    GlobalKey<RefreshIndicatorState>();

class RTVList extends StatefulWidget {
  const RTVList({
    Key? key,
    required this.visitId,
  }) : super(key: key);
  final int? visitId;
  @override
  State<RTVList> createState() => _RTVListState();
}

class _RTVListState extends State<RTVList> {
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
    await context.read<RTVCubit>().loadItemsAtPage();
    await Future.delayed(const Duration(milliseconds: 100));
    if (_previousPosition != null) {
      _scrollController.jumpTo(_previousPosition ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<RTVCubit, BaseResponse<RTVListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key: refreshIndicatorRtvKey,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final rtvModel = state.value?.data?.dataList[index];
              return RTVCard(
                rtvModel: rtvModel,
                visitId: widget.visitId,
              );
            },
            itemCount: state.value?.data?.dataList.length ?? 0,
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
          ),
        );
      },
    );
  }
}
