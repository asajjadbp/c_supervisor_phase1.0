import 'index.dart';

class TeamJourneyPlanCard extends StatelessWidget {
  const TeamJourneyPlanCard({
    Key? key,
    required this.index,
    required this.teamJourneyPlanModel,
  }) : super(key: key);

  final TeamJourneyPlanModel teamJourneyPlanModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185.h,
      width: 345.w,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Visit ID: ${teamJourneyPlanModel.visitID}',
                style: TextStyle(
                  color: black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(10.r),
                      child: CustomCachedNetworkImage(
                          imgUrl: "https://testapi.catalist-me.com/${teamJourneyPlanModel.companylogo}",
                          placeholderPath: ''),
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Text(
                    '${teamJourneyPlanModel.companyName}',
                    style: TextStyle(color: blue, fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      "${teamJourneyPlanModel.storeName}",
                      style: const TextStyle(color: primaryColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Container(
                    height: 12.h,
                    width: 2.w,
                    color: lightGrey.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 7.h,
                  ),
                  CheckVisitStatus(teamJourneyPlanModel: teamJourneyPlanModel),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                'TMR: ${teamJourneyPlanModel.fullName}',
                style: TextStyle(color: blue, fontSize: 14.sp),
              ),
              SizedBox(
                height: 8.h,
              ),

              Row(
                children: [
                  SvgPicture.asset('assets/icons/calendar_ic.svg'),
                  SizedBox(
                    width: 7.h,
                  ),
                  Text(
                    '${teamJourneyPlanModel.visitDate}',
                    style: TextStyle(
                      color: black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
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
}
