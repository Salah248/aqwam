import '../entities/location_entities.dart';
import '../repositories/locations_repository.dart';
import '../../../../core/errors/result.dart';

final class GetCountriesUsecase {
  const GetCountriesUsecase(this._repository);

  final LocationsRepository _repository;

  Future<Result<List<Country>>> call() => _repository.getCountries();
}
