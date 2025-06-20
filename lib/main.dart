import 'package:flutter/material.dart';
import 'package:gharko_doctor/app/myapp.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/core/network/hive_services.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  await HiveServices().init();
  
  runApp(const MyApp());

}