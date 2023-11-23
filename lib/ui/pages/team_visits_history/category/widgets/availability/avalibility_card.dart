import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/availability/cancel_availability_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/availability/confirm_availability_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/availability/update_availability_cubit.dart';
import 'package:c_supervisor/utilities/mixins/location_methods.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../data/models/empty_model.dart';
import '../../../../../../data/models/update_category/update_availability_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../common_reusable/image_view.dart';
import '../check_available_status.dart';
import '../index.dart';
import 'availability_list.dart';

class AvailabilityCard extends StatefulWidget {
  const AvailabilityCard({
    Key? key,
    required this.index,
    required this.availabilityModel,
    required this.visitId,
  }) : super(key: key);
  final AvailabilityModel availabilityModel;
  final int index;
  final int visitId;

  @override
  State<AvailabilityCard> createState() => _AvailabilityCardState();
}

class _AvailabilityCardState extends State<AvailabilityCard>
    with UserInfoMixin {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  bool isCheckboxChecked = false;
  bool checkBoxChangedState = false;

  @override
  void initState() {
    super.initState();
    getLocation(context);
  }

  getLocation(BuildContext context) async {
    await LocationManager.getCurrentPosition(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UpdateAvailabilityCubit(
            updateCategoryUC: GetIt.I<UpdateCategoryUC>(),
          ),
        ),
        BlocProvider(
          create: (_) => ConfirmAvailabilityCubit(
            updateCategoryUC: GetIt.I<UpdateCategoryUC>(),
          ),
        ),
      ],
      child: SizedBox(
        width: 350.w,
        height: 200.h,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageViewOnAlert(
                        isExpanded: false,
                        imagePath: widget.availabilityModel.barecodeImage ?? '',
                      ),
                      SizedBox(width: 13.w),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                '${widget.availabilityModel.productName}',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              'Barcode : ${widget.availabilityModel.barCode}',
                              style: TextStyle(
                                  fontSize: 16.sp, color: primaryColor),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              widget.availabilityModel.stokeliststatus!
                                      .contains('MSL')
                                  ? 'MSL'
                                  : 'Not Msl',
                              style: TextStyle(
                                  fontSize: 16.sp, color: primaryColor),
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              children: [
                                CheckAvailableStatus(
                                  availabilityModel: widget.availabilityModel,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // AppBlocConsumer<ConfirmAvailabilityCubit,
                      //     BaseResponse<ConfirmSuccessResponseModel?>>(
                      //   onSuccessBuilder: (context, state) {
                      //     return LoadingButton(
                      //       text: 'Confirm',
                      //       isLoading: _isLoading.value,
                      //       borderRadius: 7.r,
                      //       btnColor: primaryColor,
                      //       btnHeight: 40.h,
                      //       btnWidth: 120.w,
                      //       isDisabled: false,
                      //       onPressed: () {
                      //         confirmUpdateAvailability();
                      //       },
                      //     );
                      //   },
                      //   isConsumerAction: true,
                      // ),
                      AppBlocConsumer<ConfirmAvailabilityCubit,
                          BaseResponse<ConfirmSuccessResponseModel?>>(
                        onSuccessBuilder: (context, state) {
                          return LoadingButton(
                            text: 'Cancel',
                            isLoading: _isLoading.value,
                            borderRadius: 7.r,
                            btnColor: primaryColor,
                            btnHeight: 40.h,
                            btnWidth: 120.w,
                            isDisabled: false,
                            onPressed: () {
                              cancelUpdateAvailability();
                            },
                          );
                        },
                        isConsumerAction: true,
                      ),
                      InkWell(
                        onTap: () {
                          showBottomSheetToEdit(context);
                        },
                        child: SizedBox(
                          width: 120.w,
                          child: Card(
                            color: primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: white,
                                    size: 15.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  const Text(
                                    'Update',
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  showBottomSheetToEdit(BuildContext context) {
    showModalBottomSheet(
      ///isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => UpdateAvailabilityCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                //height: 600.h,
                height: 300.h,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Icon(
                                Icons.cancel_rounded,
                                color: white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Update to ${widget.availabilityModel.available == "Not Available" ? "Available" : "Not Available"}',
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: widget.availabilityModel.available ==
                                        "Not Available"
                                    ? Colors.green
                                    : red),
                          ),
                          Checkbox(
                            value: isCheckboxChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isCheckboxChecked = newValue ?? false;
                                checkBoxChangedState = true;
                              });
                            },
                            activeColor: widget.availabilityModel.available ==
                                    "Not Available"
                                ? Colors.green
                                : red,
                          ),
                        ],
                      ),
                      SizedBox(height: 70.h),
                      AppBlocConsumer<UpdateAvailabilityCubit,
                          BaseResponse<EmptyModel?>>(
                        onSuccessBuilder: (context, state) {
                          final isLoading =
                              state.status == RequestStatus.loading;
                          return isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : LoadingButton(
                                  onPressed: () {
                                    if (checkBoxChangedState) {
                                      update(context);
                                    } else {
                                      "Please press on the check box to update"
                                          .showToast();
                                    }
                                  },
                                  text: 'Update',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: white,
                                  ),
                                  btnWidth: 200.w,
                                  btnHeight: 40.h,
                                );
                        },
                        isConsumerAction: true,
                        showErrorAsWidget: true,
                        showNoticeOnSuccess: true,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///
  void update(BuildContext context) async {
    context
        .read<UpdateAvailabilityCubit>()
        .updateAvailability(
            model: UpdateAvailabilityModel(
          userId: getUserId(),
          id: widget.availabilityModel.id,
          available: widget.availabilityModel.available == "Not Available"
              ? true
              : false,
          visitID: widget.visitId,
          lng: LocationManager.currentPosition?.longitude.toString(),
          lat: LocationManager.currentPosition?.latitude.toString(),
        ))
        .then((value) {
      if (!value.hasError) {
        Navigator.pop(context);
        refreshIndicatorAvailableKey.currentState?.show();
      } else {
        Navigator.pop(context);
      }
    });
  }

  ///
  void confirmUpdateAvailability() async {
    _isLoading.value = true;
    final result = await context
        .read<ConfirmAvailabilityCubit>()
        .confirmUpdateAvailability(
          id: widget.availabilityModel.id ?? 0,
          userId: getUserId(),
        );
    _isLoading.value = false;
  }

  void cancelUpdateAvailability() async {
    _isLoading.value = true;
    final result =
        await context.read<CancelAvailabilityCubit>().cancelUpdateAvailability(
              id: widget.availabilityModel.id ?? 0,
              userId: getUserId(),
            );
    _isLoading.value = false;

    String mss = result.message ?? "";
    if (mss == "Canceled") {
      mss.showToast(
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
      );

      /// todo refresh
    } else {
      mss.showToast(
        gravity: ToastGravity.CENTER,
        backgroundColor: red,
      );
    }
  }
}
