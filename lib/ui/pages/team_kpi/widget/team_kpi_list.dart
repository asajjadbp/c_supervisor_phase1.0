import 'package:flutter/material.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TeamKPIList extends StatelessWidget {
  const TeamKPIList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: teamListKPIPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<TeamKPICubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final teamKpiDataModel = item as TeamKpiDataModel;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: TeamKPICard(
            teamKpiDataModel: teamKpiDataModel,
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
