class SupCaseReport {
  final String assignedTo;
  final int canXuLy;
  final int xuLyTre;
  final int phanTichTre;
  final int testTre;
  final int caseLamTrongNgay;

  SupCaseReport({
    required this.assignedTo,
    required this.canXuLy,
    required this.xuLyTre,
    required this.phanTichTre,
    required this.testTre,
    required this.caseLamTrongNgay,
  });

  // Chuyển từ JSON sang đối tượng Dart
  factory SupCaseReport.fromJson(Map<String, dynamic> json) {
    String assignedTo = json['assignedto'] ?? '';
    // Xử lý chuỗi để lấy giá trị trước ký tự '<'
    if (assignedTo.contains('<')) {
      assignedTo = assignedTo.split('<')[0].trim();
    }

    return SupCaseReport(
      assignedTo: assignedTo,
      canXuLy: json['canXuLy'] ?? 0,
      xuLyTre: json['xuLyTre'] ?? 0,
      phanTichTre: json['phanTichTre'] ?? 0,
      testTre: json['testTre'] ?? 0,
      caseLamTrongNgay: 5
      //caseLamTrongNgay: json['caseLamTrongNgay'] ?? 0,
    );
  }

  // Chuyển từ đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'assignedto': assignedTo,
      'canXuLy': canXuLy,
      'xuLyTre': xuLyTre,
      'phanTichTre': phanTichTre,
      'testTre': testTre,
      'caseLamTrongNgay': caseLamTrongNgay,
    };
  }
}
