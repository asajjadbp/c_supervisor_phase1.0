import 'package:c_supervisor/ui/pages/my_jp/module/check_list/widgets/checklist_list.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../data/models/sup_visits/modules/check_list/checklist_list_model.dart';
import '../../../../bloc/app_bloc_consumer.dart';
import '../../../../index.dart';
import 'cubits/checklist_cubit.dart';

class CheckListContent extends StatelessWidget {
  const CheckListContent({
    super.key,
    this.visitId,
  });
  final int? visitId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journey Plan Check List',
          style: TextStyle(
            color: white,
            fontSize: 20.sp,
          ),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: white),
      ),
      body: AppBlocConsumer<CheckListCubit, BaseResponse<CheckListListModel?>>(
        onSuccessBuilder: (context, state) {
          final isLoading = state.status == RequestStatus.loading;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return CheckListList(
            visitId: visitId ?? 0,
            dataList: state.value?.data?.dataList ?? [],
          );
        },
        isConsumerAction: true,
      ),
    );
  }
}
