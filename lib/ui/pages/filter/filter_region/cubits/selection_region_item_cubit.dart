import 'package:c_supervisor/data/models/region_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRegionItemCubit extends Cubit<List<RegionModel?>?> {
  SelectRegionItemCubit() : super([]);

  void selectItem({
    RegionModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<RegionModel?>.from(state ?? []);

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
    final newList = List<RegionModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
