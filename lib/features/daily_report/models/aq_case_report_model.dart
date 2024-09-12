class AqCaseReport{
  String name;
  int tongCase;
  int conHan;
  int treHan;
  int nhanSu;

  AqCaseReport({
    required this.name,
    required this.tongCase,
    required this.conHan,
    required this.treHan,
    required this.nhanSu,
  });

  // Factory method to create an instance from JSON
  factory AqCaseReport.fromJson(Map<String, dynamic> json) {
    return AqCaseReport(
      name: json['name'] ?? '',
      tongCase: json['tongCase'] ?? 0,
      conHan: json['conHan'] ?? 0,
      treHan: json['treHan'] ?? 0,
      nhanSu: json['nhanSu'] ?? 0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tongCase': tongCase,
      'conHan': conHan,
      'treHan': treHan,
      'nhanSu': nhanSu,
    };
  }
}
