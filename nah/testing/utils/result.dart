import 'package:nah/utils/result.dart';

extension ResultCast<T> on Result<T> {
  /// Convenience method to cast to Ok
  Success<T> get asSuccess => this as Success<T>;

  /// Convenience method to cast to Error
  Error get asError => this as Error<T>;
}
