import "package:car_park_manager/main_module.dart";
import "package:car_park_manager/src/bloc/theme_bloc.dart";
import "package:car_park_manager/src/bloc/theme_event.dart";
import "package:car_park_manager/src/modules/management/management_module.dart";
import "package:car_park_manager/src/widgets/custom_app_themes.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => ThemeBloc()..add(SetInitialTheme()),
      child: ModularApp(module: MainModule(), child: const MainApp()),
    ),
  );
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

    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: state
              ? CustomAppThemes.darkTheme
              : CustomAppThemes.lightTheme,
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          debugShowCheckedModeBanner: false,
          title: "Car Park Manager",
        );
      },
    );
  }
}
