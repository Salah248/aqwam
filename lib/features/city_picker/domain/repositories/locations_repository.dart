import '../../../../core/errors/result.dart';
import '../entities/location_entities.dart';

abstract interface class LocationsRepository {
  /// كل الدول بمحافظاتها ومدنها (تُحمَّل مرة واحدة وتُخزَّن).
  Future<Result<List<Country>>> getCountries();
}
