import 'package:flutter/material.dart';
import '../../../enums/feedback_type.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

/// This is the content view of DropdownFeedbackItem
class DropDownFeedBackItemContent extends StatelessWidget {
  const DropDownFeedBackItemContent({
    super.key,
    required this.teamKpiDataModel,
    required this.feedbackType,
    required this.dropDownTitle,
    required this.isEnabled,
  });

  final TeamKpiDataModel teamKpiDataModel;
  final FeedbackType feedbackType;
  final String dropDownTitle;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8.h,
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          ' ${dropDownTitle.toUpperCase()}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Container(
          height: 33.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: !isEnabled ? primaryColor : greyColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                feedbackType == FeedbackType.pro
                    ? getFeedbackText(
                        feedbackType: feedbackType,
                        teamKpiDataModel: teamKpiDataModel,
                      ).toString()
                    : getFeedbackText(
                        feedbackType: feedbackType,
                        teamKpiDataModel: teamKpiDataModel,
                      ).toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30.w,
                color: white,
              )
            ],
          ),
        ),
      ],
    );
  }

  String getFeedbackText({
    required FeedbackType feedbackType,
    required TeamKpiDataModel teamKpiDataModel,
  }) {
    final kpiData = teamKpiDataModel.kpiData;
    switch (feedbackType) {
      case FeedbackType.pro:
        return feedbackType.getFeedBackSelectionTitle(
            threshold: kpiData?.pro ?? 0,
            feedbackValue:
                teamKpiDataModel.proFeedBack?.value ?? 'Select Your Feedback');
      case FeedbackType.eff:
        return feedbackType.getFeedBackSelectionTitle(
            threshold: kpiData?.eef ?? 0,
            feedbackValue:
                teamKpiDataModel.effFeedBack?.value ?? 'Select Your Feedback');
    }
  }
}
