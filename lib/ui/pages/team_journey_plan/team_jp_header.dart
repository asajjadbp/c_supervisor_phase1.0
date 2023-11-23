import 'package:c_supervisor/data/models/chart_data_list.dart';
import 'package:c_supervisor/data/models/chart_data_model.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:networking/client/networking_models/index.dart';

import 'cubits/charts_data_cubit.dart';

class TeamJPHeader extends StatelessWidget {
  const TeamJPHeader({Key? key}) : super(key: key);

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
          height: 135.h,
          width: double.infinity,
          child: AppBlocConsumer<TeamJPChartDataCubit, BaseResponse<ChartDataList?>>(
            onSuccessBuilder: (context, state) {
              final isLoading = state.status == RequestStatus.loading;
              return Center(
                  child: TeamHeaderChart(
                isLoading: isLoading,
                chartDataList: state.value?.data?.dataList ?? [],
              ));
            },
            errorWidgetPadding: EdgeInsets.zero,
          ),
        ));
  }
}

class TeamHeaderChart extends StatefulWidget {
  const TeamHeaderChart({
    super.key,
    required this.isLoading,
    required this.chartDataList,
  });

  final bool isLoading;
  final List<ChartDataModel> chartDataList;

  @override
  State<StatefulWidget> createState() => TeamHeaderChartState();
}

class TeamHeaderChartState extends State<TeamHeaderChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 10,
          child: widget.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 30,
                    sections: showingSections(),
                  ),
                ),
        ),
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: VerticalDivider(
                color: lightGrey.withAlpha(80),
                thickness: 1,
              ),
            )),
        Flexible(
          flex: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: widget.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: widget.chartDataList.length,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (ctx, index) {
                            return Indicator(
                              color: Color(int.parse(
                                  widget.chartDataList[index].color?.trim() ??
                                      '')),
                              text: widget.chartDataList[index].title ?? '',
                              isSquare: true,
                              count: widget.chartDataList[index].count ?? 0,
                              percentage: widget
                                      .chartDataList[index].valueInPercentage
                                      ?.toDouble() ??
                                  0.0,
                            );
                          })),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0.h),
                child: Text(
                  'Total Visits: ${widget.chartDataList.isNotEmpty ? widget.chartDataList.map((data) => data.count).reduce((value, element) => value! + element!) : ''}',
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.chartDataList.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 30.0 : 20.0;
      return PieChartSectionData(
        color: Color(int.parse(widget.chartDataList[i].color?.trim() ?? '')),
        value: widget.chartDataList[i].valueInPercentage?.toDouble(),
        radius: radius,
        showTitle: false,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.count,
    required this.percentage,
    required this.isSquare,
    this.size = 14,
    this.textColor = const Color(0xff505050),
  });

  final Color color;
  final String text;
  final int count;
  final double percentage;
  final bool isSquare;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Row(
            children: [
              Text(
                ' ($count) ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                ' ${percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
