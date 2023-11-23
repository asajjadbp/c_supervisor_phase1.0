import 'package:flutter_core/widgets/loading_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../data/models/sup_visits/modules/check_list/checklist_model.dart';
import '../../../../../index.dart';

void openBottomSheet({
  required BuildContext context,
  required CheckListModel? model,
}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.r),
        topRight: Radius.circular(15.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        )),
        height: 500.h,
        // Customize your bottom sheet content here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      model?.checkItemName ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
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
                    value: false,
                    onChanged: (val) {},
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
                    initialRating: 3,
                    itemSize: 30,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      //   rateValue = rating;
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField.withDarkBorder(
                ///   myController: widget.commentController,
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
                alignment: Alignment.center,
                child: LoadingButton(
                  btnHeight: 40.h,
                  btnWidth: 200.w,
                  loadingText: 'Loading...',
                  text: 'Submit',
                  style: TextStyle(fontSize: 20.sp, color: white),

                  ///isLoading: ,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
