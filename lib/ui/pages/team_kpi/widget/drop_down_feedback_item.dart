import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../enums/feedback_type.dart';
import 'drop_down_feedback_iten_content.dart';
import 'feedback_bottom_sheet/feedback_bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

class DropdownFeedbackItem extends HookWidget {
  final TeamKpiDataModel teamKpiDataModel;
  final FeedbackType feedbackType;
  late TextEditingController _feedbackController;
  late TextEditingController _commentFeedbackController;
  final int index;
  final bool isEnabled;

  DropdownFeedbackItem({
    super.key,
    required this.teamKpiDataModel,
    required this.feedbackType,
    required this.index,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    _feedbackController = TextEditingController();
    _commentFeedbackController = TextEditingController();
    final hasAccess = userHasAccessToInsertFeedbackForHim(teamKpiDataModel);

    return hasAccess
        ? InkWell(
            onTap: () => !isEnabled ? _showFeedbackBottomSheet(context) : null,
            child: DropDownFeedBackItemContent(
              isEnabled: isEnabled,
              teamKpiDataModel: teamKpiDataModel,
              feedbackType: feedbackType,
              dropDownTitle: feedbackType == FeedbackType.pro ? 'PRO' : 'EFF',
            ),
          )
        : const SizedBox();
  }

  /// This function to check if idOfUser Which logged to app equal to any id of list of Team Kpis
  /// if true then hidden dropdown of insert feedback
  /// if false then show dropdown of insert feedback and user will be have access to insert feedback
  bool userHasAccessToInsertFeedbackForHim(TeamKpiDataModel teamKpiDataModel) {
    int userIdLogin =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    if (teamKpiDataModel.id == userIdLogin) {
      return false;
    } else {
      return true;
    }
  }

  void _showFeedbackBottomSheet(BuildContext context) {
    final feedback = feedbackType == FeedbackType.pro
        ? teamKpiDataModel.proFeedBack
        : teamKpiDataModel.effFeedBack;

    if (feedback?.id != null) {
      context.read<SelectionCubit>().changeItemSelection(feedback);
      _feedbackController.text = feedback?.value ?? '';
    }

    _commentFeedbackController.text = feedback?.comment ?? '';

    FeedbackBottomSheet.showSelectionBottomSheet(
      parentContext: context,
      onSelectionConfirmed: () => _insertFeedback(context),
      commentFeedbackController: _commentFeedbackController,
      feedbackController: _feedbackController,
    );
  }

  void _insertFeedback(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final selectionCubit = context.read<SelectionCubit>();
    final feedbackId = selectionCubit.state?.id;
    final feedbackType = this.feedbackType.index;
    final teamKpiDataModel = this.teamKpiDataModel;
    final comment = _commentFeedbackController.text;
    final actionDate =
        (teamListKPIPagingListViewKey.currentState?.pagingController.args ??
                    <dynamic, dynamic>{})['filterModel']
                ?.startDate ??
            dateFormat.format(DateTime.now());
    final supervisorId =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId;

    context.read<InsertFeedbackCubit>().insertFeedback(
          successCall: () {
            teamListKPIPagingListViewKey.currentState?.refresh();
            _chartRefresh(context, dateFormat, _commentFeedbackController);
            Navigator.of(context).pop();
            selectionCubit.changeItemSelection(null);
          },
          feedBackModel: FeedBackModel(
            userID: teamKpiDataModel.id,
            comment: comment,
            actionDate: actionDate,
            supervisorID: supervisorId,
            feedBackID: feedbackId,
            feedBackType: feedbackType,
          ),
        );
  }

  void _chartRefresh(BuildContext context, DateFormat dateFormat,
      TextEditingController commentFeedbackController) {
    FilterModel? filterModel;
    try {
      final currentArgs =
          (teamListKPIPagingListViewKey.currentState?.pagingController.args ??
              <dynamic, dynamic>{}) as Map<dynamic, dynamic>;
      if (currentArgs.containsKey('filterModel')) {
        filterModel = currentArgs['filterModel'] as FilterModel?;
      }
    } catch (e) {
      if (kDebugMode) {
        print("error =  ${e.toString()}");
      }
    }

    context.read<TeamKPIChartDataCubit>().getTeamKPIChartData(
          filterModel: filterModel ??
              FilterModel(
                childsIDs: [],
                startDate: dateFormat.format(DateTime.now()),
                endDate: dateFormat.format(DateTime.now()),
                userID: GetIt.I<AppSharedPrefsClient>()
                    .getCurrentUserInfo()
                    ?.userId,
              ),
        );
  }
}
