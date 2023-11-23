import 'package:c_supervisor/domain/use_cases/knowledge_share_uc.dart';
import 'package:c_supervisor/ui/index.dart';

import 'knowledge_share_content.dart';

class KnowledgeSharePage extends StatelessWidget {
  const KnowledgeSharePage({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              KnowledgeBaseCategoriesCubit(GetIt.I<KnowledgeShareUC>())
                ..getKnowledgeBaseCategories(),
        ),
        BlocProvider(
          create: (_) => UploadFileCubit(GetIt.I<KnowledgeShareUC>()),
        ),
        BlocProvider(
          create: (_) => AddFileCubit(GetIt.I<KnowledgeShareUC>()),
        ),
      ],
      child: KnowledgeShareContent(
        moduleName: moduleName,
      ),
    );
  }
}
