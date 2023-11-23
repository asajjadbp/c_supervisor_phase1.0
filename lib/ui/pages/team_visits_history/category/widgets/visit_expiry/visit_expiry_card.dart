import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/visit_expiry/update_freshness_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_expiry/visit_expiry_list.dart';

import '../../../../../../data/models/update_category/update_freshness_model.dart';
import '../../../../../../data/models/visits_categories/visit_expiry_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../index.dart';
import '../../../../team_kpi/index.dart';

class VisitExpiryCard extends StatefulWidget {
  const VisitExpiryCard({
    super.key,
    required this.visitExpiryModel,
    required this.visitId,
  });
  final int visitId;

  final VisitExpiryModel? visitExpiryModel;

  @override
  State<VisitExpiryCard> createState() => _VisitExpiryCardState();
}

class _VisitExpiryCardState extends State<VisitExpiryCard> {
  //bool isCheckboxChecked = false;

  final TextEditingController rtvCountController = TextEditingController();

  final TextEditingController dateCountController = TextEditingController();

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
    rtvCountController.text = widget.visitExpiryModel?.excount.toString() ?? '';
    dateCountController.text =
        widget.visitExpiryModel?.pExpireDate.toString() ?? '';
    return SizedBox(
      width: 350.w,

      ///height: 170.h,
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
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w, top: 15.h),
                    child: Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: greyColor.withOpacity(0.5),
                        ),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: CustomCachedNetworkImage(
                            imgUrl:
                                "https://testapi.catalist-me.com/${widget.visitExpiryModel?.barecodeImage}",
                            placeholderPath: '',
                            height: 50.h,
                            width: 50.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Padding(
                    padding: EdgeInsets.only(top: 17.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${widget.visitExpiryModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            ///todo:overflow text
                            overflow: TextOverflow.ellipsis,
                            '${widget.visitExpiryModel?.barcodeName}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Barcode : ${widget.visitExpiryModel?.barCode}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Count : ${widget.visitExpiryModel?.excount}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Value : ${widget.visitExpiryModel?.exVal}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/calendar_ic.svg'),
                    SizedBox(
                      width: 7.h,
                    ),
                    Text(
                      widget.visitExpiryModel?.pExpireDate ?? '',
                      style: TextStyle(
                        color: black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => UpdateFreshnessCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
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
                AppBlocConsumer<UpdateFreshnessCubit,
                    BaseResponse<EmptyModel?>>(
                  isConsumerAction: true,
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
                              update(
                                context: context,
                                isDelete: true,
                                isPopContext: true,
                              );
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

  showBottomSheetToEdit(BuildContext context) {
    showModalBottomSheet(
      ///isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => UpdateFreshnessCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                //height: 600.h,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 20.h),
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
                      InkWell(
                        onTap: () {
                          _selectDate(context, true, dateCountController);
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
                      AppBlocConsumer<UpdateFreshnessCubit,
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
                                    onPressed: () => update(
                                      context: context,
                                      isDelete: false,
                                      isPopContext: true,
                                    ),
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

  Future<void> _selectDate(BuildContext context, bool isStartDate,
      TextEditingController currentDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
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

  void update({
    required BuildContext context,
    required bool isDelete,
    required bool isPopContext,
  }) {
    context
        .read<UpdateFreshnessCubit>()
        .updateFreshness(
            model: UpdateFreshnessModel(
          id: widget.visitExpiryModel?.id,
          userId: 7,
          delete: isDelete,
          count: int.parse(rtvCountController.text),
          date: widget.visitExpiryModel?.pExpireDate ?? "",
          visitID: widget.visitId,
          lng: LocationManager.currentPosition?.longitude.toString(),
          lat: LocationManager.currentPosition?.latitude.toString(),
        ))
        .then(
      (value) {
        if (!value.hasError) {
          Navigator.pop(context);
          refreshIndicatorFreshnessKey.currentState?.show();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

///
/// 180485 visit test
