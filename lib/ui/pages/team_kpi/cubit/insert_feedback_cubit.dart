import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
class InsertFeedbackCubit extends BaseAppCubit<EmptyModel> {
  InsertFeedbackCubit({required this.feedbackUC});

  final FeedbackUC feedbackUC;

  Future<void> insertFeedback({
    required FeedBackModel feedBackModel,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => feedbackUC.insertFeedback(feedBackModel),
    );
  }
}
