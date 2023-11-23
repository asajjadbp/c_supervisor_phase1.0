import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/data/models/sup_visits/visit_count/sup_visits_count_model.dart';
import 'package:c_supervisor/di/environment_type.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/widgets/custom_cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({
    Key? key,
    required this.dashboardModule,
    required this.isMainModule,
    required this.haveData,
    this.dataModel,
  }) : super(key: key);
  final DashboardModule dashboardModule;
  final bool isMainModule;
  final bool haveData;
  final SupVisitsCountModel? dataModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isMainModule
            ? dashboardModule.mainModule.navigateToMainModule(
                context: context, moduleName: dashboardModule.slaname ?? '')
            : dashboardModule.teamModule.navigateToTeamModule(
                context: context, moduleName: dashboardModule.slaname ?? '');
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.black12,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCachedNetworkImage(
                  height: 54.h,
                  width: 54.w,
                  boxFit: BoxFit.contain,
                  imgUrl: EnvironmentType.development.environment.baseURL +
                      (dashboardModule.imagePath ?? ''),
                  placeholderPath: 'placeholderPath',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Text(dashboardModule.slaname ?? ''),
                ),
              ],
            ),
            haveData
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BuildDataWidget(
                            numOfVisit: "${dataModel?.finished ?? ""}",
                            backgroundColor: Colors.green,
                          ),
                          BuildDataWidget(
                            numOfVisit: "${dataModel?.inProgress ?? ""}",
                            backgroundColor: blue,
                          ),
                          BuildDataWidget(
                            numOfVisit: "${dataModel?.pending ?? ""}",
                            backgroundColor: red,
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class BuildDataWidget extends StatelessWidget {
  const BuildDataWidget({
    super.key,
    required this.numOfVisit,
    required this.backgroundColor,
  });

  final String numOfVisit;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: 15.r,
      child: Center(
        child: Text(
          numOfVisit,
          style: TextStyle(
            color: white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
