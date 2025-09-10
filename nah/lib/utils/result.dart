///The `sealed` keyword restricts subclassing to the same file,
///
///The [Result] class has factory constructors that forward the parameters to the subclsses [Success] or [Error]
library;

sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success._;

  const factory Result.error(Exception error) = Error._;
}

final class Success<T> extends Result<T> {
  final T data;

  const Success._(this.data);

  @override
  String toString() => "Result<$T>: Success:$data";
}

class Error<T> extends Result<T> {
  final Exception error;

  const Error._(this.error);

  @override
  String toString() => "Result<$T>: Success:$error";
}
