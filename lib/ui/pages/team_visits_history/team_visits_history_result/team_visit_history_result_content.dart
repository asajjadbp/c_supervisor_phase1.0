import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../../../enums/filter_type.dart';
import 'index.dart';

final GlobalKey<PagingListViewState> teamVisitsHistoryPagingListViewKey =
    GlobalKey<PagingListViewState>();

class TeamVisitsHistoryResultContent extends StatelessWidget {
  const TeamVisitsHistoryResultContent({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    FilterModel? filterModel;
    try {
      final currentArgs =
      (teamVisitsHistoryPagingListViewKey.currentState?.pagingController.args ??
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
            Visibility(
              visible: true,
              child: InkWell(
                onTap: () => context.push(
                  PostAuthRoutes.filterVisitHistory.route.path,
                  extra: FilterArgs(
                    teamSearchByFilter: _teamVisitHistorySearchByFilter,
                    parentBuildContext: context,
                    filterType: FilterType.myVisitsHistory,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/search_ic.svg',
                ),
              ),
            ),
          ],
          headerTitle: moduleName,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: const Column(
            children: [

              Expanded(
                child: TeamVisitsHistoryResultList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _teamVisitHistorySearchByFilter(FilterModel filterModel, BuildContext context) {
    final currentArgs =
    (teamVisitsHistoryPagingListViewKey.currentState?.pagingController.args ??
        <dynamic, dynamic>{}) as Map<dynamic, dynamic>;

    currentArgs.addEntries([MapEntry('filterModel', filterModel)]);

    teamVisitsHistoryPagingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);

  }

}
