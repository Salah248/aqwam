import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.regionLabelAr,
    required this.regionLabelEn,
    required this.regions,
  });

  final String code; // ISO مثل EG
  final String nameAr;
  final String nameEn;
  final String regionLabelAr; // مثل: الولاية
  final String regionLabelEn; // مثل: Province
  final List<Region> regions;

  @override
  List<Object?> get props => [code];
}

class Region extends Equatable {
  const Region({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.cities,
  });

  final String id; // مثل EG.11
  final String nameAr;
  final String nameEn;
  final List<City> cities;

  @override
  List<Object?> get props => [id];
}

class City extends Equatable {
  const City({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.latitude,
    required this.longitude,
    required this.timeZone,
  });

  final int id; // GeoNames id
  final String nameAr;
  final String nameEn;
  final double latitude;
  final double longitude;
  final String timeZone; // مثل Africa/Cairo

  @override
  List<Object?> get props => [id];
}
