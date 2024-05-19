import "package:car_park_manager/src/modules/management/management_module.dart";
import "package:flutter_modular/flutter_modular.dart";

const String _management = "/management";

class MainModule extends Module {
  @override
  void routes(r) {
    r.module(_management, module: ManagementModule());
  }
}
