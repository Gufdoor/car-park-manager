import "dart:ui";

import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";

enum ParkingSpaceStatusEnum {
  vacant("Disponível"),
  occupied("Ocupada"),
  unavailable("Indisponível");

  final String title;

  const ParkingSpaceStatusEnum(this.title);

  Color get color {
    switch (this) {
      case ParkingSpaceStatusEnum.vacant:
        return CustomColorsConstants.yellowGreen;
      case ParkingSpaceStatusEnum.occupied:
        return CustomColorsConstants.coralRed;
      case ParkingSpaceStatusEnum.unavailable:
        return CustomColorsConstants.uTOrange;
    }
  }
}
