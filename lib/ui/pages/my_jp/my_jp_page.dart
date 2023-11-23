import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/my_jp_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/start_visit_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/upload_image_cubit.dart';
import 'package:c_supervisor/utilities/mixins/user_info_mixin.dart';

import '../../index.dart';
import 'cubits/my_jp_count_cubit.dart';
import 'my_jp_content.dart';

class MyJPPage extends StatelessWidget with UserInfoMixin {
  const MyJPPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyJPCubit>(
          create: (context) => MyJPCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
        ),
        BlocProvider<UploadImageJPCubit>(
          create: (context) =>
              UploadImageJPCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
        ),
        BlocProvider<StartVisitCubit>(
          create: (context) =>
              StartVisitCubit(supVisitsUC: GetIt.I<SupVisitsUC>()),
        ),
        BlocProvider<MyJPCountCubit>(
          create: (context) =>
              MyJPCountCubit(supVisitsUC: GetIt.I<SupVisitsUC>())
                ..getSupVisitsCount(
                  userId: getUserId(),
                ),
        ),
      ],
      child: MyJPContent(
        moduleName: moduleName,
      ),
    );
  }
}
