import 'cubits/my_coverage_cubit.dart';
import 'index.dart';

class MyCoveragePage extends StatelessWidget {
  const MyCoveragePage({Key? key, required this.moduleName}) : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyCoverageCubit(myCoverageUC: GetIt.I<MyCoverageUC>()),
      child: MyCoverageContent(
        moduleName: moduleName,
      ),
    );
  }
}
