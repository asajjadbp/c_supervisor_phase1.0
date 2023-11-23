import 'package:c_supervisor/data/models/visits_categories/planogram_list_model.dart';

import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../domain/repositories/visits_categories/planogram_repo.dart';
import '../../data_sources/remote/application_remote_ds.dart';

class PlanoGramRepoImp implements PlanoGramRepo {
  ApplicationRemoteDS applicationRemoteDS;
  PlanoGramRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<PlanoGramListModel?>> getPlanoGram(
      {required int visitID, required int categoryID}) async {
    return applicationRemoteDS.getPlanoGram(
      visitID,
      categoryID,
    );
  }
}
