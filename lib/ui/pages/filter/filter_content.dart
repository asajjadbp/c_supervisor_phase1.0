import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/styles/theme.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/filter/search_widgets/search_filter_delegate.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'cubit/selection_search_item_cubit.dart';
import 'cubit/team_filter_search_cubit.dart';

class FilterContent extends HookWidget {
  FilterContent({Key? key, required this.filterArgs}) : super(key: key);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final FilterArgs filterArgs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final TextEditingController startDate =
        useTextEditingController(text: dateFormat.format(DateTime.now()));
    final TextEditingController endDate = useTextEditingController();

    final usersIds = context.watch<SelectSearchItemCubit>();
    final TextEditingController controller = useTextEditingController();
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
                              controller.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'User',
                                myController: controller,
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
                        onPressed: () =>
                            _submitSearch(context, usersIds, startDate),
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

  void _submitSearch(BuildContext context, SelectSearchItemCubit childIds,
      TextEditingController startDate) {
    final currentFilter = filterArgs.filterType.getFilterModel(
      SearchArgs(
        childIds: _getIdsFromSearchSelected(childIds.state) ?? [],
        startDate: startDate.text,

      ),
    );

    filterArgs.teamSearchByFilter
        .call(currentFilter, filterArgs.parentBuildContext);
    context.pop();
  }

  /// [_getIdsFromSearchSelected] extract ids from [SearchResultEntity]
  List<int>? _getIdsFromSearchSelected(
    List<TeamFilterResultModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }
}
