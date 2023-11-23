import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_stock/visit_stock_list.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_core/widgets/loading_button.dart';

import '../../../../../../data/models/empty_model.dart';
import '../../../../../../data/models/update_category/update_stock_model.dart';
import '../../../../../../data/models/visits_categories/visit_stock_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../cubits/visit_stock/update_visit_stock_cubit.dart';

class VisitStockCard extends StatefulWidget {
  const VisitStockCard({
    super.key,
    required this.visitStockModel,
    required this.visitId,
  });

  final VisitStockModel? visitStockModel;
  final int visitId;

  @override
  State<VisitStockCard> createState() => _VisitStockCardState();
}

class _VisitStockCardState extends State<VisitStockCard> {
  //bool isCheckboxChecked = false;

  final TextEditingController rtvCountController = TextEditingController();

  final userId =
      GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
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
    rtvCountController.text = widget.visitStockModel?.count.toString() ?? '';

    return SizedBox(
      width: 350.w,
      //height: 180.h,
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
                    imagePath: widget.visitStockModel?.barecodeImage ?? "",
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
                            '${widget.visitStockModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        SizedBox(height: 7.h),
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            '${widget.visitStockModel?.barcodeName}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Barcode : ${widget.visitStockModel?.barCode}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Value : ${widget.visitStockModel?.value}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Count : ${widget.visitStockModel?.count?.toDouble()}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 10.h),
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
          create: (_) => UpdateVisitStockCubit(
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
                AppBlocConsumer<UpdateVisitStockCubit,
                    BaseResponse<EmptyModel?>>(
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
          create: (_) => UpdateVisitStockCubit(
              updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
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
                        'Barcode Count',
                        style: TextStyle(color: blue, fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: TextFormField(
                          controller: rtvCountController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 100.h),
                      AppBlocConsumer<UpdateVisitStockCubit,
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
                                        isPopContext: true,
                                        isDelete: false,
                                        context: context),
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

  void update({
    required BuildContext context,
    required bool isDelete,
    required bool isPopContext,
  }) {
    context
        .read<UpdateVisitStockCubit>()
        .updateVisitStock(
            model: UpdateStockModel(
          id: widget.visitStockModel?.id,
          userId: userId,
          delete: isDelete,
          count: int.parse(rtvCountController.text),
          visitID: widget.visitId,
          lng: LocationManager.currentPosition?.longitude.toString(),
          lat: LocationManager.currentPosition?.latitude.toString(),
        ))
        .then(
      (value) {
        if (!value.hasError) {
          Navigator.pop(context);
          refreshIndicatorStockListKey.currentState?.show();
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
