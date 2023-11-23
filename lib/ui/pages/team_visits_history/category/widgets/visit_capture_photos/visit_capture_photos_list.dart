import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_capture_photos/visit_capture_photos_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/visit_capture_photos_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';
import '../../cubits/visit_capture_photos_cubit.dart';

class VisitCapturePhotosList extends StatelessWidget {
  const VisitCapturePhotosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<VisitCapturePhotosCubit, BaseResponse<VisitCapturePhotosListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final visitCaptureModel = state.value?.data?.dataList[index];

            return VisitCapturePhotosCard(visitCapturePhotosModel: visitCaptureModel);
          },
          itemCount: state.value?.data?.dataList.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(
            height: 20.h,
          ),
        );
      },
    );

  }
}


