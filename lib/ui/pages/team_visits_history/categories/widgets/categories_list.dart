import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/categories/categories_content.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/categories/cubits/visits_categories_cubit.dart';

import 'index.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    Key? key,
    required this.teamVisitsHistoryModel
  }) : super(key: key);

  final TeamVisitsHistoryModel teamVisitsHistoryModel;

  @override
  Widget build(BuildContext context) {
    return PagingListView(
      key: categoriesPagingListViewKey,
      padding: EdgeInsets.zero,
      dataProvider: context.read<VisitsCategoriesCubit>(),
      firstPageProgressBuilder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, item, index) {
        final visitsCategories = item;
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CategoriesCard(
              index: index,
              visitsCategoriesModel: visitsCategories,
              teamVisitsHistoryModel: teamVisitsHistoryModel,
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
