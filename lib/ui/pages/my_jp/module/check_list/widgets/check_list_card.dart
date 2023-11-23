import 'package:c_supervisor/data/models/sup_visits/modules/check_list/checklist_model.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter_core/widgets/loading_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../data/models/sup_visits/to_json/checklist_to_json_model.dart';
import '../../../../../index.dart';
import '../cubits/update_checklist_cubit.dart';
import 'checklist_list.dart';

class CheckListCard extends StatefulWidget {
  const CheckListCard({
    super.key,
    required this.model,
    required this.visitId,
    required this.index,
    required this.onCheckboxChanged, // Initialize the callback
    required this.commentsCardChanged, // Initialize the callback
    required this.rateCardChanged, // Initialize the callback
  });
  final CheckListModel? model;
  final int visitId;
  final int index;
  final Function(bool) onCheckboxChanged; // Add this callback
  final Function(String) commentsCardChanged; // Add this callback
  final Function(double) rateCardChanged; // Add this callback

  @override
  State<CheckListCard> createState() => _CheckListCardState();
}

class _CheckListCardState extends State<CheckListCard> {
  TextEditingController commentController = TextEditingController();
  bool isChecked = false;
  String rateVisit = "";
  bool loading = false;
  @override
  void initState() {
    super.initState();
    initialTextDta(widget.model);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                validateCheckedOrNot(widget.model),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      validateRequiredOrNot(widget.model),
                      SizedBox(height: 5.h),
                      Text(
                        widget.model?.checkItemName ?? '',
                      ),
                      SizedBox(height: 5.h),
                      RatingBar.builder(
                        updateOnDrag: false,
                        ignoreGestures: true,
                        initialRating: widget.model?.rate?.toDouble() ?? 0.0,
                        itemSize: 18.sp,
                        direction: Axis.horizontal,
                        //allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: primaryColor,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ExpandChild(
                indicatorIconSize: 30.sp,
                indicatorAlignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 14.0),
                          child: Text(
                            'Check : ',
                            style: TextStyle(
                              color: blue,
                            ),
                          ),
                        ),
                        Checkbox(
                          activeColor: primaryColor,
                          value: isChecked,
                          onChanged: (val) {
                            setState(
                              () {
                                isChecked = val ?? false;
                              },
                            );
                            widget.onCheckboxChanged(isChecked);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Rate : ',
                            style: TextStyle(
                              color: blue,
                            ),
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: widget.model?.rate?.toDouble() ?? 0.0,
                          itemSize: 30,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            rateVisit = rating.toString();
                            widget.rateCardChanged(rating);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField.withDarkBorder(
                      onChanged:
                          widget.commentsCardChanged(commentController.text),
                      myController: commentController,
                      labelText: 'Add Comment',
                      height: 53.h,
                      maxLines: 6,
                      prefixIcon: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: LoadingButton(
                        text: 'Submit',
                        borderRadius: 12,
                        btnColor: primaryColor,
                        btnHeight: 40.h,
                        btnWidth: 200.w,
                        isLoading: loading,
                        isDisabled: false,
                        onPressed: () {
                          validateBeforeRequest(context);
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget validateRequiredOrNot(CheckListModel? model) {
    if ((model?.isRequired ?? false) == true) {
      if ((model?.checkedStatus ?? false) == true && (model?.rate ?? 0) != 0) {
        return SizedBox(height: 0.h);
      } else {
        return Text(
          '(Required)*',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: red,
            fontSize: 14.sp,
          ),
        );
      }
    } else {
      return SizedBox(height: 0.h);
    }
  }

  void validateBeforeRequest(BuildContext context) {
    if (isChecked == true && rateVisit != "0") {
      updateCheckList(
        model: widget.model,
        visitId: widget.visitId,
        context: context,
      );
    } else {
      "Please Check And Add Rate".showToast(
        gravity: ToastGravity.CENTER,
        backgroundColor: red,
      );
    }
  }

  updateCheckList({
    required int visitId,
    required CheckListModel? model,
    required BuildContext context,
  }) async {
    setState(() {
      loading = true;
    });
    final result =
        await context.read<UpdateCheckListCubit>().updateVisitCheckList(
              model: UpdateCheckListToJsonModel(
                visitId: visitId,
                jsonArray: [
                  CheckListItemToJson(
                    checkItemID: getCheckItemID(model),
                    itemResponseId: getItemResponseId(model),
                    checkedStatus: getCheckedStatus(),
                    rate: getRateActionUser(),
                    comment: commentController.text,
                  ),
                ],
              ),
            );
    setState(() {
      loading = false;
    });

    if (result.message == "Success") {
      /// todo :check show mss
      showSuccessMss();
      refreshPage();
    }
  }

  String getCheckItemID(CheckListModel? model) {
    return model?.checkItemID.toString() ?? "";
  }

  String getItemResponseId(CheckListModel? model) {
    return model?.itemResponseId.toString() ?? '';
  }

  String getCheckedStatus() {
    return isChecked == true ? "1" : "0";
  }

  String getRateActionUser() {
    return rateVisit.contains('.') ? rateVisit.split('.')[0] : rateVisit;
  }

  showSuccessMss() {
    "Updated Successfully".showToast(
      backgroundColor: Colors.green,
    );
  }

  refreshPage() {
    refreshIndicatorCheckListKey.currentState?.show();
  }

  initialTextDta(CheckListModel? model) {
    isChecked = model?.checkedStatus ?? false;
    commentController.text = model?.comment ?? "";
    rateVisit = model?.rate.toString() ?? "";
  }
}

///[validateCheckedOrNot]
Widget validateCheckedOrNot(CheckListModel? model) {
  if ((model?.checkedStatus ?? false) == true && (model?.rate ?? 0) != 0) {
    return const Icon(Icons.check, color: primaryColor);
  } else {
    return const SizedBox();
  }
}
