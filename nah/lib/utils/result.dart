sealed class Result<T> {
  const Result();
  const factory Result.success(T data) = Success._;

  const factory Result.failure(Exception error) = Failure._;
}

class Success<T> extends Result<T> {
  final T data;

  const Success._(this.data);

  @override
  String toString() => "Result<$T>: Success:$data";
}

class Failure<T> extends Result<T> {
  final Exception error;

  const Failure._(this.error);

  @override
  String toString() => "Result<$T>: Failure:$error";
}
