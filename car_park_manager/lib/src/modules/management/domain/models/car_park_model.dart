import 'package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart';
import 'package:car_park_manager/src/modules/management/domain/models/register_model.dart';

class CarParkModel {
  late int vacancies;
  late List<ParkingSpaceModel>? parkingSpaces;

  CarParkModel({
    required this.vacancies,
    this.parkingSpaces,
  }) {
    parkingSpaces = parkingSpaces ?? [];
  }

  void generateParkingSpaces() {
    parkingSpaces = List.generate(
      vacancies,
      (index) => ParkingSpaceModel(id: index),
    );
  }

  List<RegisterModel> getAllRegisters() {
    final List<RegisterModel> registers = [];

    for (final parkingSpace in parkingSpaces!) {
      registers.addAll(parkingSpace.registers!);
    }

    registers.sort((a, b) => b.checkOut.compareTo(a.checkOut));

    return registers;
  }
}
