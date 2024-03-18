class RegisterModel {
  late String licensePlate;
  late int parkingSpaceId;
  late int checkIn;
  late int checkOut;

  RegisterModel({
    this.licensePlate = "",
    this.parkingSpaceId = -1,
    this.checkIn = 0,
    this.checkOut = 0,
  });
}
