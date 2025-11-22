/// [Result] is a sealed class that represents either a success or an error.
/// It is used in the switch statements to handle different outcomes of an operation
/// Sealed class so that it is not extended outside this file
sealed class Result<T> {
  const Result();
  const factory Result.success(T data) = Success._;
  const factory Result.error(Exception error) = Error._;
}

/// [Success] holds the data of an operation that was successful
/// It is final so that it cannot be extended
final class Success<T> extends Result<T> {
  final T data;
  const Success._(this.data);

  @override
  String toString() => "Result<$T>.Success($data)";
}

/// [Error] holds the data of an operation that failed
/// It is final so that it cannot be extended
final class Error<T> extends Result<T> {
  final Exception error;
  const Error._(this.error);

  @override
  String toString() => "Result<$T>.Error($error)";
}
