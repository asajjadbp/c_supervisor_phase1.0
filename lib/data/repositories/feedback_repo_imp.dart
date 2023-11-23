import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/common_data_list_model.dart';
import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/feed_back_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class FeedbackRepoImp implements FeedbackRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  FeedbackRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<CommonDataListModel?>> fetchFeedbackList() {
    return applicationRemoteDS.fetchFeedbackList();
  }

  @override
  Future<BaseResponse<EmptyModel?>> insertFeedback(
      FeedBackModel feedBackModel) {
    return applicationRemoteDS.insertFeedback(feedBackModel);
  }
}
