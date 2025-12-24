import 'package:nah/utils/result.dart';

extension ResultCast<T> on Result<T> {
  Success<T> get asSuccess => this as Success<T>;

  Error get asError => this as Error<T>;
}
