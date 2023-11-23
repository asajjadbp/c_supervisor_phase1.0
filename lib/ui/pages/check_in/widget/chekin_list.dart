import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/models/common_data_list_model.dart';
import 'package:c_supervisor/ui/pages/check_in/widget/checkin_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class CheckInList extends StatelessWidget {
  const CheckInList(this.onChangeSelection,{Key? key}) : super(key: key);
  final ValueChanged<List<bool>> onChangeSelection;

  @override
  Widget build(BuildContext context) {
    final CommonDataListModel? checkInList =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserCheckInList();
    List<bool> selections = [];
    checkInList?.dataList?.forEach((element) {
      selections.add(false);
    });
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: checkInList?.dataList?.length ?? 0,
        itemBuilder: (context, index) {
          return CheckInListTile(
            dataModel: checkInList?.dataList![index],
            selections: selections,
            currentIndex: index,
            selectionsCheckBox:onChangeSelection,

          );
        },
      ),
    );
  }
}
