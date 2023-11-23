import 'package:c_supervisor/ui/pages/my_coverage/index.dart';

import '../../team_kpi/index.dart';

class MyCoverageCubit extends BaseAppPagingCubit<MyCoverageListModel> {
  final MyCoverageUC myCoverageUC;
  final List<int>? cityIDS;
  final List<int>? chainIDS;
  MyCoverageCubit({
    required this.myCoverageUC,
    this.chainIDS,
    this.cityIDS,
  });

  ///opt(AM) : what is the purpose of this var --> [filterModel]
  FilterModel? filterModel;
  @override
  Future<MyCoverageListModel> loadItemsAtPage(int page, {args}) async {
    FilterModel? filterModel;
    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterModel?;
        filterModel?.pageNumber=page;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    final BaseResponse<MyCoverageListModel?> result;
    final int userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    result = await networkCall(
      () => myCoverageUC.getMyCoverage(
        filterModel: filterModel ??
            FilterModel(
              pageNumber: page,
              userID: userID,
              pageSize: 20,
              searchWord: "",
              companyId: 1,
              chainIDs: [],
              cityIDs: [],
            ),
      ),
    );

    return result.data ?? MyCoverageListModel();
  }
}
