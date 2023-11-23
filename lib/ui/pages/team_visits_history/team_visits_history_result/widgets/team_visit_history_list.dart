import 'index.dart';

class TeamVisitsHistoryResultList extends StatelessWidget {
  const TeamVisitsHistoryResultList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: teamVisitsHistoryPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<TeamVisitsHistoryCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final teamVisitsHistory = item;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TeamVisitsHistoryResultCard(
              teamVisitsHistoryModel: teamVisitsHistory,
              index: index,
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
