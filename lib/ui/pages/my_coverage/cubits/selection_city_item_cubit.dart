import 'package:c_supervisor/data/models/city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCityItemCubit extends Cubit<List<CityModel?>?> {
  SelectCityItemCubit() : super([]);

  void selectItem({
    CityModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<CityModel?>.from(state ?? []);

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
    final newList = List<CityModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
