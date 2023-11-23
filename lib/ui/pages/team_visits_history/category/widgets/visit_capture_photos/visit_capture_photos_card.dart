import 'package:c_supervisor/data/models/visits_categories/visit_capture_photos_model.dart';

import '../../../../../common_reusable/image_view.dart';
import '../../../../../index.dart';

class VisitCapturePhotosCard extends StatelessWidget {
  const VisitCapturePhotosCard({
    super.key,
    required this.visitCapturePhotosModel,
  });

  final VisitCapturePhotosModel? visitCapturePhotosModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.w,
      height: 175.h,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        elevation: 3,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageViewOnAlert(
                    isExpanded: false,
                    imagePath:visitCapturePhotosModel?.photoPath??'' ,
                  ),
                  SizedBox(width: 13.w),
                  Padding(
                    padding: EdgeInsets.only(top: 17.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190.w,
                          child: Text(
                            '${visitCapturePhotosModel?.categoryname}',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          'Reason : ${visitCapturePhotosModel?.reason}',
                          style:
                              TextStyle(fontSize: 16.sp, color: primaryColor),
                        ),
                        SizedBox(height: 7.h),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
