import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/my_jp_dashboard/my_jp_dashboard_content.dart';

import '../../../../../domain/use_cases/sup_visits_uc.dart';
import '../../cubits/finish_visit_cubit.dart';

class MyJpDashBoardPage extends StatelessWidget {
  const MyJpDashBoardPage({
    super.key,
    this.visitId,
  });
  final int? visitId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FinishVisitCubit>(
      create: (context) =>
          FinishVisitCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
      child: MyJpDashBoardContent(
        visitId: visitId ?? 0,
      ),
    );
  }
}
