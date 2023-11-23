
import 'package:c_supervisor/ui/enums/index.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_attendance/team_attendance_header.dart';
import 'package:c_supervisor/ui/pages/team_attendance/widgets/team_attendance_list.dart';
import 'package:c_supervisor/utilities/router/global_routes.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'cubit/charts_data_cubit.dart';

final GlobalKey<PagingListViewState> teamListPagingListViewKey =
    GlobalKey<PagingListViewState>();

class TeamAttendanceContent extends StatelessWidget {
  const TeamAttendanceContent({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  final String moduleName;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    FilterModel? filterModel;
    try {
      final currentArgs =
          (teamListPagingListViewKey.currentState?.pagingController.args ??
              <dynamic, dynamic>{}) as Map<dynamic, dynamic>;
      if (currentArgs.containsKey('filterModel')) {
        filterModel = currentArgs['filterModel'] as FilterModel?;
      }
    } catch (e) {}

    return BrandReusable.withAnyHeader(
      isWidgetStacked: true,
      header: Align(
        child: AppHeader(
          prefixHeaderWidgets: [
            const BackIconButton(),
            SizedBox(
              width: 15.w,
            ),
            const DrawerIconButton(),
            SizedBox(
              width: 15.w,
            ),
            InkWell(
              onTap: () => context.push(
                PostAuthRoutes.filterTeamAttendance.route.path,
                extra: FilterArgs(
                  teamSearchByFilter: _teamSearchByFilter,
                  parentBuildContext: context,
                  filterType: FilterType.teamAttendance,
                ),
              ),
              child: SvgPicture.asset(
                'assets/icons/search_ic.svg',
              ),
            ),
          ],
          headerTitle: moduleName,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children: [
              const TeamAttendanceHeader(),
              SearchDateHeader(
                currentSearchDate:
                    filterModel?.startDate ?? dateFormat.format(DateTime.now()),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Expanded(
                child: TeamAttendanceList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _teamSearchByFilter(FilterModel filterModel, BuildContext context) {
    final currentArgs =
        (teamListPagingListViewKey.currentState?.pagingController.args ??
            <dynamic, dynamic>{}) as Map<dynamic, dynamic>;

    currentArgs.addEntries([MapEntry('filterModel', filterModel)]);

    teamListPagingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);

    context
        .read<ChartDataCubit>()
        .getTeamAttendanceChartsData(filterModel: filterModel);
  }
}

class SearchDateHeader extends StatelessWidget {
  const SearchDateHeader({Key? key, required this.currentSearchDate})
      : super(key: key);
  final String currentSearchDate;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.black12,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
            height: 50.h,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Date : ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Text(
                    currentSearchDate,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  )
                ],
              ),
            )));
  }
}
