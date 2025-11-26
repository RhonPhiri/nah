import 'package:nah/utils/result.dart';

/// [ResultCast] extension on [Result]
/// Typecasts the [Success] & [Error] subtypes for convenience
///
extension ResultCast<T> on Result<T> {
  Success<T> get asSuccess => this as Success<T>;

  Error<T> get asError => this as Error<T>;
}
