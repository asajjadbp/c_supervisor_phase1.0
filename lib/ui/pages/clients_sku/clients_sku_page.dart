import 'package:c_supervisor/domain/use_cases/clients_sku_uc.dart';
import 'package:c_supervisor/ui/pages/clients_sku/cubits/companies_data_cubit.dart';

import 'index.dart';

class ClientsSkuPage extends StatelessWidget {
  const ClientsSkuPage({Key? key, required this.moduleName}) : super(key: key);
  final String moduleName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompaniesDataCubit(GetIt.I<ClientsSkuUC>())..loadItemsAtPage(),
      child: ClientsSkuContent(
        moduleName: moduleName,
      ),
    );
  }
}
