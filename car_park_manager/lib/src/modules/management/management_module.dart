import "package:car_park_manager/src/modules/management/bloc/management_cubit.dart";
import "package:car_park_manager/src/modules/management/manager/manager_page.dart";
import "package:car_park_manager/src/modules/management/settings/settings_page.dart";
import "package:flutter_modular/flutter_modular.dart";

const String _manager = "/manager";
const String _settings = "/settings";

const String routeManager = "/management$_manager";
const String routeSettings = "/management$_settings";

class ManagementModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ManagementCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(_manager, child: (_, __) => const ManagerPage()),
        ChildRoute(_settings, child: (_, __) => const SettingsPage()),
      ];
}
