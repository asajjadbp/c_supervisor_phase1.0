import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../data/models/visits_categories/visit_before_fixing_list_model.dart';

abstract class VisitBeforeFixingRepo {
  Future<BaseResponse<VisitBeforeFixingListModel?>> getVisitBeforeFixing({
    required int visitID,
    required int categoryID,
  });
}
