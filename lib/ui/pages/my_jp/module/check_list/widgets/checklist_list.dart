import 'package:c_supervisor/ui/index.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../../data/models/sup_visits/modules/check_list/checklist_model.dart';
import '../../../../team_kpi/index.dart';
import 'check_list_card.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/cubits/checklist_cubit.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/cubits/update_checklist_cubit.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/checklist_to_json_model.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorCheckListKey =
    GlobalKey<RefreshIndicatorState>();

class CheckListList extends StatefulWidget {
  const CheckListList({
    Key? key,
    this.visitId,
    required this.dataList,
  }) : super(key: key);

  final int? visitId;
  final List<CheckListModel> dataList;

  @override
  State<CheckListList> createState() => _CheckListListState();
}

class _CheckListListState extends State<CheckListList> {
  bool loading = false;
  List<bool> checkedStatusList = [];
  List<String> commentsCardList = [];
  List<String> rateCardList = [];

  @override
  void initState() {
    super.initState();
    initializeLists();
  }

  void initializeLists() {
    checkedStatusList = List.generate(
      widget.dataList.length,
      (index) => widget.dataList[index].checkedStatus ?? false,
    );

    for (int index = 0; index < widget.dataList.length; index++) {
      final comment = widget.dataList[index].comment ?? '';
      commentsCardList.add(comment);
    }
    rateCardList = List.generate(widget.dataList.length,
        (index) => (widget.dataList[index].rate ?? "0.0").toString());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      key: refreshIndicatorCheckListKey,
      onRefresh: () => _refreshData(context),
      child: Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemCount: widget.dataList.length,
                itemBuilder: (context, index) {
                  final model = widget.dataList[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      horizontalOffset: -300,
                      verticalOffset: -850,
                      child: CheckListCard(
                        visitId: widget.visitId ?? 0,
                        model: model,
                        index: index,
                        onCheckboxChanged: (isChecked) {
                          setState(() {
                            checkedStatusList[index] = isChecked;
                          });
                        },
                        commentsCardChanged: (String comment) {
                          commentsCardList[index] = comment;
                          if (kDebugMode) {
                            print(commentsCardList);
                          }
                        },
                        rateCardChanged: (rating) {
                          rateCardList[index] = rating.toString();
                          if (kDebugMode) {
                            //  print(rateCardList);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          LoadingButton(
            text: 'Submit All',
            borderRadius: 12,
            btnColor: primaryColor,
            btnHeight: 60.h,
            btnWidth: double.infinity,
            isLoading: loading,
            isDisabled: false,
            onPressed: () {
              updateAllChecklistItems();
            },
          )
        ],
      ),
    );
  }

  Future<void> _refreshData(BuildContext context) async {
    context.read<CheckListCubit>().getCheckList(visitId: widget.visitId ?? 0);
  }

  void updateAllChecklistItems() async {
    setState(() {
      loading = true;
    });

    final jsonData = constructJsonData();

    final result =
        await context.read<UpdateCheckListCubit>().updateVisitCheckList(
              model: UpdateCheckListToJsonModel(
                visitId: widget.visitId ?? 0,
                jsonArray: jsonData,
              ),
            );

    setState(() {
      loading = false;
    });

    if (!result.hasError) {
      showSuccessMessage();
      refreshPage();
    }
  }

  List<CheckListItemToJson> constructJsonData() {
    final jsonData = <CheckListItemToJson>[];

    for (int i = 0; i < widget.dataList.length; i++) {
      final model = widget.dataList[i];
      if (kDebugMode) {
        //   print('rateCardList==>>>>\n$rateCardList');
        //   print('checkedStatusList==>>>>\n$checkedStatusList');
        print('commentsCardList==>>>>$commentsCardList');
      }

      jsonData.add(
        CheckListItemToJson(
          checkItemID: model.checkItemID.toString(),
          itemResponseId: model.itemResponseId.toString(),
          checkedStatus: checkedStatusList[i] ? "1" : "0",
          rate: rateCardList[i].contains('.')
              ? rateCardList[i].split('.')[0]
              : rateCardList[i],
          comment: commentsCardList[i],
        ),
      );
    }

    return jsonData;
  }

  void showSuccessMessage() {
    "Updated Successfully".showToast(
      backgroundColor: Colors.green,
    );
  }

  void refreshPage() {
    refreshIndicatorCheckListKey.currentState?.show();
  }
}
