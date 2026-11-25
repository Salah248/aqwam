import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';

import '../../domain/entities/location_entities.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/usecases/save_selected_location_usecase.dart';
import 'city_picker_state.dart';
import '../../domain/entities/selected_location.dart';

class CityPickerCubit extends Cubit<CityPickerState> {
  CityPickerCubit(
    this._getCountries,
    this._saveSelectedLocation, {
    required String languageCode,
  }) : super(CityPickerState(languageCode: languageCode));

  final GetCountriesUsecase _getCountries;
  final SaveSelectedLocationUsecase _saveSelectedLocation;

  Future<void> load() async {
    emit(state.copyWith(status: CityPickerStatus.loading, clearFailure: true));
    switch (await _getCountries()) {
      case Success(value: final countries):
        emit(
          state.copyWith(
            status: countries.isEmpty
                ? CityPickerStatus.empty
                : CityPickerStatus.ready,
            countries: countries,
            clearFailure: true,
          ),
        );
      case Err(:final failure):
        emit(
          state.copyWith(status: CityPickerStatus.failure, failure: failure),
        );
    }
  }

  void selectCountry(Country country) {
    final onlyRegion = country.regions.length == 1
        ? country.regions.single
        : null;
    emit(state.withSelection(country: country, region: onlyRegion));
  }

  void selectRegion(Region region) {
    emit(state.withSelection(country: state.country, region: region));
  }

  void selectCity(City city) {
    emit(
      state.withSelection(
        country: state.country,
        region: state.region,
        city: city,
      ),
    );
  }

  /// يُستدعى من زر × في الـ chip: يرجع للخطوة ويمسح ما بعدها.
  void goToStep(CityPickerStep step) {
    switch (step) {
      case CityPickerStep.country:
        emit(state.withSelection());
      case CityPickerStep.region:
        if (state.hasRegionStep) {
          emit(state.withSelection(country: state.country));
        }
      case CityPickerStep.city:
        emit(
          state.withSelection(country: state.country, region: state.region),
        );
    }
  }

  void search(String query) => emit(state.copyWith(query: query));

  /// يحفظ الاختيار. يرجّع `true` عند النجاح.
  Future<Result<void>> confirm() async {
    final country = state.country;
    final region = state.region;
    final city = state.city;
    if (country == null || region == null || city == null) {
      return const Err(UnexpectedFailure());
    }
    final result = await _saveSelectedLocation(
      SelectedLocation.fromSelection(
        country: country,
        region: region,
        city: city,
      ),
    );
    switch (result) {
      case Success():
        emit(state.copyWith(clearFailure: true));
      case Err(:final failure):
        emit(state.copyWith(failure: failure));
    }
    return result;
  }
}
