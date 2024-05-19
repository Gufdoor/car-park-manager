import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/manager/manager_page.dart";
import "package:car_park_manager/src/modules/management/settings/settings_page.dart";
import "package:flutter_modular/flutter_modular.dart";

const String _manager = "/manager";
const String _settings = "/settings";

const String routeManager = "/management$_manager";
const String routeSettings = "/management$_settings";

class ManagementModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ManagementBloc>(
      () => ManagementBloc(),
      config: BindConfig(
        onDispose: (bloc) => bloc.dispose(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child(_manager, child: (_) => const ManagerPage());
    r.child(_settings, child: (_) => const SettingsPage());
  }
}
