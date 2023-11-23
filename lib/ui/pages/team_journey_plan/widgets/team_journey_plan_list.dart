


import '../team_journey_plan_content.dart';
import 'index.dart';
class TeamJourneyPlanList extends StatelessWidget {
  const TeamJourneyPlanList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return PagingListView(
      key: teamJourneyPlanPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<TeamJourneyPlanCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final teamJourneyPlan = item;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TeamJourneyPlanCard(
              index: index,
               teamJourneyPlanModel: teamJourneyPlan,
            ));
      },
      args: const {},
      emptyPlaceholderWidget: const Center(
          child: Text('No Data')) /*CustomEmptyPlaceHolder.withEmptyIcon()*/,
      unAuthorizedNavigatorBlock: () {},
      properties: PagingListViewProperties.defaultProperties(
        context,
        noItemsFound: "No Items Found",
      ),
    );
  }
}
