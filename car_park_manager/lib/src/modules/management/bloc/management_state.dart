import "package:car_park_manager/src/modules/management/domain/models/car_park_model.dart";
import "package:equatable/equatable.dart";

enum ManagerCubitStatus { initial, loading }

class ManagementState extends Equatable {
  final bool isRefresh;
  final ManagerCubitStatus status;
  final CarParkModel? carPark;

  const ManagementState({
    this.isRefresh = false,
    this.status = ManagerCubitStatus.loading,
    this.carPark,
  });

  ManagementState copyWith({
    ManagerCubitStatus? status,
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
