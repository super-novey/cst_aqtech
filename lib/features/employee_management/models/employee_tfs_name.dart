class EmployeeTFSName {
  final int id;
  final String tfsName;
  final String fullName;
  final String nickName;

  EmployeeTFSName({
    required this.id,
    required this.tfsName,
    required this.fullName,
    required this.nickName,
  });

  factory EmployeeTFSName.fromJson(Map<String, dynamic> json) {
    return EmployeeTFSName(
      id: json['id'] ?? 0,
      tfsName: json['tfsName'] ?? '',
      fullName: json['fullName'] ?? '',
      nickName: json['nickName'] ?? '',
    );
  }
}
