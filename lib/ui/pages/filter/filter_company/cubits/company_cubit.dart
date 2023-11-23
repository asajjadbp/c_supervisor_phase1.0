import 'package:c_supervisor/data/models/company_list_model.dart';
import 'package:c_supervisor/domain/use_cases/filter_methods_uc.dart';
import 'package:c_supervisor/ui/pages/my_coverage/index.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/cubits/index.dart';

class CompanyCubit extends BaseAppCubit<CompanyListModel> {
  final FilterMethodsUC filterMethodsUC;
  CompanyCubit(this.filterMethodsUC);

  Future<CompanyListModel> loadItemsAtPage() async {
    final BaseResponse<CompanyListModel?> result;
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    result = await networkCall(
      () => filterMethodsUC.getCompanies(
        langID: 1,
        userID: userID,
      ),
    );

    return result.data ?? CompanyListModel();
  }
}
