import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:c_supervisor/ui/pages/dashboards/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamDashboardContent extends StatelessWidget {
  const TeamDashboardContent({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;
  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<DashboardCubit,
        BaseResponse<List<DashboardModule>?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        return BrandReusable.withAnyHeader(
          isWidgetStacked: true,
          header: AppHeader(
            prefixHeaderWidgets: [
              const BackIconButton(),
              SizedBox(
                width: 15.w,
              ),
              const DrawerIconButton(),
            ],
            headerTitle: moduleName,
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ModuleList(
                    modules: state.value?.data ?? [],
                    isMainModule: false,
                  ),
                ),
        );
      },
    );
  }
}
