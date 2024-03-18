import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:equatable/equatable.dart";

enum ManagementCubitStatus { initial, loading }

class ManagementState extends Equatable {
  final bool isRefresh;
  final ManagementCubitStatus status;
  final CarParkModel? carPark;

  const ManagementState({
    this.isRefresh = false,
    this.status = ManagementCubitStatus.loading,
    this.carPark,
  });

  ManagementState copyWith({
    ManagementCubitStatus? status,
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
