import 'package:car_park_manager/src/core/helpers/timestamp_helper.dart';
import 'package:car_park_manager/src/domain/constants/custom_colors_constants.dart';
import 'package:car_park_manager/src/modules/management/bloc/management_cubit.dart';
import 'package:car_park_manager/src/modules/management/bloc/management_state.dart';
import 'package:car_park_manager/src/modules/management/domain/enums/parking_space_status_enum.dart';
import 'package:car_park_manager/src/modules/management/domain/models/car_park_model.dart';
import 'package:car_park_manager/src/modules/management/domain/models/parking_space_model.dart';
import 'package:car_park_manager/src/modules/management/domain/models/register_model.dart';
import 'package:car_park_manager/src/modules/management/management_module.dart';
import 'package:car_park_manager/src/modules/management/widgets/custom_parking_space_tile.dart';
import 'package:car_park_manager/src/modules/management/widgets/custom_register_tile.dart';
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
  late List<RegisterModel> registers = [];
  late List<RegisterModel> todayRegisters = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ManagementCubit, ManagementState>(
        builder: (context, state) {
          isCarParkSet = state.carPark != null;

          if (isCarParkSet) {
            handleRegisters(state.carPark!);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Car Park Manager",
                style: TextStyle(
                  color: CustomColorsConstants.onyx,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
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
              unselectedItemColor: CustomColorsConstants.onyx,
              showUnselectedLabels: true,
              onTap: (index) {
                setState(() => selectedTab = index);
                pageController.jumpToPage(index);
              },
              items: [
                handleBarItem("Estacionamento", Icons.local_parking),
                handleBarItem("Registro", Icons.view_list),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem handleBarItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 25.0),
      label: label,
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
        return isCarParkSet
            ? buildRegisterTab(state.carPark!)
            : buildEmptyTab();
      },
    );
  }

  Widget buildCarParkTab(CarParkModel carPark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vagas atuais",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Clique nas vagas para gerenciar o estacionamento",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Vagas desocupadas: ${getVacanciesAmount(carPark.parkingSpaces!)}",
              style: const TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: carPark.vacancies,
            itemBuilder: (context, index) {
              return CustomParkingSpaceTile(
                parkingSpaceIndex: index,
                parkingSpace: carPark.parkingSpaces![index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildRegisterTab(CarParkModel carPark) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Registro das vagas",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Visualize os registros de check-in e check-out cada vaga em ordem",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Registros do dia",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          todayRegisters.isEmpty
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Não há registros no momento",
                    style: TextStyle(
                      color: CustomColorsConstants.onyx,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todayRegisters.length,
                    itemBuilder: (context, index) {
                      return CustomRegisterTile(
                        register: todayRegisters[index],
                      );
                    },
                  ),
                ),
          const Divider(height: 30.0),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Todos os registros",
              style: TextStyle(
                color: CustomColorsConstants.onyx,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          registers.isEmpty
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Não há registros no momento",
                    style: TextStyle(
                      color: CustomColorsConstants.onyx,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: registers.length,
                    itemBuilder: (context, index) {
                      return CustomRegisterTile(register: registers[index]);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildEmptyTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Você ainda não configurou o estacionamento",
          style: TextStyle(
            color: CustomColorsConstants.onyx,
            fontSize: 26.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4.0),
        const Text(
          "Acesse as configurações e informe a quantidade de vagas possui o estacionamento",
          style: TextStyle(
            color: CustomColorsConstants.onyx,
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

  String getVacanciesAmount(List<ParkingSpaceModel> parkingSpaces) {
    return parkingSpaces
        .where((ps) => ps.status == ParkingSpaceStatusEnum.vacant)
        .length
        .toString();
  }

  void handleRegisters(CarParkModel carPark) {
    registers = carPark.getAllRegisters();
    todayRegisters.clear();
    final int todayTimestamp = TimestampHelper.getTodayTimestamp();
    final int tomorrowTimestamp = TimestampHelper.getTodayTimestamp() +
        TimestampHelper.oneDayMilliseconds;

    for (final register in registers) {
      if ((register.checkIn >= todayTimestamp &&
              register.checkIn < tomorrowTimestamp) ||
          register.checkOut >= todayTimestamp &&
              register.checkOut < tomorrowTimestamp) {
        todayRegisters.add(register);
      }
    }
  }
}
