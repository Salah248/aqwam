import '../../../../core/errors/result.dart';
import '../entities/selected_location.dart';
import '../repositories/selected_location_storage.dart';

final class SaveSelectedLocationUsecase {
  const SaveSelectedLocationUsecase(this._storage);

  final SelectedLocationStorage _storage;

  Future<Result<void>> call(SelectedLocation location) =>
      _storage.save(location);
}
