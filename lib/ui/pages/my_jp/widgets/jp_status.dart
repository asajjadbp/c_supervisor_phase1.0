import '../../../../data/models/sup_visits/sup_visits_model.dart';
import '../../../index.dart';

class JPVisitStatus extends StatelessWidget {
  const JPVisitStatus({
    super.key,
    required this.supVisitsModel,
  });

  final SupVisitsModel supVisitsModel;

  @override
  Widget build(BuildContext context) {
    switch (supVisitsModel.visitStatus) {
      case "Pending":
        return Row(
          children: [
            SvgPicture.asset('assets/icons/in_progress.svg', color: red),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${supVisitsModel.visitStatus}',
              style: TextStyle(
                color: red,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      case "Finished":
        return Row(
          children: [
            //SvgPicture.asset('assets/icons/check_circle.svg'),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 17.sp,
            ),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${supVisitsModel.visitStatus}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      case "In Progress":
        return Row(
          children: [
            SvgPicture.asset('assets/icons/in_progress.svg'),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${supVisitsModel.visitStatus}',
              style: TextStyle(
                color: blue,
                fontSize: 14.sp,
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
