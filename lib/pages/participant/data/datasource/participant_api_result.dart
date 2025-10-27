sealed class ParticipantApiResult<T> {
  const ParticipantApiResult();
  R when<R>({
    required R Function(T data) success,
    required R Function(ApiError e) failure,
  }) => this is Success<T>
      ? success((this as Success<T>).data)
      : failure((this as Failure<T>).error);
}

final class Success<T> extends ParticipantApiResult<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends ParticipantApiResult<T> {
  final ApiError error;
  const Failure(this.error);
}

class ApiError {
  final String message;
  final int? statusCode;
  final Object? raw;
  const ApiError(this.message, {this.statusCode, this.raw});
}
