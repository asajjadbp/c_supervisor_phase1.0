import 'package:c_supervisor/ui/index.dart';

import '../../../data/models/visits_categories/availability_list_model.dart';

abstract class AvailabilityRepo {
  Future<BaseResponse<AvailabilityListModel?>> getAvailability(
      int visitID, int categoryID);
}
