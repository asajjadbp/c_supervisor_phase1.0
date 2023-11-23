import 'package:c_supervisor/ui/index.dart';

class FileForSection extends StatefulWidget {
  const FileForSection({
    Key? key,
    required this.dataList,
    required this.selectedCategory,
  }) : super(key: key);

  final List<KnowledgeBaseCategoriesModel> dataList;
  final ValueChanged<KnowledgeBaseCategoriesModel> selectedCategory;

  @override
  State<FileForSection> createState() => _FileForSectionState();
}

class _FileForSectionState extends State<FileForSection> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200.h,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final item = widget.dataList[index];
                        return ListTile(
                          title: Text(item.value.toString()),
                          onTap: () {
                            setState(() {
                              selectedValue = item.value;
                              widget.selectedCategory(item);
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                      itemCount: widget.dataList.length,
                      separatorBuilder: (context, i) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            );
          },
        ).then((value) {
          if (value != null) {
            selectedValue = value as String;
          }
        });
      },
      child: Row(
        children: [
          Expanded(
            child: CustomTextField.withDarkBorder(
              labelText: selectedValue ?? 'Select File',
              height: 53.h,
              keyboardType: TextInputType.emailAddress,
              isEnabled: false,
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_sharp,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
