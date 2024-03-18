import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";
import "package:flutter/material.dart";

class CustomDialog extends StatelessWidget {
  final List<Widget> body;
  final String title;
  final String text;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final Widget? rightButton;

  const CustomDialog({
    required this.body,
    this.title = "",
    this.text = "",
    this.titleStyle,
    this.textStyle,
    this.rightButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              fontSize: 20.0,
              color: CustomColorsConstants.onyx,
            ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              text,
              style: textStyle ??
                  const TextStyle(color: CustomColorsConstants.onyx),
            ),
            ...body,
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: const Text(
                // TODO remover cancelar
                "Cancelar",
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            Visibility(visible: rightButton != null, child: rightButton!),
          ],
        ),
      ],
    );
  }
}
