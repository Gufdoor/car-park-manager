import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/settings/settings_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ManagementBloc _managementBloc = Modular.get<ManagementBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _managementBloc,
      child: const SettingsScreen(),
    );
  }
}
