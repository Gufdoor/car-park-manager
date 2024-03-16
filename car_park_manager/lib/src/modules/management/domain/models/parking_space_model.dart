import 'package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart';
import 'package:car_park_manager/src/modules/management/domain/models/vehicle_model.dart';

class ParkingSpaceModel {
  late int id;
  late ParkingSpaceStatusEnum status;
  late List<VehicleModel>? vehicles;

  ParkingSpaceModel({
    required this.id,
    this.status = ParkingSpaceStatusEnum.vacant,
    this.vehicles,
  }) {
    vehicles = vehicles ?? [];
  }
}
