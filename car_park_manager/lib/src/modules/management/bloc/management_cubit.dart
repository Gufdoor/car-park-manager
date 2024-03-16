import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class ManagementCubit extends Cubit<ManagementState> implements Disposable {
  ManagementCubit() : super(const ManagementState()) {
    // _init();
  }

  // final ConnectionController _connectionService = ConnectionController.instance;
  //
  // late DeviceModel _device = DeviceModel();
  //
  // late StreamSubscription<double> _concentrationSubscription;
  //
  @override
  void dispose() {
    // _device = DeviceModel();
    // unawaited(_concentrationSubscription.cancel());
  }
//
// Future<bool> connectDevice(String ip) async {
//   AppWrapCubit.instance.initLoading(message: "Carregando");
//
//   final bool hasSucceeded = await _connectionService.connect(ip);
//
//   if (hasSucceeded) {
//     Modular.to.navigate(routeDevice);
//     _device.ip = ip;
//   }
//
//   AppWrapCubit.instance.finishLoading();
//   _update();
//   return hasSucceeded;
// }
//
// void disconnectDevice() {
//   AppWrapCubit.instance.initLoading(message: "Carregando");
//
//   _connectionService.disconnect();
//   _device = DeviceModel();
//   Modular.to.navigate(routeConnect);
//
//   AppWrapCubit.instance.finishLoading();
//   _update();
// }
//
// void setEnvironment(EnvironmentSettingEnum environment) {
//   _device.environment = environment;
//   _update();
// }
//
// void _init() async {
//   AppWrapCubit.init();
//   ConnectionController.init();
//   _startListeners();
// }
//
// void _startListeners() {
//   _concentrationSubscription = ConnectionController
//       .instance.streamConcentration
//       .listen((concentration) {
//     _handleConcentrationCallback(concentration);
//   });
// }
//
// void _handleConcentrationCallback(double concentration) {
//   final double percentage = concentration / 4095;
//   _device.gasConcentration = percentage * _device.environment.ratio;
//   print(">>> $concentration | $percentage");
//   if (percentage < LeakageStatusEnum.attention.percentage) {
//     _device.leakage = LeakageStatusEnum.secure;
//   } else if (percentage < LeakageStatusEnum.danger.percentage) {
//     _device.leakage = LeakageStatusEnum.attention;
//   } else if (percentage < LeakageStatusEnum.critic.percentage) {
//     _device.leakage = LeakageStatusEnum.danger;
//   } else {
//     _device.leakage = LeakageStatusEnum.critic;
//   }
//
//   _update();
// }
//
// void _update() {
//   emit(state.copyWith(status: GasecStatus.initial, device: _device));
// }
}
