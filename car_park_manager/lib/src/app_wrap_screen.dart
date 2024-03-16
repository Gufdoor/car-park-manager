import "package:car_park_manager/src/app_wrap_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class AppWrapScreen extends StatefulWidget {
  const AppWrapScreen({super.key});

  @override
  State<AppWrapScreen> createState() => _AppWrapScreenState();
}

class _AppWrapScreenState extends State<AppWrapScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              _handleAlerts(),
              const RouterOutlet(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _handleAlerts() {
    final AppWrapCubit appCubit = AppWrapCubit.instance;

    return Column(
      children: [
        BlocProvider.value(
          value: appCubit,
          child: const Column(
            children: [],
          ),
        ),
      ],
    );
  }
}
