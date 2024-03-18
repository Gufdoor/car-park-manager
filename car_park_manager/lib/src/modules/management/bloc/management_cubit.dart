import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart";
import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:car_park_manager/src/modules/management/domain/models/register_model.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ManagementCubit extends Cubit<ManagementState> {
  ManagementCubit() : super(const ManagementState());

  late CarParkModel? _carPark;

  /// region Public methods

  void setCarPark(String auxVacancies) {
    /// The regex below searches for numbers only
    if (auxVacancies.isEmpty || auxVacancies.contains(RegExp(r'[^0-9]'))) {
      return;
    }

    final int vacancies = int.parse(
      auxVacancies.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    _carPark = CarParkModel(vacancies: vacancies);
    _carPark!.generateParkingSpaces();
    _update();
  }

  void clearRegisters() {
    _carPark = null;
    _update();
  }

  void toggleParkingSpaceAvailability(int parkingSpaceId) {
    final int index = _carPark!.parkingSpaces!
        .indexWhere((parkingSpace) => parkingSpace.id == parkingSpaceId);

    if (index < 0) {
      return;
    }

    if (_carPark!.parkingSpaces![index].status ==
        ParkingSpaceStatusEnum.unavailable) {
      _carPark!.parkingSpaces![index].status = ParkingSpaceStatusEnum.vacant;
    } else {
      _carPark!.parkingSpaces![index].status =
          ParkingSpaceStatusEnum.unavailable;
    }

    _update();
  }

  void checkInVehicle(String licensePlate, int parkingSpaceId) {
    final int index = _carPark!.parkingSpaces!
        .indexWhere((parkingSpace) => parkingSpace.id == parkingSpaceId);

    if (index < 0) {
      return;
    }

    _carPark!.parkingSpaces![index].registers!.add(
      RegisterModel(
        licensePlate: licensePlate.toUpperCase(),
        parkingSpaceId: parkingSpaceId,
        checkIn: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    _carPark!.parkingSpaces![index].status = ParkingSpaceStatusEnum.occupied;
    _update();
  }

  void checkOutVehicle(int parkingSpaceId) {
    final int index = _carPark!.parkingSpaces!
        .indexWhere((parkingSpace) => parkingSpace.id == parkingSpaceId);

    if (index < 0) {
      return;
    }

    _carPark!.parkingSpaces![index].registers!.last.checkOut =
        DateTime.now().millisecondsSinceEpoch;
    _carPark!.parkingSpaces![index].status = ParkingSpaceStatusEnum.vacant;
    _update();
  }

  /// endregion Public methods

  /// region Private methods

  void _update() {
    emit(state.copyWith(status: ManagementCubitStatus.initial, carPark: _carPark));
  }

  /// endregion Private methods
}
