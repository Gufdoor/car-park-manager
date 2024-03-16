import 'package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart';

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
}
