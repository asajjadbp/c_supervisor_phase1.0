class SearchArgs {
  final List<int>? childIds;
  final List<int>? cityIDs;
  final List<int>? chainIDs;
  final List<int>? companyIDs;
  final List<int>? regionIDs;
  final String? visitStartDate;
  final String? visitEndDate;
  final String? visitsDate;
  final String ?startDate;
  final int?status;

  SearchArgs({
     this.childIds,
     this.startDate,
     this.cityIDs,
     this.chainIDs,
    this.visitStartDate,
    this.visitEndDate,
    this.visitsDate,
    this.companyIDs,
    this.regionIDs,
    this.status,
  });
}
