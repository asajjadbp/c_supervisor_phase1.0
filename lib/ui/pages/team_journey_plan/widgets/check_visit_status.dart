import 'index.dart';

class CheckVisitStatus extends StatelessWidget {
  const CheckVisitStatus({
    super.key,
    required this.teamJourneyPlanModel,
  });

  final TeamJourneyPlanModel teamJourneyPlanModel;

  @override
  Widget build(BuildContext context) {
    switch (teamJourneyPlanModel.visitStatus) {
      case "Pending":
        return Row(
          children: [
            SvgPicture.asset('assets/icons/cancel_circle.svg'),
            SizedBox(
              width: 7.h,
            ),
            Text(
              '${teamJourneyPlanModel.visitStatus}',
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
              '${teamJourneyPlanModel.visitStatus}',
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
              '${teamJourneyPlanModel.visitStatus}',
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
