import 'package:c_supervisor/ui/index.dart';
import 'package:c_supervisor/ui/pages/my_jp/cubits/finish_visit_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/check_list_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/photo_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/widgets/jp_list.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyJpDashBoardContent extends StatefulWidget {
  const MyJpDashBoardContent({
    super.key,
    this.visitId,
  });
  final int? visitId;

  @override
  State<MyJpDashBoardContent> createState() => _MyJpDashBoardContentState();
}

class _MyJpDashBoardContentState extends State<MyJpDashBoardContent> {
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BrandReusable.withAnyHeader(
      isWidgetStacked: true,
      header: Align(
        child: AppHeader(
          prefixHeaderWidgets: [
            const BackIconButton(),
            SizedBox(width: 15.w),
            const DrawerIconButton(),
          ],
          headerTitle: 'Journey Plan Modules',
        ),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                height: 200.h,
                child: GridView.builder(
                  itemCount: 2,
                  // shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (163.5.h / 135.h),
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          goToJPModule(context, index, widget.visitId);
                        },
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shadowColor: Colors.black12,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                index == 0
                                    ? 'assets/icons/images.png'
                                    : "assets/icons/check_list.png",
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Text(
                                  index == 0 ? 'Photos' : "Check List",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 20.0.w,
                    left: 20.0.w,
                  ),
                  child: CustomTextField.withDarkBorder(
                    myController: commentController,
                    maxLines: 6,
                    labelText: 'Add Comment',
                    contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (password) => ValidatorFactory.required(
                      '',
                      'Required Comment',
                    ).validated(password).errorMessage,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 40.0.h),
                child: AppBlocConsumer<FinishVisitCubit,
                    BaseResponse<SuccessResponseModel?>>(
                  onSuccessBuilder: (context, state) {
                    final isLoading = state.status == RequestStatus.loading;

                    return LoadingButton(
                      text: 'Finish Visit',
                      borderRadius: 6,
                      style: TextStyle(
                        fontSize: 23.sp,
                        color: white,
                      ),
                      btnColor: primaryColor,
                      btnHeight: 60.h,
                      btnWidth: 300.w,
                      isLoading: isLoading,
                      isDisabled: false,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          finishVisit(
                            context: context,
                            comment: commentController.text,
                            visitId: widget.visitId ?? 0,
                          );
                        }
                      },
                    );
                  },
                  isConsumerAction: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  finishVisit({
    required int visitId,
    required String comment,
    required BuildContext context,
  }) async {
    setState(() {
      loading = true;
    });
    final result = await context.read<FinishVisitCubit>().finishVisit(
          visitId: visitId,
          comment: comment,
        );

    if (result.message == "Success") {
      showSuccessMss();
      refresh(context);
    } else {
      showErrorMss(result);
    }
    setState(() {
      loading = false;
    });
  }

  void showErrorMss(BaseResponse<SuccessResponseModel?> result) {
    "${result.message}".showToast(
      backgroundColor: red,
      gravity: ToastGravity.CENTER,
    );
  }

  ModuleList mainDashboard = ModuleList(
    modules: const [], // Provide the necessary module data here
    isMainModule: true,
  );
  void refresh(BuildContext context) {
    Navigator.pop(context);
    supVisitsAgingListViewKey.currentState?.refresh();
    mainDashboard.refreshIndicatorMainDashBoardKey.currentState?.show();


    ///refreshIndicatorMainDashBoardKey.currentState?.show();
  }

  void showSuccessMss() {
    "Visit Finished Successfully".showToast(
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
    );
  }

  goToJPModule(BuildContext context, int index, int? visitId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => index == 0
            ? JPPhotosPage(
                visitId: visitId ?? 0,
              )
            : CheckListPage(
                visitId: visitId ?? 0,
              ),
      ),
    );
  }
}
