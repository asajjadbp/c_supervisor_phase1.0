import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/data/models/sup_visits/visit_count/sup_visits_list_count_model.dart';

import 'package:c_supervisor/ui/common_reusable/module_list/module_card.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/my_jp_count_cubit.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';


class ModuleList extends StatefulWidget {
   ModuleList({
    Key? key,
    required this.modules,
    required this.isMainModule,
  }) : super(key: key);

  final GlobalKey<RefreshIndicatorState> refreshIndicatorMainDashBoardKey =
  GlobalKey<RefreshIndicatorState>();
  final List<DashboardModule> modules;
  final bool isMainModule;

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> with UserInfoMixin {
  Future<void> _refreshData(BuildContext context) async {
    context.read<MyJPCountCubit>().getSupVisitsCount(
          userId: getUserId(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.refreshIndicatorMainDashBoardKey,
      onRefresh: () => _refreshData(context),
      child: GridView.builder(
        itemCount: widget.modules.length,
        // shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (163.5.h / 135.h),
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (widget.isMainModule && index == 0) {
            return AppBlocConsumer<MyJPCountCubit,
                BaseResponse<SupVisitsCountListModel?>>(
              onSuccessBuilder: (context, state) {
                final bool isLoading = state.status == RequestStatus.loading;

                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: ModuleCard(
                          dashboardModule: widget.modules[index],
                          isMainModule: widget.isMainModule,
                          haveData: true,
                          dataModel: state.value?.data?.dataList[0],
                        ),
                      );
              },
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: ModuleCard(
                haveData: false,
                dashboardModule: widget.modules[index],
                isMainModule: widget.isMainModule,
              ),
            );
          }
        },
      ),
    );
  }
}
