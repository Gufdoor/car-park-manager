import "package:car_park_manager/src/core/helpers/timestamp_helper.dart";
import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test(
    "Given an amount n when generateParkingSpaces is called then n objects of ParkingSpaceModel should be created.",
    () {
      // arrange
      const int amount = 10;
      final CarParkModel parkModel = CarParkModel(vacancies: amount);

      // act
      parkModel.generateParkingSpaces();

      // assert
      expect(parkModel.parkingSpaces!.length, amount);
    },
  );

  test(
    "Given an int timestamp when getDateTimeStringFromTimestamp is called then it should be converted to a proper date and time String",
    () {
      // arrange
      const int timestamp = 946684800000;
      const String dateTime = "01/01/2000 00:00";

      // act
      final String testDateTime =
          TimestampHelper.getDateTimeStringFromTimestamp(
        timestamp,
        isUtc: true,
      );

      // assert
      expect(testDateTime, dateTime);
    },
  );
}
