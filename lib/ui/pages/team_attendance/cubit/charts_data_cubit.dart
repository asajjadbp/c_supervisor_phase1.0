import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import '../../../../domain/use_cases/index.dart';

class ChartDataCubit extends BaseAppCubit<ChartDataList?> {
  ChartDataCubit({required this.teamAttendanceUC});

  final TeamAttendanceUC teamAttendanceUC;

  Future<void> getTeamAttendanceChartsData({
    required FilterModel filterModel,
  }) async {
    await networkCall(
      () => teamAttendanceUC.getTeamAttendanceChartsData(filterModel),
    );
  }
}
