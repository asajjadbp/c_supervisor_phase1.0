import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

/// todo  create abstract  common cubit with same load data type

class InsertActionTypeCubit extends BaseAppCubit<EmptyModel> {
  InsertActionTypeCubit({required this.actionTypesUC});

  final ActionTypesUC actionTypesUC;

  Future<void> insertActionType({
    required AddActionTypeModel addActionTypeModel,
    Function()? successCall,
  }) async {
    await networkCall(
      successCall: successCall,
      () => actionTypesUC.insertActionType(addActionTypeModel),
    );
  }
}
