import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("ManagementState", () {
    final CarParkModel mockCarPark = CarParkModel(vacancies: 0);

    ManagementState createSubject() => ManagementState(carPark: mockCarPark);

    test("Given two equal objects when compared they should be equal", () {
      expect(createSubject(), createSubject());
    });

    test("Given an objects when updated it should update on state too", () {
      expect(
        createSubject().copyWith(status: ManagementBlocStatus.initial),
        const ManagementState(
          isRefresh: true,
          status: ManagementBlocStatus.initial,
        ),
      );
    });
  });
}
