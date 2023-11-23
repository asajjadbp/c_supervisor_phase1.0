import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class FeedbackRepo {
  Future<BaseResponse<CommonDataListModel?>> fetchFeedbackList();

  Future<BaseResponse<EmptyModel?>> insertFeedback(FeedBackModel feedBackModel);
}
