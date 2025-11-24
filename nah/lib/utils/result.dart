/// [Result] is a utility class that simplifies handling errors as guided in the Design patterns article https://docs.flutter.dev/app-architecture/design-patterns/result.
/// It is used in the switch statements to handle different outcomes of an operation
/// It is a Sealed class so that it is not extended outside this file
sealed class Result<T> {
  const Result();
  // Making the subtypes private and forwarding
  const factory Result.success(T data) = Success._;
  const factory Result.error(Exception error) = Error._;
}

/// [Success] holds the data of an operation that was successful
/// It is final so that it cannot be extended
final class Success<T> extends Result<T> {
  final T data;

  // The private constructor is to prevent the instantiation of this class but only through the result class
  const Success._(this.data);

  @override
  String toString() => "Result<$T>.Success($data)";
}

/// [Error] holds the exception data of an operation that failed
/// It is final so that it cannot be extended
final class Error<T> extends Result<T> {
  final Exception error;

  // The private constructor is to prevent the instantiation of this class but only through the result class
  const Error._(this.error);

  @override
  String toString() => "Result<$T>.Error($error)";
}
