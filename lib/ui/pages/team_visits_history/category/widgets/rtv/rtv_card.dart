import 'package:c_supervisor/data/models/update_category/update_rtv_model.dart';
import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/rtv/update_rtv_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/rtv/rtv_list.dart';

import '../../../../../../data/models/visits_categories/rtv_model.dart';
import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../../../team_kpi/index.dart';

class RTVCard extends StatefulWidget {
  const RTVCard({
    super.key,
    required this.rtvModel,
    required this.visitId,
  });

  final RTVModel? rtvModel;
  final int? visitId;

  @override
  State<RTVCard> createState() => _RTVCardState();
}

class _RTVCardState extends State<RTVCard> {
  bool isCheckboxChecked = false;

  final TextEditingController rtvCountController = TextEditingController();

  final TextEditingController dateCountController = TextEditingController();

  final userId =
      GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String formatDate(String dateStr) {
    List<String> dateParts = dateStr.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    DateTime date = DateTime(year, month, day);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

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
    rtvCountController.text = widget.rtvModel?.rtvCount.toString() ?? "";
    dateCountController.text =
        formatDate(widget.rtvModel?.date.toString() ?? '');
    return BlocProvider(
      create: (_) =>
          UpdateRtvCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
      child: SizedBox(
        width: 350.w,

        /// height: 200.h,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageViewOnAlert(
                      isExpanded: false,
                      imagePath: widget.rtvModel?.barecodeImage ?? "",
                    ),
                    SizedBox(width: 13.w),
                    Padding(
                      padding: EdgeInsets.only(top: 17.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.rtvModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          SizedBox(height: 7.h),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              '${widget.rtvModel?.barcodeName}',
                              style: TextStyle(fontSize: 13.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            'Barcode : ${widget.rtvModel?.barCode}',
                            style:
                                TextStyle(fontSize: 16.sp, color: primaryColor),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            'Value : ${widget.rtvModel?.rtvVal}',
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            'Count : ${widget.rtvModel?.rtvCount} Pcs',
                            style: TextStyle(fontSize: 16.sp, color: blue),
                          ),
                          SizedBox(height: 7.h),
                          Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                widget.rtvModel?.reason ?? '',
                                style: TextStyle(fontSize: 16.sp, color: red),
                              ),
                              SizedBox(width: 15.w),
                              widget.rtvModel?.reason == "Damaged"
                                  ? const SizedBox()
                                  : Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/calendar_ic.svg'),
                                        SizedBox(width: 7.h),
                                        Text(
                                          widget.rtvModel?.date ?? '',
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Row(),
                                      ],
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showDeleteConfirmationPopup(context),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: greyColor.withOpacity(0.2),
                              child: const Icon(
                                Icons.delete,
                                color: red,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const Text(
                              'Delete',
                              style: TextStyle(color: red),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
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
                                    SizedBox(width: 15.w),
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
                      )
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

  showBottomSheetToEdit(BuildContext context) {
    showModalBottomSheet(
      ///isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) =>
              UpdateRtvCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 400.h,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Delete This RTV',
                      //       style: TextStyle(color: Colors.red, fontSize: 16.0),
                      //     ),
                      //     Checkbox(
                      //       value: isCheckboxChecked,
                      //       onChanged: (bool? newValue) {
                      //         setState(() {
                      //           isCheckboxChecked = newValue ?? false;
                      //           if (isCheckboxChecked) {
                      //             // _showDeleteConfirmationPopup(context);
                      //           }
                      //         });
                      //       },
                      //       activeColor: Colors.red,
                      //     ),
                      //     SizedBox(width: 0.w),
                      //     isCheckboxChecked
                      //         ? Row(
                      //             children: [
                      //               const Icon(Icons.error_outline, color: red),
                      //               Text(
                      //                 'Are You Sure To Delete?',
                      //                 style: TextStyle(
                      //                     fontSize: 12.sp, color: red),
                      //               )
                      //             ],
                      //           )
                      //         : const SizedBox(),
                      //     const Spacer(),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: const CircleAvatar(
                      //         backgroundColor: primaryColor,
                      //         child: Icon(
                      //           Icons.cancel_rounded,
                      //           color: white,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20.h),
                      Text(
                        'Count',
                        style: TextStyle(color: blue, fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: TextFormField(
                          controller: rtvCountController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Text(
                            'RTV Type',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(width: 20.w),
                          Text(
                            widget.rtvModel?.reason ?? "",
                            style: TextStyle(color: red, fontSize: 14.sp),
                          )
                        ],
                      ),
                      SizedBox(height: 20.h),
                      widget.rtvModel?.reason == "Damaged"
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                if (widget.rtvModel?.reason == "Damaged") {
                                  "Date disallowed on rtv damaged".showToast();
                                } else {
                                  _selectDate(
                                    context: context,
                                    currentDate: dateCountController,
                                    closeTomorrowDayOnlyAndPreviousDays:
                                        widget.rtvModel?.reason == "Near Expiry"
                                            ? true
                                            : false,
                                    openAllDays:
                                        widget.rtvModel?.reason == "Expired"
                                            ? true
                                            : false,
                                  );
                                }
                              },
                              child: CustomTextField.withDarkBorder(
                                labelText: 'Date',
                                myController: dateCountController,
                                height: 53.h,
                                keyboardType: TextInputType.emailAddress,
                                isEnabled: false,
                              ),
                            ),
                      SizedBox(height: 40.h),
                      AppBlocConsumer<UpdateRtvCubit,
                          BaseResponse<EmptyModel?>>(
                        onSuccessBuilder: (context, state) {
                          final isLoading =
                              state.status == RequestStatus.loading;
                          return isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: LoadingButton(
                                    onPressed: () => update(context, false),
                                    text: 'Update',
                                    btnWidth: 200.w,
                                    btnHeight: 40.h,
                                  ),
                                );
                        },
                        isConsumerAction: true,
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

  void _showDeleteConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) =>
              UpdateRtvCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Delete Confirmation'),
              content: const Text('Are you sure ?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                AppBlocConsumer<UpdateRtvCubit, BaseResponse<EmptyModel?>>(
                  onSuccessBuilder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;
                    return isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : TextButton(
                            child: const Text('Delete'),
                            onPressed: () {
                              update(context, true);
                            },
                          );
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Future<void> _selectDate({
    required BuildContext context,
    required TextEditingController currentDate,

    ///[openAllDays] =>> to allow user to select a date of any day
    required bool openAllDays,

    ///[closeTomorrowDayOnly] =>> to prevent user to select a day of previous now and tomorrow day of now
    required bool closeTomorrowDayOnlyAndPreviousDays,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime tomorrow = today.add(const Duration(days: 1));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: closeTomorrowDayOnlyAndPreviousDays ? today : DateTime(2015),
      lastDate: DateTime(2100),
      selectableDayPredicate: closeTomorrowDayOnlyAndPreviousDays
          ? (DateTime date) {
              return !date.isBefore(today) && !date.isAtSameMomentAs(tomorrow);
            }
          : null,
    );
    if (picked != null) {
      final DateFormat dateFormat =
          DateFormat('yyyy-MM-dd'); // Define the date format
      final String formattedDate =
          dateFormat.format(picked); // Format the selected date

      currentDate.text =
          formattedDate; // Assign the formatted date to the text controller
    }
  }

  void update(
    BuildContext context,
    bool isDelete,
  ) {
    context
        .read<UpdateRtvCubit>()
        .updateRtv(
          model: UpdateRtvModel(
            id: widget.rtvModel?.id,
            userId: userId,
            delete: isDelete,
            rtvCount: int.parse(rtvCountController.text),
            rtvType: getRtvType(widget.rtvModel?.reason ?? ''),
            date: dateCountController.text,
            visitID: widget.visitId,
            lng: LocationManager.currentPosition?.longitude.toString(),
            lat: LocationManager.currentPosition?.latitude.toString(),
          ),
        )
        .then((value) {
      if (!value.hasError) {
        Navigator.pop(context);
        refreshIndicatorRtvKey.currentState?.show();
      } else {
        Navigator.pop(context);
      }
    });
  }

  int getRtvType(String reason) {
    switch (reason) {
      case "Damaged":
        return 1;
      case "Expired":
        return 2;
      case "Near Expiry":
        return 3;
      default:
        return 0;
    }
  }
}
