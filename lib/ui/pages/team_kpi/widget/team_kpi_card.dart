import 'package:c_supervisor/di/environment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../enums/feedback_type.dart';
import 'drop_down_feedback_item.dart';
import 'kpi_item.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

class TeamKPICard extends HookWidget {
  const TeamKPICard({
    Key? key,
    required this.teamKpiDataModel,
  }) : super(key: key);

  final TeamKpiDataModel teamKpiDataModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70.withAlpha(150),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black12,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 240.h,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CustomCachedNetworkImage(
                        imgUrl: EnvironmentType
                                .development.environment.imageBaseURL +
                            (teamKpiDataModel.imgUrl?.replaceAll('\\', '/') ??
                                ''),
                        placeholderPath: '',
                        boxFit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                  ),
                )),
            Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      '${teamKpiDataModel.fullName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Id : ${teamKpiDataModel.userName ?? ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: primaryColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KPIItem(
                          label: 'ATT',
                          value: teamKpiDataModel.kpiData?.att ?? 'N/A',
                          isPercentageEnabled: false,
                        ),
                        KPIItem(
                          label: 'JPC',
                          value: (teamKpiDataModel.kpiData?.jpc
                                  ?.round()
                                  .toString()) ??
                              'N/A',
                        ),
                        KPIItem(
                          label: 'PRO',
                          value: teamKpiDataModel.kpiData?.pro
                                  ?.round()
                                  .toString() ??
                              'N/A',
                        ),
                        KPIItem(
                          label: 'EFF',
                          value: teamKpiDataModel.kpiData?.eef
                                  ?.round()
                                  .toString() ??
                              'N/A',
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        ///todo if itemCount more than 2 then remove this attribute NeverScrollableScrollPhysics
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          bool isEnabled = droDownIsEnabled(index);

                          return DropdownFeedbackItem(
                            isEnabled: isEnabled,
                            index: index,
                            teamKpiDataModel: teamKpiDataModel,
                            feedbackType:
                                FeedbackTypeLogic.getFeedbackType()[index],
                          );
                        },
                        itemCount: FeedbackTypeLogic.getFeedbackTypeLength(),
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// This function to check if the index of the drop down has access to inserting feedback
  /// if [teamKpiDataModel.kpiData!.pro! >= 100]
  /// then disable  inserting feedback
  /// or
  /// if [teamKpiDataModel.kpiData!.eef! >= 100]
  /// then disable  inserting feedback
  /// otherwise enable inserting feedback
  bool droDownIsEnabled(int index) {
    bool isEnabled = false;
    if (FeedbackTypeLogic.getFeedbackType()[index] == FeedbackType.pro) {
      isEnabled = teamKpiDataModel.kpiData?.pro != null &&
          teamKpiDataModel.kpiData!.pro! >= 100;
    } else if (FeedbackTypeLogic.getFeedbackType()[index] == FeedbackType.eff) {
      isEnabled = teamKpiDataModel.kpiData?.eef != null &&
          teamKpiDataModel.kpiData!.eef! >= 100;
    }
    return isEnabled;
  }
}
