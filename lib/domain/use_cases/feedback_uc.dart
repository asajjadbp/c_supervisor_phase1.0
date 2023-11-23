import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class FeedbackUC {
  final FeedbackRepo feedbackRepo;

  FeedbackUC(this.feedbackRepo);

  Future<BaseResponse<CommonDataListModel?>> fetchFeedbackList() {
    return feedbackRepo.fetchFeedbackList();
  }

  Future<BaseResponse<EmptyModel?>> insertFeedback(
      FeedBackModel feedBackModel) {
    return feedbackRepo.insertFeedback(feedBackModel);
  }
}
