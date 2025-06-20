import 'package:flutter/material.dart';
import 'package:gharko_doctor/app/myapp.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await serviceLocator<HiveServices>().init();
  runApp(const MyApp());
  }
