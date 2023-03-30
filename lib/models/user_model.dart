class UserModel {
  UserModel({
    required this.id,
    required this.nombreCompleto,
    required this.dni,
    required this.telefono,
    required this.direccion,
  });

  int id;
  String nombreCompleto;
  String dni;
  String telefono;
  String direccion;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        nombreCompleto: json["nombreCompleto"] ?? "",
        dni: json["dni"] ?? "",
        telefono: json["telefono"] ?? "",
        direccion: json["direccion"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreCompleto": nombreCompleto,
        "dni": dni,
        "telefono": telefono,
        "direccion": direccion,
      };
}
