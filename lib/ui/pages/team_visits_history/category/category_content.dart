import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/availability/availability_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/planogram/planogram_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/rtv/rtv_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/sos/sos_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_before_fixing/visit_before_fixing_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_capture_photos/visit_capture_photos_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_expiry/visit_expiry_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_price/visit_price_list.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_stock/visit_stock_list.dart';

// final GlobalKey<PagingListViewState> categoryContentPagingListViewKey =
//     GlobalKey<PagingListViewState>();

class CategoryContent extends StatefulWidget {
  const CategoryContent({
    Key? key,
    required this.moduleName,
    required this.teamVisitsHistoryModel,
  }) : super(key: key);
  final String moduleName;
  final TeamVisitsHistoryModel teamVisitsHistoryModel;

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.teamVisitsHistoryModel.visitCompanySLA?.length ?? 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          ],
          headerTitle: "${widget.moduleName} Category",
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children: [
              DefaultTabController(
                length:
                    widget.teamVisitsHistoryModel.visitCompanySLA?.length ?? 0,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: List.generate(
                    widget.teamVisitsHistoryModel.visitCompanySLA?.length ?? 0,
                    (index) => Tab(
                      text: widget.teamVisitsHistoryModel
                          .visitCompanySLA?[index].componentName,
                    ),
                  ),
                  ///dividerColor: white,
                  indicatorColor: white,
                  labelColor: white,

                  /// todo : if u want to click on the tab bar to update from server
                  // onTap: (index) async {
                  //   switch (widget.teamVisitsHistoryModel
                  //       .visitCompanySLA?[index].componentName) {
                  //     case 'RTV':
                  //       await context.read<RTVCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Availability':
                  //       await context
                  //           .read<AvailabilityCubit>()
                  //           .loadItemsAtPage();
                  //       break;
                  //     case 'Share of Shelf':
                  //       await context.read<SOSCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Price Check':
                  //       await context.read<VisitPriceCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Freshness':
                  //       await context
                  //           .read<VisitExpiryCubit>()
                  //           .loadItemsAtPage();
                  //       break;
                  //     case 'Display Stock Check':
                  //       await context.read<VisitStockCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Before Fixing':
                  //       await context.read<VisitBeforeFixingCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Capture Photo':
                  //       await context.read<VisitCapturePhotosCubit>().loadItemsAtPage();
                  //       break;
                  //     case 'Planogram':
                  //       await context.read<PlanoGramCubit>().loadItemsAtPage();
                  //   }
                  // },
                ),
              ),
              // ModuleOnCategory(teamVisitsHistoryModel: teamVisitsHistoryModel),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    widget.teamVisitsHistoryModel.visitCompanySLA?.length ?? 0,
                    (index) {
                      switch (widget.teamVisitsHistoryModel
                          .visitCompanySLA?[index].componentName) {
                        case 'RTV':
                          return RTVList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Availability':
                          return AvailabilityList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Share of Shelf':
                          return SOSList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Price Check':
                          return VisitPriceList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Freshness':
                          return VisitExpiryList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Planogram':
                          return PlanoGramList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Display Stock Check':
                          return VisitStockList(
                              visitId: widget.teamVisitsHistoryModel.details
                                      ?.visitID ??
                                  0);
                        case 'Before Fixing':
                          return const VisitBeforeFixingList();
                        case 'Capture Photo':
                          return const VisitCapturePhotosList();
                      }
                      return const Center(
                        child: Text('Not Available Now'),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  // List<String> getCompanySLA(List<VisitCompanySLA> visitCompanySLA) {
  //   final List<String> companySLAList = [];
  //   for (int i = 0; i < visitCompanySLA.length; i++) {
  //     companySLAList.add(visitCompanySLA[i].componentName ?? '');
  //   }
  //   return companySLAList;
  // }
}
