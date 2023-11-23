import 'package:flutter/material.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
class TeamKPIHeader extends StatelessWidget {
  const TeamKPIHeader({Key? key}) : super(key: key);

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
          height: 140.h,
          width: double.infinity,
          child: AppBlocConsumer<TeamKPIChartDataCubit,
              BaseResponse<ChartDataList?>>(
            onSuccessBuilder: (context, state) {
              final isLoading = state.status == RequestStatus.loading;
              return Center(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : KPIChartList(
                          chartDataList: state.value?.data?.dataList ?? [],
                        ));
            },
            errorWidgetPadding: EdgeInsets.zero,
          ),
        ));
  }
}

class KPIChartList extends StatelessWidget {
  const KPIChartList({Key? key, this.chartDataList}) : super(key: key);
  final List<ChartDataModel>? chartDataList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chartDataList?.length ?? 0,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => KPIChartCard(
              value:
                  chartDataList?[index].valueInPercentage?.round().toString() ??
                      'N/A',
              color:
                  Color(int.parse(chartDataList?[index].color?.trim() ?? '')),
              title: chartDataList?[index].title ?? 'N/A',
            ));
  }
}

class KPIChartCard extends StatelessWidget {
  const KPIChartCard({
    Key? key,
    required this.value,
    required this.color,
    required this.title,
  }) : super(key: key);
  final String value;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: lightgray_2, width: 1.w),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 95.w,
            height: 90.h,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: lightgray_2,
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: -5.0,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Center(
                child: Text(
              '$value%',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color, fontSize: 14.sp),
            )),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

// class BarChartSample1 extends StatefulWidget {
//   const BarChartSample1({super.key});
//
//   List<Color> get availableColors => const <Color>[
//         Colors.purpleAccent,
//         Colors.yellow,
//         Colors.lightBlue,
//         Colors.orange,
//         Colors.pink,
//         Colors.redAccent,
//       ];
//
//   @override
//   State<StatefulWidget> createState() => BarChartSample1State();
// }
//
// class BarChartSample1State extends State<BarChartSample1> {
//   final Color barBackgroundColor = const Color(0xff72d8bf);
//   final Duration animDuration = const Duration(milliseconds: 250);
//
//   int touchedIndex = -1;
//
//   bool isPlaying = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//       child: BarChart(
//         mainBarData(),
//       ),
//     );
//   }
//
//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     Color barColor = Colors.blue,
//     double width = 16,
//     List<int> showTooltips = const [],
//   }) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y,
//           width: width,
//           color: blue,
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: 100,
//             color: primaryColor,
//           ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }
//
//   List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(
//               0,
//               50,
//             );
//           case 1:
//             return makeGroupData(
//               1,
//               60,
//             );
//           case 2:
//             return makeGroupData(
//               2,
//               10,
//             );
//           default:
//             return throw Error();
//         }
//       });
//
//   BarChartData mainBarData() {
//     return BarChartData(
//       alignment: BarChartAlignment.spaceEvenly,
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: getTitles,
//             reservedSize: 30,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: showingGroups(),
//       gridData: FlGridData(show: false),
//     );
//   }
//
//   Widget getTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 10,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('(123) JPC 100%', style: style);
//         break;
//       case 1:
//         text = const Text('(123) PRO 100%', style: style);
//         break;
//       case 2:
//         text = const Text('(123) EEF 100%', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 12,
//       child: text,
//     );
//   }
// }
