import 'package:c_supervisor/data/models/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSearchItemCubit extends Cubit<List<TeamFilterResultModel?>?> {
  SelectSearchItemCubit() : super([]);

  void selectItem({
    TeamFilterResultModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<TeamFilterResultModel?>.from(state ?? []);

    ///  clear [currentSelectedSearchList] every time when it's not [isMultipleSelection]
    if (!isMultipleSelection) {
      currentSelectedSearchList.clear();
    }

    if (currentSelectedSearchList.contains(searchResultEntity)) {
      currentSelectedSearchList.remove(searchResultEntity);
    } else {
      currentSelectedSearchList.add(searchResultEntity);
    }
    emit(currentSelectedSearchList);
  }

  void clearCurrentState() {
    final newList = List<TeamFilterResultModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
