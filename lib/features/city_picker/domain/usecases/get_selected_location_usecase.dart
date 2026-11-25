import '../../../../core/errors/result.dart';
import '../entities/selected_location.dart';
import '../repositories/selected_location_storage.dart';

final class GetSelectedLocationUsecase {
  const GetSelectedLocationUsecase(this._storage);

  final SelectedLocationStorage _storage;

  Future<Result<SelectedLocation?>> call() => _storage.read();
}
