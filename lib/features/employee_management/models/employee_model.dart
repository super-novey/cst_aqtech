import 'package:hrm_aqtech/utils/constants/enums.dart';

class Employee {
  int id;
  String tfsName;
  String fullName;
  String email;
  String phone;
  String avatar;
  DateTime birthDate;
  DateTime startDate;
  String nickName;
  EmployeeRole role;
  bool isLeader;
  bool isLunch;
  int wfhQuota;
  int absenceQuota;
  bool isActive;

  Employee({
    this.id = 0,
    this.tfsName = "",
    this.fullName = "",
    this.email = "",
    this.phone = "",
    this.avatar = "",
    DateTime? birthDate,
    DateTime? startDate,
    this.nickName = "",
    this.role = EmployeeRole.Developer,
    this.isLeader = false,
    this.isLunch = false,
    this.wfhQuota = 0,
    this.absenceQuota = 0,
    this.isActive = true,
  })  : birthDate = birthDate ?? DateTime.now(),
        startDate = startDate ?? DateTime.now();

  // Tạo phương thức fromJson để parse dữ liệu JSON thành model
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      tfsName: json['tfsName'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      birthDate: DateTime.parse(json['birthDate']),
      startDate: DateTime.parse(json['startDate']),
      nickName: json['nickName'] ?? "",
      role: EmployeeRole.values[int.parse(json['role']) - 1],
      isLeader: json['isLeader'] ?? false,
      isLunch: json['isLunch'] ?? false,
      wfhQuota: json['wfhQuota'] ?? 0,
      absenceQuota: json['absenceQuota'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  // Tạo phương thức toJson để chuyển đổi model thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tfsName': tfsName,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': "",
      'birthDate': birthDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'nickName': nickName,
      'role': (role.index + 1).toString(),
      'isLeader': isLeader,
      'isLunch': isLunch,
      'wfhQuota': wfhQuota,
      'absenceQuota': absenceQuota,
      'isActive': isActive,
    };
  }
}
