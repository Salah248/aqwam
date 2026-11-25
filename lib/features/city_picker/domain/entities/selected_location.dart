import 'package:equatable/equatable.dart';

import 'location_entities.dart';

/// نسخة مفصولة من الاختيار، آمنة للتخزين وتكفي لحساب المواقيت.
class SelectedLocation extends Equatable {
  const SelectedLocation({
    required this.countryCode,
    required this.countryNameAr,
    required this.countryNameEn,
    required this.regionId,
    required this.regionNameAr,
    required this.regionNameEn,
    required this.cityId,
    required this.cityNameAr,
    required this.cityNameEn,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
  });

  factory SelectedLocation.fromSelection({
    required Country country,
    required Region region,
    required City city,
  }) {
    return SelectedLocation(
      countryCode: country.code,
      countryNameAr: country.nameAr,
      countryNameEn: country.nameEn,
      regionId: region.id,
      regionNameAr: region.nameAr,
      regionNameEn: region.nameEn,
      cityId: city.id,
      cityNameAr: city.nameAr,
      cityNameEn: city.nameEn,
      latitude: city.latitude,
      longitude: city.longitude,
      timeZone: city.timeZone,
    );
  }

  static const _version = 1;

  final String countryCode;
  final String countryNameAr;
  final String countryNameEn;
  final String regionId;
  final String regionNameAr;
  final String regionNameEn;
  final int cityId;
  final String cityNameAr;
  final String cityNameEn;
  final double latitude;
  final double longitude;
  final String timeZone;

  Map<String, Object> toJson() => {
    'v': _version,
    'countryCode': countryCode,
    'countryAr': countryNameAr,
    'countryEn': countryNameEn,
    'regionId': regionId,
    'regionAr': regionNameAr,
    'regionEn': regionNameEn,
    'cityId': cityId,
    'cityAr': cityNameAr,
    'cityEn': cityNameEn,
    'lat': latitude,
    'lng': longitude,
    'tz': timeZone,
  };

  /// يرجّع `null` لو الشكل غير معروف أو الداتا تالفة.
  static SelectedLocation? tryFromJson(Object? json) {
    if (json is! Map<String, dynamic> || json['v'] != _version) return null;
    try {
      return SelectedLocation(
        countryCode: json['countryCode'] as String,
        countryNameAr: json['countryAr'] as String,
        countryNameEn: json['countryEn'] as String,
        regionId: json['regionId'] as String,
        regionNameAr: json['regionAr'] as String,
        regionNameEn: json['regionEn'] as String,
        cityId: json['cityId'] as int,
        cityNameAr: json['cityAr'] as String,
        cityNameEn: json['cityEn'] as String,
        latitude: (json['lat'] as num).toDouble(),
        longitude: (json['lng'] as num).toDouble(),
        timeZone: json['tz'] as String,
      );
    } on Object {
      return null;
    }
  }

  @override
  List<Object?> get props => [
    countryCode,
    countryNameAr,
    countryNameEn,
    regionId,
    regionNameAr,
    regionNameEn,
    cityId,
    cityNameAr,
    cityNameEn,
    latitude,
    longitude,
    timeZone,
  ];
}
