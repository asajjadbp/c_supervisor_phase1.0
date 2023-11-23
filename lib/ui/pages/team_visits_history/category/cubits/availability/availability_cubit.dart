import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../../../data/models/visits_categories/availability_list_model.dart';
import '../../../../../../domain/use_cases/visits_categories/availability_uc.dart';

class AvailabilityCubit extends BaseAppCubit<AvailabilityListModel> {
  final AvailabilityUC availabilityUC;
  final int visitID;
  final int categoryID;
  AvailabilityCubit({
    required this.availabilityUC,
    required this.visitID,
    required this.categoryID,
  });

  Future<AvailabilityListModel> loadItemsAtPage() async {
    final BaseResponse<AvailabilityListModel?> result;

    result = await networkCall(
      () => availabilityUC.getAvailability(visitID, categoryID),
    );

    return result.data ?? AvailabilityListModel();
  }
}
