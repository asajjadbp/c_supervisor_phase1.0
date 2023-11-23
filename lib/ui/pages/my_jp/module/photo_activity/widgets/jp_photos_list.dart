import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/sup_visits/modules/photos/jp_photos_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';
import '../cubits/jp_photos_cubit.dart';
import 'jp_photos_card.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorPhotosKey =
    GlobalKey<RefreshIndicatorState>();

class JPPhotosList extends StatefulWidget {
  const JPPhotosList({
    super.key,
    this.visitId,
  });
  final int? visitId;

  @override
  State<JPPhotosList> createState() => _JPPhotosListState();
}

class _JPPhotosListState extends State<JPPhotosList> {
  Future<void> _refreshData(BuildContext context) async {
    context.read<JPPhotosCubit>().getJPPhotos(visitId: widget.visitId ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<JPPhotosCubit, BaseResponse<JPPhotosListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;

        return isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  key: refreshIndicatorPhotosKey,
                  onRefresh: () => _refreshData(context),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: state.value?.data?.dataList.length ?? 0,
                    itemBuilder: (context, index) {
                      final model = state.value?.data?.dataList[index];

                      return JPPhotosCard(
                        model: model,
                        visitId: widget.visitId ?? 0,
                      );
                    },
                  ),
                ),
              );
      },
      isConsumerAction: true,
    );
  }
}
