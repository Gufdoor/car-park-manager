import "dart:async";

import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";
import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart";
import "package:car_park_manager/src/modules/management/widgets/custom_parking_space_bottom_sheet.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class CustomParkingSpaceTile extends StatefulWidget {
  final int parkingSpaceIndex;
  final ParkingSpaceModel parkingSpace;

  const CustomParkingSpaceTile({
    required this.parkingSpaceIndex,
    required this.parkingSpace,
    super.key,
  });

  @override
  State<CustomParkingSpaceTile> createState() => _CustomParkingSpaceTileState();
}

class _CustomParkingSpaceTileState extends State<CustomParkingSpaceTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: ListTile(
          title: Text(
            "Vaga ${widget.parkingSpace.id.toString()}",
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            widget.parkingSpace.registers!.isEmpty
                ? "Nenhum caminhão registrado"
                : "Placa: ${widget.parkingSpace.registers!.last.licensePlate}",
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          trailing: Container(
            constraints: const BoxConstraints(maxWidth: 100.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: widget.parkingSpace.status.color,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.parkingSpace.status.title,
                style: const TextStyle(
                  color: CustomColorsConstants.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // tileColor: LightColorsConstants.brightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onTap: () {
            unawaited(showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return BlocProvider.value(
                  value: Modular.get<ManagementBloc>(),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: CustomParkingSpaceBottomSheet(
                      index: widget.parkingSpaceIndex,
                    ),
                  ),
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
