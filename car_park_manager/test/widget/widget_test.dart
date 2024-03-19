import 'package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart';
import 'package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart';
import 'package:car_park_manager/src/modules/management/domain/models/register_model.dart';
import 'package:car_park_manager/src/modules/management/widgets/custom_parking_space_tile.dart';
import 'package:car_park_manager/src/modules/management/widgets/custom_register_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Tiles", () {
    testWidgets(
      "When CustomParkingSpaceTile is called then 'tis expected a tile will be build properly with the correct texts.",
      (tester) async {
        // arrange
        final RegisterModel register = RegisterModel()
          ..parkingSpaceId = 0
          ..licensePlate = "abc1234";
        final ParkingSpaceModel parkingSpace = ParkingSpaceModel(id: 0)
          ..status = ParkingSpaceStatusEnum.vacant
          ..registers = [register];

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomParkingSpaceTile(
                parkingSpaceIndex: 0,
                parkingSpace: parkingSpace,
              ),
            ),
          ),
        );

        // assert
        expect(find.text("Vaga 0"), findsOneWidget);
        expect(find.text("Placa: abc1234"), findsOneWidget);
      },
    );

    testWidgets(
      "When CustomRegisterTile is called then 'tis expected a tile will be build properly with the correct texts.",
      (tester) async {
        // arrange
        final RegisterModel register = RegisterModel()
          ..checkOut = 946684800000
          ..parkingSpaceId = 0;

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: CustomRegisterTile(register: register)),
          ),
        );

        // assert
        expect(find.text("Vaga 0"), findsOneWidget);
        expect(find.text("Check-out: 31/12/1999 22:00"), findsOneWidget);
      },
    );
  });
}
