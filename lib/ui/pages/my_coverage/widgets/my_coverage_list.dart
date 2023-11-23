import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import '../cubits/my_coverage_cubit.dart';
import 'my_coverage_card.dart';

class MyCoverageList extends StatelessWidget {
  const MyCoverageList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: myCoverageAgingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<MyCoverageCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final myCoverageModel = item;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: MyCoverageCard(
              index: index,
              myCoverageModel: myCoverageModel,
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
