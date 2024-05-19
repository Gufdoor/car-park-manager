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
        style: titleStyle ?? const TextStyle(fontSize: 20.0),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(
              text,
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
