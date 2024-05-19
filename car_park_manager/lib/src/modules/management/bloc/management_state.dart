import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:equatable/equatable.dart";

enum ManagementBlocStatus { initial, loading }

class ManagementState extends Equatable {
  final bool isRefresh;
  final ManagementBlocStatus status;
  final CarParkModel? carPark;

  const ManagementState({
    this.isRefresh = false,
    this.status = ManagementBlocStatus.loading,
    this.carPark,
  });

  ManagementState copyWith({
    ManagementBlocStatus? status,
    CarParkModel? carPark,
  }) {
    return ManagementState(
      isRefresh: !isRefresh,
      status: status ?? this.status,
      carPark: carPark,
    );
  }

  @override
  List<Object?> get props => [
        isRefresh,
        status,
        carPark,
      ];
}
