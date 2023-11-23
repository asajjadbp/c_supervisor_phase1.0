enum SortingDirection { ascending, descending }

extension SortingDirectionApiCode on SortingDirection {
  int getApiCode() {
    int result = 0;
    if (this == SortingDirection.descending) {
      result = 1;
    }
    return result;
  }
}
