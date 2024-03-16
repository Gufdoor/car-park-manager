import "package:car_park_manager/src/app_wrap_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AppWrapCubit extends Cubit<AppWrapState> {
  AppWrapCubit._internal() : super(const AppWrapState());

  static final AppWrapCubit _instance = AppWrapCubit._internal();

  static AppWrapCubit get instance => _instance;

  static bool _hasInit = false;
  static bool _isLoading = false;
  late String loadingMessage = "";

  static void init() {
    if (!_hasInit) {
      _hasInit = true;
    }
  }

  void initLoading({String? message}) {
    loadingMessage = message ?? "Carregando...";
    _isLoading = true;
    emit(state.copyWith(isLoading: _isLoading, loadingText: loadingMessage));
  }

  void finishLoading() {
    _isLoading = false;
    emit(state.copyWith(isLoading: _isLoading));
  }
}
