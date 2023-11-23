import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/team_role_model.dart';

class SelectRoleItemCubit extends Cubit<List<TeamRoleModel?>?> {
  SelectRoleItemCubit() : super([]);

  void selectItem({
    TeamRoleModel? searchResultEntity,
    required bool isMultipleSelection,
  }) {
    if (searchResultEntity == null) return;

    final currentSelectedSearchList =
        List<TeamRoleModel?>.from(state ?? []);

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
    final newList = List<TeamRoleModel?>.from(state ?? []);
    newList.clear();
    emit(newList);
  }
}
