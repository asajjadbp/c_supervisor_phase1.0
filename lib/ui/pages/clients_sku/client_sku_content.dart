import 'index.dart';

final GlobalKey<PagingListViewState> clientsSkuPagingListViewKey =
    GlobalKey<PagingListViewState>();

class ClientsSkuContent extends StatelessWidget {
  const ClientsSkuContent({Key? key, required this.moduleName})
      : super(key: key);
  final String moduleName;

  @override
  Widget build(BuildContext context) {
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
            Visibility(
              visible: false,
              child: InkWell(
                // onTap: () => context.push(
                //   PostAuthRoutes.filter.route.path,
                //   extra: FilterArgs(
                //       teamSearchByFilter: _teamSearchByFilter,
                //       parentBuildContext: context),
                // ),
                child: SvgPicture.asset(
                  'assets/icons/search_ic.svg',
                ),
              ),
            ),
          ],
          headerTitle: moduleName,
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children:  [
              const Expanded(
                child: ClientsSkuList(),
              ),
              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
