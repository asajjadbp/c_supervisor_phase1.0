import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/sos/update_images_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/sos/sos_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/sos_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../cubits/sos/sos_cubit.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorSOSKey =
    GlobalKey<RefreshIndicatorState>();

class SOSList extends StatefulWidget {
  const SOSList({
    Key? key,
    required this.visitId,
  }) : super(key: key);
  final int? visitId;
  @override
  State<SOSList> createState() => _SOSListState();
}

class _SOSListState extends State<SOSList> {
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
    await context.read<SOSCubit>().loadItemsAtPage();
    await Future.delayed(const Duration(milliseconds: 100));
    if (_previousPosition != null) {
      _scrollController.jumpTo(_previousPosition ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<SOSCubit, BaseResponse<SOSListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          key: refreshIndicatorSOSKey,
          onRefresh: () => _refreshData(context),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final sosModel = state.value?.data?.dataList[index];

              return BlocProvider<UpdateImagesCubit>(
                create: (_) => UpdateImagesCubit(
                    updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
                child: SOSCard(
                  sosModel: sosModel,
                  visitId: widget.visitId,
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
  }
}
