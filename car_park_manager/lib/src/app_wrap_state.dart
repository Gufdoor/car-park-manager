import 'package:equatable/equatable.dart';

enum AppWrapStatus { initial }

class AppWrapState extends Equatable {
  final AppWrapStatus status;
  final bool isLoading;
  final String loadingText;
  final int duration;
  final bool canClose;
  final bool refresh;

  const AppWrapState({
    this.status = AppWrapStatus.initial,
    this.isLoading = false,
    this.loadingText = "",
    this.duration = 8,
    this.canClose = true,
    this.refresh = false,
  });

  AppWrapState copyWith({
    AppWrapStatus? status,
    bool? isLoading,
    String? loadingText,
    int? duration,
    bool? canClose,
  }) {
    return AppWrapState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      loadingText: loadingText ?? this.loadingText,
      duration: duration ?? this.duration,
      canClose: canClose ?? this.canClose,
      refresh: !refresh,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isLoading,
        loadingText,
        duration,
        canClose,
        refresh,
      ];
}
