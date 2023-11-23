extension CompactMap<T> on List<T> {
  /// Returns a list of non-null values after performing the given transformation method [f]
  ///
  /// [f] is performed after removing all the non-null values from the list
  List<E> compactMap<E>(E? Function(T element) f) {
    Iterable<E> imp(E? Function(T element) f) sync* {
      for (final value in this) {
        final mapped = f(value);
        if (mapped != null) {
          yield mapped;
        }
      }
    }

    return imp(f).toList();
  }
}

extension FlatMap<T> on T? {
  /// Returns a flattened list after performing the provided transformation method [f] on it
  ///
  /// concatenates the list values and flatten them then performs [f] method on the list
  E? flatMap<E>(E? Function(T value) f) {
    if (this != null) {
      return f(this!);
    } else {
      return null;
    }
  }
}
