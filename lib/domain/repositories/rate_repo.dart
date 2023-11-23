import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/empty_model.dart';
import '../../data/models/rate/rate_model.dart';

abstract class RateRepo {
  Future<BaseResponse<EmptyModel?>> addRate(RateModel model);

}
