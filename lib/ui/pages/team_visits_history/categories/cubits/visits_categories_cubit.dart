import 'package:c_supervisor/data/models/visits_categories_list_model.dart';
import 'package:c_supervisor/domain/use_cases/visits_categories_uc.dart';
import 'package:c_supervisor/ui/bloc/base_app_paging_cubit.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

class VisitsCategoriesCubit extends BaseAppPagingCubit<VisitsCategoriesListModel> {
  final VisitsCategoriesUC visitsCategoriesUC;
  final int visitsID;
  VisitsCategoriesCubit(this.visitsCategoriesUC, this.visitsID);



  @override
  Future<VisitsCategoriesListModel> loadItemsAtPage(int page, {args}) async {
    final BaseResponse<VisitsCategoriesListModel?> result;
    // final userID =
    //     GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    // final visitsDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    // final visitEndDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    result = await networkCall(
          () => visitsCategoriesUC.getVisitsCategories(visitID: visitsID),
    );

    return result.data ?? VisitsCategoriesListModel();
  }
}
