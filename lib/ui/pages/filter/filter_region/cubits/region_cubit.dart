import 'package:c_supervisor/data/models/region_list_model.dart';
import 'package:c_supervisor/domain/use_cases/filter_methods_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';

class RegionCubit extends BaseAppCubit<RegionsListModel> {
  final FilterMethodsUC filterMethodsUC;
  RegionCubit(this.filterMethodsUC);

  Future<RegionsListModel> loadItemsAtPage() async {
    final BaseResponse<RegionsListModel?> result;
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    result = await networkCall(
      () => filterMethodsUC.getRegions(
        langID: 1,
        userID: userID,
      ),
    );

    return result.data ?? RegionsListModel();
  }
}
