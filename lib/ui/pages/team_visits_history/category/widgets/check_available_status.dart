import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../../../../../data/models/update_category/update_availability_model.dart';
import '../cubits/availability/update_availability_cubit.dart';
import 'index.dart';

class CheckAvailableStatus extends StatelessWidget {
  const CheckAvailableStatus({
    super.key,
    required this.availabilityModel,
  });

  final AvailabilityModel availabilityModel;

  @override
  Widget build(BuildContext context) {
    switch (availabilityModel.available) {
      case "Not Available":
        return Row(
          children: [
            SvgPicture.asset('assets/icons/cancel_circle.svg'),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${availabilityModel.available}',
              style: TextStyle(
                color: red,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      case "Available":
        return Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 16,
            ),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${availabilityModel.available}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.sp,
              ),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  openAlertRate(BuildContext context) {
    // double rateValue = 0.0;
    // final int visitId = teamVisitsHistoryModel.details?.visitID ?? 0;
    // final int userId =
    //     GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider<UpdateAvailabilityCubit>(
          create: (_) => UpdateAvailabilityCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0.r)),
            ),
            contentPadding: EdgeInsets.only(top: 10.0.h),
            content: SizedBox(
              width: 300.0.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 5.0.h),
                  Divider(color: Colors.grey, height: 4.0.h),
                  AppBlocConsumer<UpdateAvailabilityCubit,
                      BaseResponse<EmptyModel?>>(
                    onSuccessBuilder: (context, state) {
                      final isLoading = state.status == RequestStatus.loading;
                      return isLoading
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                update(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 20.0.h,
                                  bottom: 20.0.h,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(32.0.r),
                                      bottomRight: Radius.circular(32.0.r)),
                                ),
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                    },
                    isConsumerAction: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void update(
    BuildContext context,
  ) {
    context.read<UpdateAvailabilityCubit>().updateAvailability(
          model: UpdateAvailabilityModel(
            available: true,
            id: availabilityModel.id,
            userId: 7,
          ),
        );
  }
}
