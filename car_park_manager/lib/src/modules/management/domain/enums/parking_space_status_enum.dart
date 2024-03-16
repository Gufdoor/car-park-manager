enum ParkingSpaceStatusEnum {
  vacant(
    "Disponível",
    "Esta vaga está desocupada.",
  ),
  occupied(
    "Ocupada",
    "Esta vaga está ocupada.",
  ),
  unavailable(
    "Indisponível",
    "Esta vaga não pode ser utilizada no momento.",
  );

  final String title;
  final String text;

  const ParkingSpaceStatusEnum(
    this.title,
    this.text,
  );
}
