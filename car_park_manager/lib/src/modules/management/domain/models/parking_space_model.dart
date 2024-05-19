import "package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart";
import "package:car_park_manager/src/modules/management/domain/models/register_model.dart";

class ParkingSpaceModel {
  late int id;
  late ParkingSpaceStatusEnum status;
  late List<RegisterModel>? registers;

  ParkingSpaceModel({
    required this.id,
    this.status = ParkingSpaceStatusEnum.vacant,
    this.registers,
  }) {
    registers = registers ?? [];
  }
}
