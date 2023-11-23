import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/rate/rate_model.dart';
import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/domain/repositories/rate_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../data_sources/remote/application_remote_ds.dart';

class RateRepoImp implements RateRepo {
  ApplicationRemoteDS applicationRemoteDS;
  RateRepoImp(this.applicationRemoteDS);
  @override
  Future<BaseResponse<EmptyModel?>> addRate(RateModel rateModel) async {
    return applicationRemoteDS.addRate(rateModel);
  }

  @override
  Future<BaseResponse<EmptyModel?>> updateRtv(UpdateRtvModel model) async{
   return applicationRemoteDS.updateRtv(model);
  }
}
