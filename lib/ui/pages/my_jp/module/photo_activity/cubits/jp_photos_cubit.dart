import 'package:c_supervisor/ui/bloc/base_app_cubit.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/sup_visits/modules/photos/jp_photos_list_model.dart';
import '../../../../../../domain/use_cases/sup_visits_uc.dart';
class JPPhotosCubit extends BaseAppCubit<JPPhotosListModel> {
  final SupVisitsUC supVisitsUC;

  JPPhotosCubit({
    required this.supVisitsUC,
  });

  Future<JPPhotosListModel> getJPPhotos({required int visitId}) async {
    final BaseResponse<JPPhotosListModel?> result;
    result = await networkCall(
      () => supVisitsUC.getJPPhotos(
        visitId: visitId,
      ),
    );

    return result.data ?? JPPhotosListModel();
  }
}
