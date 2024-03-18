import "package:car_park_manager/src/core/helpers/timestamp_helper.dart";
import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";
import "package:car_park_manager/src/modules/management/bloc/management_cubit.dart";
import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart";
import "package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class CustomParkingSpaceBottomSheet extends StatefulWidget {
  final int index;

  const CustomParkingSpaceBottomSheet({
    required this.index,
    super.key,
  });

  @override
  State<CustomParkingSpaceBottomSheet> createState() =>
      _CustomParkingSpaceBottomSheetState();
}

class _CustomParkingSpaceBottomSheetState
    extends State<CustomParkingSpaceBottomSheet> {
  final TextEditingController licensePlateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementCubit, ManagementState>(
      builder: (context, state) {
        return SizedBox(
          height: 400.0,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: handleStatusContent(
                state.carPark!.parkingSpaces![widget.index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget handleStatusContent(ParkingSpaceModel parkingSpace) {
    return parkingSpace.status == ParkingSpaceStatusEnum.occupied
        ? buildOccupiedContent(parkingSpace)
        : buildRegisterContent(parkingSpace);
  }

  Widget buildRegisterContent(ParkingSpaceModel parkingSpace) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 6.0,
          width: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Vaga ${parkingSpace.id}",
              style: const TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 200.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: parkingSpace.status.color,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  parkingSpace.status.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Gerenciar disponibilidade da vaga",
            style: TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              child: Text(
                "Caso esta vaga não possa ser usada, marque-a como indisponível",
                style: TextStyle(
                  color: CustomColorsConstants.onyx,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Switch(
              value: parkingSpace.status == ParkingSpaceStatusEnum.unavailable,
              activeTrackColor: CustomColorsConstants.uTOrange,
              onChanged: (isUnavailable) {
                Modular.get<ManagementCubit>().toggleParkingSpaceAvailability(
                  parkingSpace.id,
                );
              },
            ),
          ],
        ),
        const Divider(height: 30.0),
        Visibility(
          visible: parkingSpace.status != ParkingSpaceStatusEnum.unavailable,
          child: buildRegisterVehicleSection(parkingSpace.id),
        ),
      ],
    );
  }

  Widget buildOccupiedContent(ParkingSpaceModel parkingSpace) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 6.0,
          width: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Vaga ${parkingSpace.id}",
              style: const TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 200.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: parkingSpace.status.color,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  parkingSpace.status.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Detalhes do registro",
            style: TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Placa: ${parkingSpace.registers!.last.licensePlate}",
            style: const TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Check-in: ${TimestampHelper.getDateTimeStringFromTimestamp(parkingSpace.registers!.last.checkIn)}",
            style: const TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Divider(height: 30.0),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fazer check-out da vaga",
            style: TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () {
            Modular.get<ManagementCubit>().checkOutVehicle(parkingSpace.id);
          },
          child: const Text(
            "Check-out",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRegisterVehicleSection(int parkingSpaceId) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Registrar caminhão na vaga",
            style: TextStyle(
              color: CustomColorsConstants.onyx,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          keyboardType: TextInputType.text,
          maxLength: 7,
          controller: licensePlateController,
          style: const TextStyle(
            fontSize: 18.0,
            color: CustomColorsConstants.onyx,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintText: "Digite aqui a placa do caminhão",
            hintStyle: const TextStyle(
              color: Colors.black38,
            ),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () {
            Modular.get<ManagementCubit>().checkInVehicle(
              licensePlateController.text,
              parkingSpaceId,
            );
          },
          child: const Text(
            "Registrar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
