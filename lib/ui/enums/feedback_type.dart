/// This is num class for type of feedback
/// [$pro] this feedback for Productivity
///[$eff] this feedback for Efficiency
enum FeedbackType {
  pro,
  eff;

  String getFeedBackSelectionTitle(
      {required num threshold, required String? feedbackValue}) {
    if (threshold == 100) {
      return 'GOOD';
    } else if (threshold > 100 && threshold <= 125) {
      return 'Excellent';
    } else if (threshold > 125) {
      return 'EXCEPTIONAL';
    } else {
      return feedbackValue ?? 'Select Your Feedback';
    }
  }
}

class FeedbackTypeLogic {
  /// when add any feedback in future
  /// then
  /// this function add this feedback to the feedbackList in
  static List<FeedbackType> getFeedbackType() {
    List<FeedbackType> feedbackTypeList = [];
    for (int i = 0; i < FeedbackType.values.length; i++) {
      feedbackTypeList.addAll(FeedbackType.values);
    }
    return feedbackTypeList;
  }

  /// get length of feedbackType
  static int getFeedbackTypeLength() {
    return FeedbackType.values.length;
  }
}
