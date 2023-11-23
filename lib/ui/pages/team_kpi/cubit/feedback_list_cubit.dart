import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
class FeedbackListCubit extends BaseAppCubit<CommonDataListModel> {
  FeedbackListCubit({required this.feedbackUC});

  final FeedbackUC feedbackUC;

  Future<void> fetchFeedbackList() async {
    await networkCall(
      () => feedbackUC.fetchFeedbackList(),
    );
  }
}
