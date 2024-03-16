import "package:car_park_manager/src/modules/management/bloc/management_cubit.dart";
import "package:car_park_manager/src/modules/management/manager/manager_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final ManagementCubit _managementCubit = Modular.get<ManagementCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _managementCubit,
      child: const ManagerScreen(),
    );
  }
}
