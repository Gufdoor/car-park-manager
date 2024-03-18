import 'package:car_park_manager/main_module.dart';
import 'package:car_park_manager/src/modules/management/management_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ModularApp(module: MainModule(), child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(routeManager);

    return MaterialApp.router(
      theme: ThemeData(fontFamily: "Nunito-Sans"),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: "Car Park Manager",
    );
  }
}
