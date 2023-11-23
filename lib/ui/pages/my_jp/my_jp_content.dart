import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/widgets/jp_list.dart';

import 'package:fl_chart/fl_chart.dart';

class MyJPContent extends StatelessWidget {
  const MyJPContent({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  final String moduleName;



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
          ],
          headerTitle: moduleName,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: const Column(
            children: [
              // RefreshIndicator(
              //   key: refreshIndicatorPieChartKey,
              //   onRefresh: () => _refreshData(context),
              //   child: Card(
              //     color: Colors.white,
              //     semanticContainer: true,
              //     clipBehavior: Clip.antiAliasWithSaveLayer,
              //     shadowColor: Colors.black12,
              //     elevation: 10,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //     ),
              //     child: SizedBox(
              //       height: 135.h,
              //       width: double.infinity,
              //       child: AppBlocConsumer<MyJPCountCubit,
              //           BaseResponse<SupVisitsCountListModel?>>(
              //         onSuccessBuilder: (context, state) {
              //           final isLoading = state.status == RequestStatus.loading;
              //           return isLoading
              //               ? const Center(child: CircularProgressIndicator())
              //               : Row(
              //                   children: [
              //                     _barChart(
              //                       state.value?.data?.dataList[0].finished ?? 0,
              //                       state.value?.data?.dataList[0].inProgress ??
              //                           0,
              //                       state.value?.data?.dataList[0].pending ?? 0,
              //                     ),
              //                     // Spacer(),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 height: 13.h,
              //                                 width: 15.w,
              //                                 color: Colors.green,
              //                                 //child: Text('fff'),
              //                               ),
              //                               SizedBox(width: 5.w),
              //                               Text("Finished")
              //                             ],
              //                           ),
              //                           SizedBox(height: 10.h),
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 height: 13.h,
              //                                 width: 15.w,
              //                                 color: blue,
              //                                 //child: Text('fff'),
              //                               ),
              //                               SizedBox(width: 5.w),
              //                               Text("In Progress")
              //                             ],
              //                           ),
              //                           SizedBox(height: 10.h),
              //                           Row(
              //                             children: [
              //                               Container(
              //                                 height: 13.h,
              //                                 width: 15.w,
              //                                 color: red,
              //                                 //child: Text('fff'),
              //                               ),
              //                               SizedBox(width: 5.w),
              //                               Text("Pending")
              //                             ],
              //                           ),
              //                           const Spacer(),
              //                           Text(
              //                               "Total Visits : ${(state.value?.data?.dataList[0].finished ?? 0) + (state.value?.data?.dataList[0].inProgress ?? 0) + (state.value?.data?.dataList[0].pending ?? 0)}")
              //                         ],
              //                       ),
              //                     )
              //                   ],
              //                 );
              //         },
              //         errorWidgetPadding: EdgeInsets.zero,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10.h),
              Expanded(
                child: JPList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barChart(
    int numOfVisitFinished,
    int numOfVisitInProgress,
    int numOfVisitNotStarted,
  ) {
    return Center(
      child: SizedBox(
        width: 200.0.w,
        child: PieChart(
          PieChartData(
            centerSpaceRadius: 12,
            borderData: FlBorderData(show: false),
            sections: [
              PieChartSectionData(
                value: numOfVisitFinished.toDouble(),
                color: Colors.green,
                radius: 50.r,
                titleStyle: const TextStyle(color: white),
              ),
              PieChartSectionData(
                value: numOfVisitInProgress.toDouble(),
                color: blue,
                radius: 50.r,
                titleStyle: const TextStyle(color: white),
              ),
              PieChartSectionData(
                value: numOfVisitNotStarted.toDouble(),
                color: red,
                radius: 50.r,
                titleStyle: const TextStyle(color: white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
