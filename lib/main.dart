import 'package:aqwam/app/aqwam_app.dart';
import 'package:aqwam/core/di/injection.dart';
import 'package:flutter/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const AqwamApp());
}
