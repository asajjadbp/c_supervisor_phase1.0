import 'package:c_supervisor/data/data_sources/local/app_shared_prefs_client.dart';
import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/ui/bloc/app_bloc_consumer.dart';
import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:c_supervisor/ui/pages/dashboards/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:networking/client/networking_models/index.dart';

class MainDashboardContent extends StatelessWidget {
  const MainDashboardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<DashboardCubit,
        BaseResponse<List<DashboardModule>?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        return BrandReusable.withAnyHeader(
          isWidgetStacked: true,
          header: AppHeader(
            prefixHeaderWidgets: const [
              // SvgPicture.asset(
              //   'assets/icons/back_ic.svg',
              // ),
              DrawerIconButton()
            ],
            headerTitle:
                'Welcome ${GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.fullName}',
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ModuleList(
                    modules: state.value?.data ?? [],
                    isMainModule: true,
                  ),
                ),
        );
      },
    );
  }
}
