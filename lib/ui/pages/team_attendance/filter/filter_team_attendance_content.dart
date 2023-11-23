import 'package:c_supervisor/data/models/index.dart';

import 'package:c_supervisor/data/models/status_model.dart';
import 'package:c_supervisor/styles/theme.dart';
import 'package:c_supervisor/ui/index.dart';

import 'package:c_supervisor/ui/pages/filter/search_widgets/search_filter_delegate.dart';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../filter/cubit/selection_search_item_cubit.dart';
import '../../filter/cubit/team_filter_search_cubit.dart';

class FilterTeamAttendanceContent extends HookWidget {
  FilterTeamAttendanceContent({Key? key, required this.filterArgs})
      : super(key: key);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final FilterArgs filterArgs;

  @override
  Widget build(BuildContext context) {
    int? statusId;
    final theme = Theme.of(context);
    final TextEditingController startDate =
        useTextEditingController(text: dateFormat.format(DateTime.now()));

    final userIds = context.watch<SelectSearchItemCubit>();
    final TextEditingController userController = useTextEditingController();
    return BrandReusable.withAnyHeader(
        isWidgetStacked: true,
        header: Align(
          child: AppHeader(
            prefixHeaderWidgets: [
              const BackIconButton(),
              SizedBox(
                width: 15.w,
              ),
              const DrawerIconButton(),
              SizedBox(
                width: 15.w,
              ),
            ],
            headerTitle: 'Filter ',
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
          ),
          child: Card(
            color: Colors.white70.withAlpha(240),
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: Colors.black12,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              height: 600.h,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.w),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _navigateToSearch(context);
                          },
                          child: BlocBuilder<SelectSearchItemCubit,
                              List<TeamFilterResultModel?>?>(
                            builder: (context, state) {
                              final String currentTextLabel = state
                                      ?.map((e) => e?.name)
                                      .toList()
                                      .join(',') ??
                                  '';
                              userController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'User',
                                myController: userController,
                                height: 53.h,
                                keyboardType: TextInputType.emailAddress,
                                isEnabled: false,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context, true, startDate);
                          },
                          child: CustomTextField.withDarkBorder(
                            labelText: 'Date',
                            myController: startDate,
                            height: 53.h,
                            keyboardType: TextInputType.emailAddress,
                            isEnabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        StatusDropDown(
                          onChanged: (value) {
                            statusId = value;
                          },
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 4,
                      child: LoadingButton(
                        text: 'Search',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                        borderRadius: 12,
                        btnColor: primaryColor,
                        btnHeight: 53.h,
                        btnWidth: 300.w,
                        colorScheme: colorScheme,
                        isLoading: false,
                        isDisabled: false,
                        onPressed: () => _submitSearch(
                          context,
                          userIds,
                          startDate,
                          statusId ?? 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate,
      TextEditingController currentDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null) {
      isStartDate
          ? currentDate.text = dateFormat.format(picked)
          : currentDate.text = dateFormat.format(picked);
    }
  }

  void _navigateToSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate:
          SearchFilterDelegate<TeamFilterSearchCubit, SelectSearchItemCubit>(
        parentContext: context,
        isMultipleSelection:
            filterArgs.filterType.getTeamMultipleSelectStatus(),
      ),
    );
  }

  void _submitSearch(
    BuildContext context,
    SelectSearchItemCubit userIds,
    TextEditingController startDate,
    int status,
  ) {
    final currentFilter = filterArgs.filterType.getFilterModel(
      SearchArgs(
        childIds: _getChildIdsFromSearchSelected(userIds.state) ?? [],
        startDate: startDate.text,
        status: status,
      ),
    );

    filterArgs.teamSearchByFilter
        .call(currentFilter, filterArgs.parentBuildContext);
    context.pop();
  }

  /// [_getIdsFromSearchSelected] extract ids from [SearchResultEntity]
  List<int>? _getChildIdsFromSearchSelected(
    List<TeamFilterResultModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }
}

class StatusDropDown extends StatefulWidget {
  const StatusDropDown({super.key, required this.onChanged});
  final ValueChanged<int?>? onChanged;

  @override
  StatusDropDownState createState() => StatusDropDownState();
}

class StatusDropDownState extends State<StatusDropDown> {
  int? statusId;
  String? statusName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                width: double.minPositive,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: StatusTeamAttendanceModel.statusList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title:
                          Text(StatusTeamAttendanceModel.statusList[index].statusValue),
                      onTap: () {
                        setState(() {
                          widget.onChanged!(
                              StatusTeamAttendanceModel.statusList[index].statusId);
                          statusId =
                              StatusTeamAttendanceModel.statusList[index].statusId;
                          statusName =
                              StatusTeamAttendanceModel.statusList[index].statusValue;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: CustomTextField.withDarkBorder(
        labelText: 'Status',
        myController: TextEditingController(text: statusName),
        height: 53.h,
        keyboardType: TextInputType.emailAddress,
        isEnabled: false,
      ),
    );
  }
}
