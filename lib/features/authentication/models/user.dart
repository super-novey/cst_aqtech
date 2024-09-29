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
  String role;
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
    this.role = '1',
    this.isLeader = false,
    this.workingYear = 0,
    this.isActive = true,
  })  : birthDate = birthDate ?? DateTime.now(),
        startDate = startDate ?? DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      memberNumber: json['memberNumber'] ?? 0,
      tfsName: json['tfsName'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      avatar: json['avatar'] ?? "",
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : DateTime.now(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      nickName: json['nickName'] ?? "",
      role: json['role'] ?? '1',
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
      'role': role,
      'isLeader': isLeader,
      'workingYear': workingYear,
      'isActive': isActive,
    };
  }
}
