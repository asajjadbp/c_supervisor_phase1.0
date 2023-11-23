/// Capturing a result (either a returned value or a thrown error)
///
class Result<Value> {
  /// Value
  ///
  final Value? _value;

  /// Error
  ///
  final Exception? _error;

  /// Private constructor
  ///
  Result._(this._value, this._error);

  /// Success case with value
  ///
  factory Result.success(Value value) {
    return Result._(value, null);
  }

  /// Failure case with error
  ///
  factory Result.failure(Exception error) {
    return Result._(null, error);
  }

  /// If this is a value result, returns itself
  ///
  Value? get asValue => _value;

  /// If this is an error result, returns itself
  ///
  Exception? get asError => _error;

  /// Returns error message if the type is [Result.failure]
  String? get errorMessage => _error?.toString();

  /// A future that has been completed with this result as a value or an error.
  ///
  Future<Value> asFuture() async {
    if (_error != null) throw _error!;
    return _value!;
  }

  /// Whether this result is a value result.
  ///
  bool isError() => _error != null;

  /// Whether this result is an error result.
  ///
  bool isValue() => _value != null;
}
