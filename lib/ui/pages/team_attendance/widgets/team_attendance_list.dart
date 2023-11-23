import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/pages/team_attendance/cubit/team_attendance_cubit.dart';
import 'package:c_supervisor/ui/pages/team_attendance/team_attendance_content.dart';
import 'package:c_supervisor/ui/pages/team_attendance/widgets/team_attenance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/paging/paging_list_view_properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamAttendanceList extends StatelessWidget {
  const TeamAttendanceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: teamListPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<TeamAttendanceCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final teamMember = item as TeamMemberModel;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: TeamAttendanceCard(
            teamMemberModel: teamMember,
            teamListPagingListViewKey: teamListPagingListViewKey,
          ),
        );
      },
      args: const {},
      emptyPlaceholderWidget: const Center(
          child: Text('No Data')) /*CustomEmptyPlaceHolder.withEmptyIcon()*/,
      unAuthorizedNavigatorBlock: () {},
      properties: PagingListViewProperties.defaultProperties(
        context,
        noItemsFound: "No Items Found",
      ),
    );
  }
}
