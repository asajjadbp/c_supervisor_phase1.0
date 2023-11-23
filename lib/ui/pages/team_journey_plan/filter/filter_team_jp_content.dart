import 'package:c_supervisor/data/models/city_model.dart';
import 'package:c_supervisor/data/models/company_model.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/region_model.dart';
import 'package:c_supervisor/data/models/status_model.dart';
import 'package:c_supervisor/styles/theme.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/filter/filter_company/cubits/company_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/region_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/filter_region/cubits/selection_region_item_cubit.dart';
import 'package:c_supervisor/ui/pages/filter/search_widgets/search_filter_delegate.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_chain_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_filter_city_delegate.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/chain_model.dart';
import '../../filter/cubit/selection_search_item_cubit.dart';
import '../../filter/cubit/team_filter_search_cubit.dart';
import '../../filter/filter_company/cubits/selection_company_item_cubit.dart';
import '../../filter/filter_company/widgets/search_filter_company_delegate.dart';
import '../../filter/filter_region/widgets/search_filter_region_delegate.dart';
import '../../my_coverage/cubits/chains_cubit.dart';
import '../../my_coverage/cubits/cities_cubit.dart';
import '../../my_coverage/filter/search_coverage_widgets/search_filter_chains_delegate.dart';

class FilterTeamJPContent extends HookWidget {
  FilterTeamJPContent({Key? key, required this.filterArgs}) : super(key: key);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final FilterArgs filterArgs;
   int? statusId;
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final TextEditingController visitsDate =
        useTextEditingController(text: dateFormat.format(DateTime.now()));

    final userIds = context.watch<SelectSearchItemCubit>();
    final chainIds = context.watch<SelectChainItemCubit>();
    final cityIds = context.watch<SelectCityItemCubit>();
    final clientIds = context.watch<SelectCompanyItemCubit>();
    final regionIds = context.watch<SelectRegionItemCubit>();
    final TextEditingController userController = useTextEditingController();
    final TextEditingController cityController = useTextEditingController();
    final TextEditingController regionController = useTextEditingController();
    final TextEditingController companyController = useTextEditingController();
    final TextEditingController chainsController = useTextEditingController();
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
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () {
                            _navigateToSearchCities(context);
                          },
                          child: BlocBuilder<SelectCityItemCubit,
                              List<CityModel?>?>(
                            builder: (context, state) {
                              final String currentTextLabel = state
                                      ?.map((e) => e?.value)
                                      .toList()
                                      .join(',') ??
                                  '';
                              cityController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'Cities',
                                myController: cityController,
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
                            _navigateToSearchRegions(context);
                          },
                          child: BlocBuilder<SelectRegionItemCubit,
                              List<RegionModel?>?>(
                            builder: (context, state) {
                              final String currentTextLabel = state
                                      ?.map((e) => e?.value)
                                      .toList()
                                      .join(',') ??
                                  '';
                              regionController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'Regions',
                                myController: regionController,
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
                            _navigateToSearchCompanies(context);
                          },
                          child: BlocBuilder<SelectCompanyItemCubit,
                              List<CompanyModel?>?>(
                            builder: (context, state) {
                              final String currentTextLabel = state
                                      ?.map((e) => e?.value)
                                      .toList()
                                      .join(',') ??
                                  '';
                              companyController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'Companies',
                                myController: companyController,
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
                            _navigateToSearchChains(context);
                          },
                          child: BlocBuilder<SelectChainItemCubit,
                              List<ChainModel?>?>(
                            builder: (context, state) {
                              final String currentTextLabel = state
                                      ?.map((e) => e?.value)
                                      .toList()
                                      .join(',') ??
                                  '';
                              chainsController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'Chains',
                                myController: chainsController,
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
                            _selectDate(context, true, visitsDate);
                          },
                          child: CustomTextField.withDarkBorder(
                            labelText: 'Date',
                            myController: visitsDate,
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
                          cityIds,
                          regionIds,
                          clientIds,
                          chainIds,
                          visitsDate,
                          statusId ?? 4,
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

  void _navigateToSearchChains(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchFilterChainsDelegate<ChainsCubit, SelectChainItemCubit>(
        isMultipleSelection: true,
        parentContext: context,
      ),
    );
  }

  void _navigateToSearchCities(BuildContext context) {
    showSearch(
        context: context,
        delegate: SearchFilterCityDelegate<CitiesCubit, SelectCityItemCubit>(
          isMultipleSelection: true,
          parentContext: context,
        ));
  }

  void _navigateToSearchRegions(BuildContext context) {
    showSearch(
        context: context,
        delegate:
            SearchFilterRegionDelegate<RegionCubit, SelectRegionItemCubit>(
          isMultipleSelection: true,
          parentContext: context,
        ));
  }

  void _navigateToSearchCompanies(BuildContext context) {
    showSearch(
        context: context,
        delegate:
            SearchFilterCompanyDelegate<CompanyCubit, SelectCompanyItemCubit>(
          isMultipleSelection: true,
          parentContext: context,
        ));
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
    SelectCityItemCubit cityIds,
    SelectRegionItemCubit regionIds,
    SelectCompanyItemCubit clientIds,
    SelectChainItemCubit chainIds,
    TextEditingController visitsDate,
    int status,
  ) {
    final currentFilter = filterArgs.filterType.getFilterModel(
      SearchArgs(
        childIds: _getChildIdsFromSearchSelected(userIds.state) ?? [],
        companyIDs: _getCompanyIdsFromSearchSelected(clientIds.state) ?? [],
        regionIDs: _getRegionIdsFromSearchSelected(regionIds.state) ?? [],
        chainIDs: _getChainIdsFromSearchSelected(chainIds.state) ?? [],
        cityIDs: _getCityIdsFromSearchSelected(cityIds.state) ?? [],
        visitsDate: visitsDate.text,
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

  /// [_getIdsFromSearchSelected] extract ids from [SearchResultEntity]
  List<int>? _getChainIdsFromSearchSelected(
    List<ChainModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }

  List<int>? _getCityIdsFromSearchSelected(
    List<CityModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }

  List<int>? _getCompanyIdsFromSearchSelected(
    List<CompanyModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }

  List<int>? _getRegionIdsFromSearchSelected(
    List<RegionModel?>? selectedItems,
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
                  itemCount: StatusTeamJPModel.statusList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title:
                          Text(StatusTeamJPModel.statusList[index].statusValue),
                      onTap: () {
                        setState(() {
                          widget.onChanged!(
                              StatusTeamJPModel.statusList[index].statusId);
                          statusId =
                              StatusTeamJPModel.statusList[index].statusId;
                          statusName =
                              StatusTeamJPModel.statusList[index].statusValue;
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
        labelText: 'Visits Status',
        myController: TextEditingController(text: statusName),
        height: 53.h,
        keyboardType: TextInputType.emailAddress,
        isEnabled: false,
      ),
    );
  }
}
