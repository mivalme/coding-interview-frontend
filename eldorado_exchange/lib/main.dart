import 'package:flutter/material.dart';
import 'core/di/dependencies.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await deps.init();
  runApp(const App());
}
