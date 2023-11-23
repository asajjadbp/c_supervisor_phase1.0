import 'package:c_supervisor/ui/pages/team_visits_history/category/cubits/visit_before_fixing_cubit.dart';
import 'package:c_supervisor/ui/pages/team_visits_history/category/widgets/visit_before_fixing/visit_before_fixing_card.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '../../../../../../data/models/visits_categories/visit_before_fixing_list_model.dart';
import '../../../../../bloc/app_bloc_consumer.dart';
import '../../../../../index.dart';

class VisitBeforeFixingList extends StatelessWidget {
  const VisitBeforeFixingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBlocConsumer<VisitBeforeFixingCubit, BaseResponse<VisitBeforeFixingListModel?>>(
      onSuccessBuilder: (context, state) {
        final isLoading = state.status == RequestStatus.loading;
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemBuilder: (context, index) {
            final visitBeforeFixingModel = state.value?.data?.dataList[index];

            return VisitBeforeFixingCard(visitBeforeFixingModel: visitBeforeFixingModel);
          },
          itemCount: state.value?.data?.dataList.length ?? 0,
          separatorBuilder: (context, index) => SizedBox(
            height: 20.h,
          ),
        );
      },
    );

  }
}


