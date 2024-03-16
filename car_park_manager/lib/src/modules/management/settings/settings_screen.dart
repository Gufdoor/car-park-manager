import 'package:car_park_manager/src/modules/management/bloc/management_cubit.dart';
import 'package:car_park_manager/src/modules/management/bloc/management_state.dart';
import 'package:car_park_manager/src/modules/management/management_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController vacanciesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Configurações",
            style: TextStyle(
              color: Color(0xFF393E41),
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
    return BlocBuilder<ManagementCubit, ManagementState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Número de vagas no estacionamento",
                  style: TextStyle(
                    color: Color(0xFF393E41),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "10 vagas",
                      style: TextStyle(
                        color: Color(0xFF393E41),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () => handleVacanciesDialog(),
                      child: const Text(
                        "Alterar",
                        style: TextStyle(
                          color: Colors.white,
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
                        color: Color(0xFF393E41),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onPressed: () => handleClearDataDialog(),
                    child: const Text(
                      "Limpar dados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
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
        keyboardType: TextInputType.number,
        controller: vacanciesController,
        style: const TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          hintText: "10 vagas",
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ];

    final Widget rightButton = TextButton(
      child: const Text(
        "Alterar",
        style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
      ),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
        style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
      ),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(text, style: const TextStyle()),
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
                rightButton,
              ],
            ),
          ],
        );
      },
    );
  }
}
