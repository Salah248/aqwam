sealed class Failure {
  const Failure();
}

final class StorageFailure extends Failure {
  const StorageFailure();
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

final class PermissionFailure extends Failure {
  const PermissionFailure();
}
