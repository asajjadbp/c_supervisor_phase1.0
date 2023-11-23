import 'package:c_supervisor/ui/index.dart';

import '../../../data/models/visits_categories/availability_list_model.dart';
import '../../repositories/visits_categories/availability_repo.dart';

 class AvailabilityUC {
   AvailabilityRepo availabilityRepo;
   AvailabilityUC(this.availabilityRepo);
  Future<BaseResponse<AvailabilityListModel?>> getAvailability(
      int visitID, int categoryID){
    return availabilityRepo.getAvailability(visitID, categoryID);
  }
}
