import 'package:c_supervisor/data/models/team_visits_history_model.dart';
import 'package:c_supervisor/data/models/visits_categories_model.dart';

import '../../category/category_page.dart';
import 'index.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    Key? key,
    required this.index,
    required this.visitsCategoriesModel,
    required this.teamVisitsHistoryModel,
  }) : super(key: key);

  final VisitsCategoriesModel visitsCategoriesModel;
  final TeamVisitsHistoryModel teamVisitsHistoryModel;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(
              moduleName: visitsCategoriesModel.categoryname ?? '',
              teamVisitsHistoryModel: teamVisitsHistoryModel,
              visitsCategoriesModel: visitsCategoriesModel,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 100.h,
        width: 350.w,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CustomCachedNetworkImage(
                          imgUrl:
                              "https://testapi.catalist-me.com/${visitsCategoriesModel.categoryPhotopath}",
                          placeholderPath: '',
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0.w, vertical: 10.h),
                        child: SizedBox(
                          width: 230.w,
                          child: Text(
                            visitsCategoriesModel.categoryname.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
