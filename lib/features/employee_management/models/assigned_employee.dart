class AssignedEmployee {
  final int id;
  final String fullName;
  final String nickName;

  AssignedEmployee(
      {required this.id, required this.fullName, required this.nickName});

  factory AssignedEmployee.fromJson(Map<String, dynamic> json) {
    return AssignedEmployee(
        id: json['id'], fullName: json['fullName'] ?? "", nickName: json['nickName'] ?? "");
  }
}
