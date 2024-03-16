import "package:car_park_manager/src/app_wrap_page.dart";
import "package:car_park_manager/src/modules/management/management_module.dart";
import "package:flutter_modular/flutter_modular.dart";

const String _management = "/management";

class MainModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => const AppWrapPage(),
          transition: TransitionType.noTransition,
          children: [
            ModuleRoute(_management, module: ManagementModule()),
          ],
        )
      ];
}
