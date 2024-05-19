import "dart:async";

import "package:car_park_manager/src/bloc/theme_bloc.dart";
import "package:car_park_manager/src/bloc/theme_event.dart";
import "package:car_park_manager/src/domain/constants/custom_colors_constants.dart";
import "package:car_park_manager/src/modules/management/bloc/management_bloc.dart";
import "package:car_park_manager/src/modules/management/bloc/management_state.dart";
import "package:car_park_manager/src/modules/management/management_module.dart";
import "package:car_park_manager/src/widgets/custom_dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart"
    hide ModularWatchExtension;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController vacanciesController = TextEditingController();
  late String vacancies;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Configurações",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          elevation: 10.0,
          shadowColor: Colors.black38,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Modular.to.navigate(routeManager),
            icon: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: buildSettings(),
        ),
      ),
    );
  }

  Widget buildSettings() {
    return BlocBuilder<ManagementBloc, ManagementState>(
      builder: (context, state) {
        vacancies = state.carPark != null
            ? state.carPark!.vacancies.toString()
            : "Não configurado";

        return SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Número de vagas no estacionamento",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      vacancies,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColorsConstants.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () => handleVacanciesDialog(),
                      child: const Text(
                        "Alterar",
                        style: TextStyle(
                          color: CustomColorsConstants.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "Limpar dados de registro",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColorsConstants.coralRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () => handleClearDataDialog(),
                    child: const Text(
                      "Limpar dados",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: CustomColorsConstants.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 30.0),
              BlocBuilder<ThemeBloc, bool>(builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Tema: ${state ? "Escuro" : "Claro"}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Switch(
                      value: state,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ChangeTheme());
                      },
                    ),
                  ],
                );
              }),
              const Divider(height: 30.0),
            ],
          ),
        );
      },
    );
  }

  void handleVacanciesDialog() {
    final List<Widget> body = [
      const SizedBox(height: 16.0),
      TextFormField(
        key: const ValueKey("vacancies"),
        keyboardType: TextInputType.number,
        controller: vacanciesController,
        style: const TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          hintText: vacancies,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ];

    final Widget rightButton = TextButton(
      key: const ValueKey("setVacancies"),
      child: const Text(
        "Alterar",
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        Modular.get<ManagementBloc>().setCarPark(vacanciesController.text);
        vacanciesController.clear();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    buildDialog(
      "Alterar quantidade de vagas",
      "Atenção: essa ação irá apagar os registros atuais. Prossiga com cautela.",
      rightButton,
      body,
    );
  }

  void handleClearDataDialog() {
    final Widget rightButton = TextButton(
      child: const Text(
        "Limpar dados",
        style: TextStyle(fontSize: 20.0),
      ),
      onPressed: () {
        Modular.get<ManagementBloc>().clearRegisters();
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    buildDialog(
      "Limpar dados do registro",
      "Atenção: essa ação é IRREVERSSÍVEL. Será necessário configurar novamente o número de vagas do estacionamento.",
      rightButton,
      [],
    );
  }

  void buildDialog(
    String title,
    String text,
    Widget rightButton,
    List<Widget> body,
  ) {
    unawaited(showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          body: body,
          title: title,
          text: text,
          rightButton: rightButton,
        );
      },
    ));
  }
}
