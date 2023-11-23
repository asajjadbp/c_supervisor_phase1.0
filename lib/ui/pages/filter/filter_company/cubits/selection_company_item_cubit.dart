import 'package:c_supervisor/data/models/company_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCompanyItemCubit extends Cubit<List<CompanyModel?>?> {
  SelectCompanyItemCubit() : super([]);

  void selectItem({
    CompanyModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<CompanyModel?>.from(state ?? []);

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
    final newList = List<CompanyModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
