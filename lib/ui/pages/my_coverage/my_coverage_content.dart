
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../../enums/filter_type.dart';
import '../filter/filter_args.dart';

final GlobalKey<PagingListViewState> myCoverageAgingListViewKey =
    GlobalKey<PagingListViewState>();

class MyCoverageContent extends StatelessWidget {
  const MyCoverageContent({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  final String moduleName;

  @override
  Widget build(BuildContext context) {
    FilterModel? filterModel;
    try {
      final currentArgs =
      (myCoverageAgingListViewKey.currentState?.pagingController.args ??
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
                PostAuthRoutes.filterCoverage.route.path,
                extra: FilterArgs(
                  teamSearchByFilter: _coverageSearchByFilter,
                  parentBuildContext: context,
                  filterType: FilterType.myCoverage,
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
              SizedBox(
                height: 10.h,
              ),
              const Expanded(
                child: MyCoverageList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _coverageSearchByFilter(FilterModel filterModel, BuildContext context) {
    final currentArgs =
    (myCoverageAgingListViewKey.currentState?.pagingController.args ??
        <dynamic, dynamic>{}) as Map<dynamic, dynamic>;

    currentArgs.addEntries([MapEntry('filterModel', filterModel)]);

    myCoverageAgingListViewKey.currentState?.pagingController
        .updateArg(currentArgs);
  }

}
