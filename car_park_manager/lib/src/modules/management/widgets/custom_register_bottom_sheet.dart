import "package:car_park_manager/src/core/helpers/timestamp_helper.dart";
import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";
import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:car_park_manager/src/modules/management/domain/models/register_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CustomRegisterBottomSheet extends StatefulWidget {
  final RegisterModel register;

  const CustomRegisterBottomSheet({
    required this.register,
    super.key,
  });

  @override
  State<CustomRegisterBottomSheet> createState() =>
      _CustomRegisterBottomSheetState();
}

class _CustomRegisterBottomSheetState extends State<CustomRegisterBottomSheet> {
  final TextEditingController licensePlateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagementBloc, ManagementState>(
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
              child: buildRegisterContent(),
            ),
          ),
        );
      },
    );
  }

  Widget buildRegisterContent() {
    return SingleChildScrollView(
      child: Column(
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vaga ${widget.register.parkingSpaceId}",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placa do caminhão: ${widget.register.licensePlate}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Divider(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Check-in: ${TimestampHelper.getDateTimeStringFromTimestamp(widget.register.checkIn)}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Divider(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Check-out: ${handleCheckOutText(widget.register.checkOut)}",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColorsConstants.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text(
              "Fechar",
              style: TextStyle(
                color: CustomColorsConstants.white,
                fontSize: 20.0,
              ),
            ),
          ),

        ],
      ),
    );
  }

  String handleCheckOutText(int checkOut) {
    return checkOut == 0
        ? "não realizado"
        : TimestampHelper.getDateTimeStringFromTimestamp(checkOut);
  }
}
