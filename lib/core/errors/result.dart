sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}

sealed class Failure {
  const Failure(this.kind);

  final FailureKind kind;
}

enum FailureKind {
  network,
  storage,
  permission,
  validation,
  notFound,
  unexpected,
}

final class NetworkFailure extends Failure {
  const NetworkFailure() : super(FailureKind.network);
}

final class StorageFailure extends Failure {
  const StorageFailure() : super(FailureKind.storage);
}

final class PermissionFailure extends Failure {
  const PermissionFailure() : super(FailureKind.permission);
}

final class ValidationFailure extends Failure {
  const ValidationFailure() : super(FailureKind.validation);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure() : super(FailureKind.notFound);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super(FailureKind.unexpected);
}
