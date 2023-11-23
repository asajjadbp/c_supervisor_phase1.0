import 'package:c_supervisor/data/models/city_model.dart';
import 'package:c_supervisor/styles/theme.dart';
import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_coverage/cubits/selection_city_item_cubit.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_filter_chains_delegate.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/search_coverage_widgets/search_filter_city_delegate.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/chain_model.dart';
import '../cubits/chains_cubit.dart';
import '../cubits/cities_cubit.dart';
import '../cubits/selection_chain_item_cubit.dart';

class FilterMyCoverageContent extends HookWidget {
  FilterMyCoverageContent({Key? key, required this.filterArgs})
      : super(key: key);

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final FilterArgs filterArgs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chainsIds = context.watch<SelectChainItemCubit>();
    final cityIds = context.watch<SelectCityItemCubit>();
    final TextEditingController chainController = useTextEditingController();
    final TextEditingController cityController = useTextEditingController();
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
                              chainController.text = currentTextLabel;
                              return CustomTextField.withDarkBorder(
                                labelText: 'Chains',
                                myController: chainController,
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
                            _submitSearch(context, chainsIds, cityIds),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
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
        )
        // delegate:
        //     SearchFilterDelegate<TeamFilterSearchCubit, SelectSearchItemCubit>(
        //   parentContext: context,
        //   isMultipleSelection:true,
        //
        //       //filterArgs.filterType.getTeamMultipleSelectStatus(),
        // ),
        );
  }

  void _submitSearch(BuildContext context, SelectChainItemCubit chainIds,
      SelectCityItemCubit citiesIds) {
    final currentFilter = filterArgs.filterType.getFilterModel(
      SearchArgs(
        chainIDs: _getChainIdsFromSearchSelected(chainIds.state) ?? [],
        cityIDs: _getCityIdsFromSearchSelected(citiesIds.state) ?? [],
      ),
    );

    filterArgs.teamSearchByFilter
        .call(currentFilter, filterArgs.parentBuildContext);
    context.pop();
  }

  /// [_getIdsFromSearchSelected] extract ids from [SearchResultEntity]
  List<int>? _getChainIdsFromSearchSelected(
    List<ChainModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }

  /// [_getIdsFromSearchSelected] extract ids from [SearchResultEntity]

  List<int>? _getCityIdsFromSearchSelected(
    List<CityModel?>? selectedItems,
  ) {
    return selectedItems?.map((e) => e?.id ?? 0).toList();
  }
}
