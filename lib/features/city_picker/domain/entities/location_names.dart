import 'location_entities.dart';

extension CountryNames on Country {
  String name(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;
  String regionLabel(String languageCode) =>
      languageCode == 'ar' ? regionLabelAr : regionLabelEn;
}

extension RegionNames on Region {
  String name(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;
}

extension CityNames on City {
  String name(String languageCode) => languageCode == 'ar' ? nameAr : nameEn;
}
