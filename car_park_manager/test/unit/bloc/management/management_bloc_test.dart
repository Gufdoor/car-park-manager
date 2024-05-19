import "package:bloc_test/bloc_test.dart";
import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ManagementCubit", () {
    setUp(() {});

    ManagementBloc buildCubit() => ManagementBloc();

    group("Constructor", () {
      test("Calling cubit constructor should initiate correctly", () {
        expect(buildCubit, returnsNormally);
      });

      test("Given a cubit init it should has a correct initial state", () {
        expect(buildCubit().state, equals(const ManagementState()));
      });
    });

    group("Methods", () {
      blocTest(
        "Given a new car park set with n vacancies when setCarPark is called then should instantiate the model with n vacancies",
        build: () => ManagementBloc(),
        act: (cubit) => cubit.setCarPark("5"),
        expect: () => [isA<ManagementState>()],
      );

      blocTest(
        "When calling clearRegisters then carPark instance should be reset to null",
        build: () => ManagementBloc(),
        act: (cubit) => cubit.clearRegisters(),
        expect: () => [isA<ManagementState>()],
      );

      blocTest(
        "When calling toggleParkingSpaceAvailability then desired parkingSpace should update status to unavailable",
        build: () => ManagementBloc(),
        act: (cubit) {
          cubit.setCarPark("7");
          cubit.toggleParkingSpaceAvailability(0);
        },
        skip: 1,
        expect: () => [isA<ManagementState>()],
      );

      blocTest(
        "When calling checkInVehicle then a register for the desired parkingSpaceModel should be updated",
        build: () => ManagementBloc(),
        act: (cubit) {
          cubit.setCarPark("7");
          cubit.checkInVehicle("abc1324", 0);
        },
        skip: 1,
        expect: () => [isA<ManagementState>()],
      );

      blocTest(
        "When calling checkOutVehicle then a register for the desired parkingSpaceModel should be updated",
        build: () => ManagementBloc(),
        act: (cubit) {
          cubit.setCarPark("7");
          cubit.checkInVehicle("abc1324", 0);
          cubit.checkOutVehicle(0);
        },
        skip: 2,
        expect: () => [isA<ManagementState>()],
      );
    });
  });
}
