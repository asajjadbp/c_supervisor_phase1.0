import 'package:c_supervisor/ui/pages/team_journey_plan/team_jp_header.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../../enums/filter_type.dart';
import 'cubits/charts_data_cubit.dart';
import 'index.dart';

final GlobalKey<PagingListViewState> teamJourneyPlanPagingListViewKey =
    GlobalKey<PagingListViewState>();

class TeamJourneyPlanContent extends StatelessWidget {
  const TeamJourneyPlanContent({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    FilterModel? filterModel;
    try {
      final currentArgs = (teamJourneyPlanPagingListViewKey
              .currentState?.pagingController.args ??
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
                PostAuthRoutes.filterTeamJP.route.path,
                extra: FilterArgs(
                  teamSearchByFilter: _teamJPSearchByFilter,
                  parentBuildContext: context,
                  filterType: FilterType.teamJP,
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
              const TeamJPHeader(),
              SearchDateHeader(
                currentSearchDate: filterModel?.visitsDate ??
                    dateFormat.format(DateTime.now()),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Expanded(
                child: TeamJourneyPlanList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _teamJPSearchByFilter(FilterModel filterModel, BuildContext context) {
    final currentArgs =
        (teamJourneyPlanPagingListViewKey.currentState?.pagingController.args ??
            <dynamic, dynamic>{}) as Map<dynamic, dynamic>;

    currentArgs.addEntries([MapEntry('filterModel', filterModel)]);

    teamJourneyPlanPagingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);

    context
        .read<TeamJPChartDataCubit>()
        .getTeamJPChartsData(filterModel: filterModel);
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
