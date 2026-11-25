import '../../../../core/errors/result.dart';
import '../entities/selected_location.dart';

abstract interface class SelectedLocationStorage {
  /// `null` لو لم يُختَر موقع بعد، أو كانت الداتا المحفوظة تالفة.
  Future<Result<SelectedLocation?>> read();

  /// يرمي استثناء لو فشلت الكتابة.
  Future<Result<void>> save(SelectedLocation location);
}
