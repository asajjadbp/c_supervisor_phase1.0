import 'package:c_supervisor/data/data_sources/local/app_shared_prefs_client.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/styles/index.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/charts_data_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/insert_action_type_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/widgets/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../common_reusable/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamAttendanceCard extends StatelessWidget {
  const TeamAttendanceCard(
      {Key? key,
      required this.teamMemberModel,
      required this.teamListPagingListViewKey})
      : super(key: key);

  final TeamMemberModel teamMemberModel;
  final GlobalKey<PagingListViewState> teamListPagingListViewKey;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return Card(
      color: Colors.white70.withAlpha(240),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.black12,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 135.h,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCachedNetworkImage(
                    /// if image path contains (TmrCheckIN)
                    /// then base url =
                    ///https://testapi.catalist-me.com/
                    ///else base url =
                    /// https://csupervisionapi.catalist-me.com/
                    imgUrl: teamMemberModel.imgUrl!.contains('TmrCheckIN')
                        ? "https://testapi.catalist-me.com/${teamMemberModel.imgUrl}"
                                .replaceAll('\\', '/')
                        : "https://csupervisionapi.catalist-me.com/${teamMemberModel.imgUrl}"
                            .replaceAll('\\', '/'),
                    placeholderPath: '',
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      '${teamMemberModel.fullName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Id : ${teamMemberModel.userName ?? ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: primaryColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Status : ${teamMemberModel.attendance ?? ''} ',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: blue),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Action: ( ${teamMemberModel.actionType?.value ?? 'N/A'} )',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: primaryColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Visibility(
                      visible: false,
                      child: IconText(
                          title: 'kSA,Riyad,st22',
                          color: darkGrey,
                          icon: SvgPicture.asset(
                            'assets/icons/location_ic.svg',
                            color: darkGrey,
                          )),
                    ),
                    IconText(
                        title: teamMemberModel.checkInDate ?? 'N/A',
                        color: primaryColor,
                        icon: SvgPicture.asset(
                          'assets/icons/calendar_ic.svg',
                          color: primaryColor,
                        ))
                  ],
                )),
            Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    /// TODO  show bottom sheet
                    SelectionBottomSheet.showSelectionBottomSheet(
                        parentContext: context,
                        isAttend:
                            ((teamMemberModel.attendance ?? '') == 'Present'),
                        onSelectionConfirmed: () {
                          FilterModel? filterModel;
                          if (context.read<SelectionCubit>().state != null) {
                            try {
                              final currentArgs =
                                  (teamListPagingListViewKey.currentState
                                              ?.pagingController.args ??
                                          <dynamic, dynamic>{})
                                      as Map<dynamic, dynamic>;
                              if (currentArgs.containsKey('filterModel')) {
                                filterModel =
                                    currentArgs['filterModel'] as FilterModel?;
                              }
                            } catch (e) {}
                            context
                                .read<InsertActionTypeCubit>()
                                .insertActionType(
                                    successCall: () {
                                      teamListPagingListViewKey.currentState
                                          ?.refresh();
                                      _chartRefresh(context, dateFormat);
                                      Navigator.of(context).pop();
                                      context
                                          .read<SelectionCubit>()
                                          .changeItemSelection(null);
                                    },
                                    addActionTypeModel: AddActionTypeModel(
                                        userID: teamMemberModel.id,
                                        actionDate: filterModel?.startDate ??
                                            dateFormat.format(DateTime.now()),
                                        supervisorID:
                                            GetIt.I<AppSharedPrefsClient>()
                                                .getCurrentUserInfo()
                                                ?.userId,
                                        actionTypeID: context
                                            .read<SelectionCubit>()
                                            .state
                                            ?.id));
                          }
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 37.w,
                      height: 65.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 35.w,
                        color: primaryColor,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _chartRefresh(BuildContext context, DateFormat dateFormat) {
    FilterModel? filterModel;
    try {
      final currentArgs =
          (teamListPagingListViewKey.currentState?.pagingController.args ??
              <dynamic, dynamic>{}) as Map<dynamic, dynamic>;
      if (currentArgs.containsKey('filterModel')) {
        filterModel = currentArgs['filterModel'] as FilterModel?;
      }
    } catch (e) {}

    context.read<ChartDataCubit>().getTeamAttendanceChartsData(
        filterModel: filterModel ??
            FilterModel(
                childsIDs: [],
                startDate: dateFormat.format(DateTime.now()),
                endDate: dateFormat.format(DateTime.now()),
                userID: GetIt.I<AppSharedPrefsClient>()
                    .getCurrentUserInfo()
                    ?.userId));
  }
}
