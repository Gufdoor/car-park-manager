import "dart:async";

import "package:car_park_manager/src/core/helpers/timestamp_helper.dart";
import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/domain/models/register_model.dart";
import "package:car_park_manager/src/modules/management/widgets/custom_register_bottom_sheet.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class CustomRegisterTile extends StatefulWidget {
  final RegisterModel register;

  const CustomRegisterTile({
    required this.register,
    super.key,
  });

  @override
  State<CustomRegisterTile> createState() => _CustomRegisterTileState();
}

class _CustomRegisterTileState extends State<CustomRegisterTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: ListTile(
          title: Text(
            "Vaga ${widget.register.parkingSpaceId.toString()}",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "Check-out: ${handleCheckOutText(widget.register.checkOut)}",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: const Icon(
            Icons.more_horiz,
            size: 30.0,
          ),
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
                    child: CustomRegisterBottomSheet(
                      register: widget.register,
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

  String handleCheckOutText(int checkOut) {
    return checkOut == 0
        ? "não realizado"
        : TimestampHelper.getDateTimeStringFromTimestamp(checkOut);
  }
}
