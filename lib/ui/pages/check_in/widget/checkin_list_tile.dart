import 'package:c_supervisor/data/models/common_data_model.dart';
import 'package:c_supervisor/styles/index.dart';
import 'package:flutter/material.dart';

class CheckInListTile extends StatefulWidget {
  const CheckInListTile({
    super.key,
    required this.dataModel,
    required this.selections,
    required this.currentIndex,
    required  this.selectionsCheckBox,
   });

  final CommonDataModel? dataModel;
  final List<bool> selections;
  final int currentIndex;
  final ValueChanged<List<bool>> selectionsCheckBox;


  @override
  State<CheckInListTile> createState() => _CheckInListTileState();
}

class _CheckInListTileState extends State<CheckInListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        widget.dataModel?.value ?? '',
        maxLines: 1,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
      activeColor: primaryColor,
      onChanged: (value) => setState(() {
        widget.selections[widget.currentIndex] = (value ?? false);
       widget.selectionsCheckBox(widget.selections.map((e) => e??false).toList());
      }),
      value: widget.selections[widget.currentIndex],
    );
  }
}
