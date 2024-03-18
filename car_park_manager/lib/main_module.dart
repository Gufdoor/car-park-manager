import "package:car_park_manager/src/modules/management/management_module.dart";
import "package:flutter_modular/flutter_modular.dart";

const String _management = "/management";

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(_management, module: ManagementModule()),
      ];
}
