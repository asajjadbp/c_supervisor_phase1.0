import 'package:async/async.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/base_app_paging_cubit.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';
import 'package:intl/intl.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../data/models/index.dart';
import '../../../../data/models/team_role_list_model.dart';

class RolesFilterSearchCubit extends BaseAppPagingCubit<TeamRolesListModel> {
  final FilterUC filterUC;

  /// [_cancellableOperation] used to cancel debounce  search operation in case user enter new search query
  CancelableOperation<void>? _cancellableOperation;

  /// [_debounceDelayTime] the time is taken before new network call  called
  final _debounceDelayTime = const Duration(milliseconds: 500);

  RolesFilterSearchCubit(this.filterUC);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Future<TeamRolesListModel> loadItemsAtPage(int page, {args}) async {
    print('loaddd');
    // // FilterByNameModel? filterModel;
    //
    // try {
    //   final map = args as Map<dynamic, dynamic>;
    //   if (map.containsKey('filterModel')) {
    //     filterModel = map['filterModel'] as FilterByNameModel?;
    //   }
    // } catch (e) {}

    final BaseResponse<TeamRolesListModel?> result;

    result = await _onSearchQueryChanged(
      () => networkCall(
        () => filterUC.getRolesSearchFilter(),
      ),
    );
    print('result of RolesFilterSearchCubit');

    emit(RequestState.loaded(TeamRolesListModel()));
    return result.data ?? TeamRolesListModel();
  }

  /// _resetDebounceTimer : reset the timer for debounce
  void _resetDebounceTimer() {
    _cancellableOperation = CancelableOperation.fromFuture(
      Future.delayed(_debounceDelayTime),
    );
  }

  Future<BaseResponse<TeamRolesListModel?>> _onSearchQueryChanged(
      Future<BaseResponse<TeamRolesListModel?>> Function() networkCall) async {
    _cancellableOperation?.cancel();
    _resetDebounceTimer();
    await _cancellableOperation?.value.whenComplete(() => {});
    return networkCall.call();
  }
}
