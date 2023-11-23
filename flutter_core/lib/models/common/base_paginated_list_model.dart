class BasePaginatedListModel<T> {
  BasePaginatedListModel({
    required this.dataList,
    required this.totalCount,
  });

  List<T> dataList;
  int totalCount;
}
