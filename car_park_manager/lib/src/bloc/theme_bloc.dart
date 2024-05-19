import "dart:async";

import "package:car_park_manager/src/bloc/theme_event.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    // execute this event when the app starts
    on<SetInitialTheme>(
      (event, emit) async {
        final bool hasThemeDark = await isDark();

        emit(hasThemeDark);
      },
    );

    // toggle the app theme
    on<ChangeTheme>(
      (event, emit) async {
        final hasThemeDark = await isDark();

        emit(!hasThemeDark);
        unawaited(setTheme(!hasThemeDark));
      },
    );
  }
}

Future<bool> isDark() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  return sharedPreferences.getBool("isDark") ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  unawaited(sharedPreferences.setBool("isDark", isDark));
}
