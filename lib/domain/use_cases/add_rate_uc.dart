import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/empty_model.dart';
import '../../data/models/rate/rate_model.dart';
import '../repositories/rate_repo.dart';

class RateUC {
  RateRepo rateRepo;
  RateUC(this.rateRepo);
  Future<BaseResponse<EmptyModel?>> addRate(RateModel model) {
    return rateRepo.addRate(model);
  }
}
