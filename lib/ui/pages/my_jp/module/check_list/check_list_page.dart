import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/check_list_content.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/cubits/checklist_cubit.dart';

import '../../../../index.dart';
import 'cubits/update_checklist_cubit.dart';

class CheckListPage extends StatelessWidget {
  const CheckListPage({
    super.key,
    this.visitId,
  });
  final int? visitId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckListCubit>(
          create: (_) => CheckListCubit(supVisitsUC: GetIt.I<SupVisitsUC>())
            ..getCheckList(
              visitId: visitId ?? 0,
            ),
        ),
        BlocProvider<UpdateCheckListCubit>(
          create: (_) =>
              UpdateCheckListCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
        ),
      ],
      child: CheckListContent(visitId: visitId ?? 0),
    );
  }
}
