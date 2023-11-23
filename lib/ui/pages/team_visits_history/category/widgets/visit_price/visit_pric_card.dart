import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_price/visit_price_list.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:flutter_core/widgets/loading_button.dart';

import '../../../../../../data/models/empty_model.dart';
import '../../../../../../data/models/update_category/update_price_model.dart';
import '../../../../../../data/models/visits_categories/visit_price_model.dart';
import '../../../../../../domain/use_cases/update_category/update_category_uc.dart';
import '../../../../../../utilities/mixins/location_methods.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';
import '../../cubits/price_check/update_price_cubit.dart';

class VisitPriceCard extends StatefulWidget {
  const VisitPriceCard({
    super.key,
    required this.visitPriceModel,
    required this.visitId,
  });

  final int visitId;
  final VisitPriceModel? visitPriceModel;

  @override
  State<VisitPriceCard> createState() => _VisitPriceCardState();
}

class _VisitPriceCardState extends State<VisitPriceCard> {
  //bool isCheckboxChecked = false;

  final TextEditingController priceController = TextEditingController();

  final TextEditingController promotionPriceController =
      TextEditingController();

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
    priceController.text = widget.visitPriceModel?.price.toString() ?? "";
    promotionPriceController.text =
        widget.visitPriceModel?.promotionPrice.toString() ?? "";
    return SizedBox(
      width: 350.w,
      //height: 150.h,
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
                    imagePath: widget.visitPriceModel?.barecodeImage ?? "",
                    isExpanded: false,
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
                            '${widget.visitPriceModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Barcode : ${widget.visitPriceModel?.barCode}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Price : ${widget.visitPriceModel?.price}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Promotion Price : ${widget.visitPriceModel?.promotionPrice}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                        Row(
                          children: [
                            Text(
                              'Variation : ${widget.visitPriceModel?.priceVariation}',
                              style: TextStyle(
                                  fontSize: 16.sp, color: primaryColor),
                            ),
                            SizedBox(width: 15.w),
                            (widget.visitPriceModel!.priceVariation! < 0)
                                ? Icon(
                                    Icons.arrow_downward_outlined,
                                    size: 17.sp,
                                    color: red,
                                  )
                                : Icon(
                                    Icons.arrow_upward_outlined,
                                    size: 17.sp,
                                    color: Colors.green,
                                  ),
                          ],
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'RSP : ${widget.visitPriceModel?.rsp}',
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
                        const Text('Delete',style: TextStyle(color: red),)
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
          create: (_) =>
              UpdatePriceCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
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
                    AppBlocConsumer<UpdatePriceCubit, BaseResponse<EmptyModel?>>(
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
        return BlocProvider<UpdatePriceCubit>(
          create: (_) =>
              UpdatePriceCubit(updateCategoryUC: GetIt.I<UpdateCategoryUC>()),
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
                        'Price',
                        style: TextStyle(color: blue, fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Promotion Price',
                        style: TextStyle(color: blue, fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 200.w,
                        child: TextFormField(
                          controller: promotionPriceController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      AppBlocConsumer<UpdatePriceCubit,
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
                                      context: context,
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

  void update({
    required BuildContext context,
    required bool isDelete,
    required bool isPopContext,
}) {
    context
        .read<UpdatePriceCubit>()
        .updatePriceCheck(
          model: UpdatePriceModel(
            id: widget.visitPriceModel?.id,
            userId: 7,
            delete: isDelete,
            price: num.parse(priceController.text),
            promotionPrice: num.parse(promotionPriceController.text),
            visitID: widget.visitId,
            lng: LocationManager.currentPosition?.longitude.toString(),
            lat: LocationManager.currentPosition?.latitude.toString(),
          ),
        )
        .then((value) {
      if (!value.hasError) {
        Navigator.pop(context);
        refreshIndicatorPriceKey.currentState?.show();
      } else {
        Navigator.pop(context);
      }
    });
  }
}
