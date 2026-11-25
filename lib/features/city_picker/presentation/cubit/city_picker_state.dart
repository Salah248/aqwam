import 'package:equatable/equatable.dart';
import '../../../../core/errors/failure.dart';

import '../../../../core/utils/arabic_normalizer.dart';
import '../../domain/entities/location_entities.dart';
import '../../domain/location_search.dart';

enum CityPickerStatus { loading, ready, empty, failure }

enum CityPickerStep { country, region, city }

class CityPickerState extends Equatable {
  const CityPickerState({
    this.status = CityPickerStatus.loading,
    this.languageCode = 'ar',
    this.countries = const [],
    this.country,
    this.region,
    this.city,
    this.query = '',
    this.failure,
  });

  final CityPickerStatus status;
  final String languageCode;
  final List<Country> countries;
  final Country? country;
  final Region? region;
  final City? city;
  final String query;
  final Failure? failure;

  /// يغيّر الحالة العامة فقط. الاختيارات تتغير بـ [withSelection].
  CityPickerState copyWith({
    CityPickerStatus? status,
    List<Country>? countries,
    String? query,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return CityPickerState(
      status: status ?? this.status,
      languageCode: languageCode,
      countries: countries ?? this.countries,
      country: country,
      region: region,
      city: city,
      query: query ?? this.query,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  /// يستبدل الاختيارات كلها (القيم الفارغة تعني "ممسوحة") ويصفّر البحث.
  CityPickerState withSelection({
    Country? country,
    Region? region,
    City? city,
  }) {
    return CityPickerState(
      status: status,
      languageCode: languageCode,
      countries: countries,
      country: country,
      region: region,
      city: city,
    );
  }

  /// دولة بمحافظة واحدة: لا توجد خطوة محافظة.
  bool get hasRegionStep => country?.regions.length != 1;

  CityPickerStep get step {
    if (country == null) return CityPickerStep.country;
    if (region == null) return CityPickerStep.region;
    return CityPickerStep.city;
  }

  int get totalSteps => hasRegionStep ? 3 : 2;

  int get stepNumber => switch (step) {
    CityPickerStep.country => 1,
    CityPickerStep.region => 2,
    CityPickerStep.city => hasRegionStep ? 3 : 2,
  };

  bool get canConfirm => city != null;

  List<Country> get visibleCountries => _visible(
    countries,
    (c) => c.nameAr,
    (c) => c.nameEn,
    sortWhenIdle: true,
  );

  List<Region> get visibleRegions => _visible(
    country?.regions ?? const [],
    (r) => r.nameAr,
    (r) => r.nameEn,
    sortWhenIdle: true,
  );

  /// المدن تبقى بترتيب السكان من السكربت عند عدم البحث.
  List<City> get visibleCities => _visible(
    region?.cities ?? const [],
    (c) => c.nameAr,
    (c) => c.nameEn,
    sortWhenIdle: false,
  );

  List<T> _visible<T>(
    List<T> items,
    String Function(T) nameAr,
    String Function(T) nameEn, {
    required bool sortWhenIdle,
  }) {
    if (query.trim().isNotEmpty) {
      return searchLocations(items, query, nameAr: nameAr, nameEn: nameEn);
    }
    if (!sortWhenIdle) return items;
    final name = languageCode == 'ar' ? nameAr : nameEn;
    return [...items]..sort(
      (a, b) => normalizeSearch(name(a)).compareTo(normalizeSearch(name(b))),
    );
  }

  @override
  List<Object?> get props => [
    status,
    languageCode,
    countries,
    country,
    region,
    city,
    query,
    failure,
  ];
}
