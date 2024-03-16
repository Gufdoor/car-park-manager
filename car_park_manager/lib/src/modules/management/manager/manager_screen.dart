import 'package:car_park_manager/src/modules/management/bloc/management_cubit.dart';
import 'package:car_park_manager/src/modules/management/bloc/management_state.dart';
import 'package:car_park_manager/src/modules/management/domain/models/car_park_model.dart';
import 'package:car_park_manager/src/modules/management/management_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  late int selectedTab = 0;
  late bool isCarParkSet;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          isCarParkSet = state.carPark != null;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Car Park Manager",
                style: TextStyle(
                  color: Color(0xFF393E41),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              elevation: 10.0,
              shadowColor: Colors.black38,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () => Modular.to.pushNamed(routeSettings),
                  icon: const Icon(
                    Icons.settings,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  handleCarParkTab(),
                  handleRegisterTab(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedTab,
              selectedItemColor: Colors.indigo,
              unselectedItemColor: const Color(0xFF393E41),
              showUnselectedLabels: true,
              onTap: (index) {
                setState(() => selectedTab = index);
                pageController.jumpToPage(index);
              },
              items: [
                buildBarItem("Estacionamento"),
                buildBarItem("Registro"),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem buildBarItem(String text) {
    return BottomNavigationBarItem(
      icon: const Icon(
        Icons.view_list,
        size: 25.0,
      ),
      label: text,
    );
  }

  Widget handleCarParkTab() {
    return BlocBuilder<ManagementCubit, ManagementState>(
      builder: (context, state) {
        return isCarParkSet ? buildCarParkTab(state.carPark!) : buildEmptyTab();
      },
    );
  }

  Widget handleRegisterTab() {
    return BlocBuilder<ManagementCubit, ManagementState>(
      builder: (context, state) {
        return isCarParkSet ? buildRegisterTab() : buildEmptyTab();
      },
    );
  }

  Widget buildCarParkTab(CarParkModel carPark) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Vagas atuais",
            style: TextStyle(
              color: Color(0xFF393E41),
              fontSize: 26.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Gerencie as vagas do seu estacionamento",
            style: TextStyle(
              color: Color(0xFF393E41),
              fontSize: 18.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Vagas desocupadas: 4",
            style: TextStyle(
              color: Color(0xFF393E41),
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Chamar emergência",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmptyTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Você ainda não configurou o estacionamento",
          style: TextStyle(
            color: Color(0xFF393E41),
            fontSize: 26.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        const Text(
          "Acesse as configurações e informe a quantidade de vagas possui o estacionamento",
          style: TextStyle(
            color: Color(0xFF393E41),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onPressed: () => Modular.to.navigate(routeSettings),
          child: const Text(
            "Configurações",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRegisterTab() {
    return Container();
  }
}
