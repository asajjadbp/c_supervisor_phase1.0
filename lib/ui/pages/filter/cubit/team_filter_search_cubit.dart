import 'package:async/async.dart';
import 'package:c_supervisor/data/constants/api_endpoints.dart';
import 'package:c_supervisor/data/data_sources/local/app_shared_prefs_client.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/base_app_paging_cubit.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:intl/intl.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../data/models/index.dart';

///TODO : this class should be abstract after renamed to hold debounce logic instead off duplicate the code of  the debouncer
class TeamFilterSearchCubit extends BaseAppPagingCubit<TeamFilterListModel> {
  final FilterUC filterUC;

  /// [_cancellableOperation] used to cancel debounce  search operation in case user enter new search query
  CancelableOperation<void>? _cancellableOperation;

  /// [_debounceDelayTime] the time is taken before new network call  called
  final _debounceDelayTime = const Duration(milliseconds: 500);

  TeamFilterSearchCubit(this.filterUC);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Future<TeamFilterListModel> loadItemsAtPage(int page, {args}) async {
    FilterByNameModel? filterModel;

    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterByNameModel?;
      }
    } catch (e) {}

    final BaseResponse<TeamFilterListModel?> result;

    result = await _onSearchQueryChanged(
      () => networkCall(
        () => filterUC.getTeamSearchFilter(filterModel ??
            FilterByNameModel(
                pageNumber: page,
                pageSize: APIEndpoints.pageSize,
                userID: GetIt.I<AppSharedPrefsClient>()
                    .getCurrentUserInfo()
                    ?.userId,
                search: '',
                roleId: '')),
      ),
    );

    return result.data ?? TeamFilterListModel();
  }

  /// _resetDebounceTimer : reset the timer for debounce
  void _resetDebounceTimer() {
    _cancellableOperation = CancelableOperation.fromFuture(
      Future.delayed(_debounceDelayTime),
    );
  }

  Future<BaseResponse<TeamFilterListModel?>> _onSearchQueryChanged(
      Future<BaseResponse<TeamFilterListModel?>> Function() networkCall) async {
    _cancellableOperation?.cancel();
    _resetDebounceTimer();
    await _cancellableOperation?.value.whenComplete(() => {});
    return networkCall.call();
  }
}
