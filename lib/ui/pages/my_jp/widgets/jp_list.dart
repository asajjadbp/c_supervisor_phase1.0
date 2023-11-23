import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import '../../../../utilities/mixins/location_methods.dart';
import '../cubits/my_jp_cubit.dart';
import 'jp_card.dart';
final GlobalKey<PagingListViewState> supVisitsAgingListViewKey =
GlobalKey<PagingListViewState>();
class JPList extends StatefulWidget {
  const JPList({
    Key? key,
  }) : super(key: key);

  @override
  State<JPList> createState() => _JPListState();
}

class _JPListState extends State<JPList> {
  getLocation(BuildContext context) async {
    await LocationManager.getCurrentPosition(context);
  }

  @override
  void initState() {
    super.initState();
    getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return PagingListView(
        key: supVisitsAgingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<MyJPCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final supVisitsModel = item;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: JPCard(
            index: index,
            supVisitsModel: supVisitsModel,
          ),
        );
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
