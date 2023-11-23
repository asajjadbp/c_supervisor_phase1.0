import 'package:c_supervisor/data/models/common_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [SelectionCubit] used to manage state when changing sort list selection
class SelectionCubit extends Cubit<CommonDataModel?> {
  SelectionCubit() : super(null);

  void changeItemSelection(CommonDataModel? dataModel) => emit(dataModel);
}
