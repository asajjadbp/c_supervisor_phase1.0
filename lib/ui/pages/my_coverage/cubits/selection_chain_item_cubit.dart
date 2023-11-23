import 'package:c_supervisor/data/models/chain_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectChainItemCubit extends Cubit<List<ChainModel?>?> {
  SelectChainItemCubit() : super([]);

  void selectItem({
    ChainModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<ChainModel?>.from(state ?? []);

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
    final newList = List<ChainModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
