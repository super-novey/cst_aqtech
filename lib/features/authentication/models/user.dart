import 'package:hrm_aqtech/utils/constants/enums.dart';

class User {
  int id;
  int memberNumber;
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
  int workingYear;
  bool isActive;

  User({
    this.id = 0,
    this.memberNumber = 0,
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
    this.workingYear = 0,
    this.isActive = true,
  })  : birthDate = birthDate ?? DateTime.now(),
        startDate = startDate ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      memberNumber: json['memberNumber'] ?? 0,
      tfsName: json['tfsName'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      birthDate: DateTime.parse(json['birthDate']),
      startDate: DateTime.parse(json['startDate']),
      nickName: json['nickName'] ?? "",
      role: json['role'] == 'admin'
          ? EmployeeRole.Admin
          : EmployeeRole.values[int.parse(json['role']) - 1],
      isLeader: json['isLeader'] ?? false,
      workingYear: json['workingYear'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberNumber': memberNumber,
      'tfsName': tfsName,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'birthDate': birthDate.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'nickName': nickName,
      'role': (role.index + 1).toString(),
      'isLeader': isLeader,
      'workingYear': workingYear,
      'isActive': isActive,
    };
  }
}
