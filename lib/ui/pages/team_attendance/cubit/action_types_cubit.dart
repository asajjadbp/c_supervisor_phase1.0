import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

/// todo  create abstract  common cubit with same load data type

class ActionTypesCubit extends BaseAppCubit<CommonDataListModel> {
  ActionTypesCubit({required this.actionTypesUC});

  final ActionTypesUC actionTypesUC;

  Future<void> fetchActionTypeList({
    required bool isAttend,
  }) async {
    await networkCall(
      () => actionTypesUC.fetchActionTypeList(isAttend: isAttend),
    );
  }
}
