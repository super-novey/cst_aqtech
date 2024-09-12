class CoderCaseReport {
  final String assignedTo;
  final int canXuLy;
  final int xuLyTre;
  final int soCaseTrongNgay;
  final int tgCanXyLy;
  final int luongGioTrongNgay;

  CoderCaseReport({
    required this.assignedTo,
    required this.canXuLy,
    required this.xuLyTre,
    required this.soCaseTrongNgay,
    required this.tgCanXyLy,
    required this.luongGioTrongNgay,
  });

  // Chuyển từ JSON sang đối tượng Dart
  factory CoderCaseReport.fromJson(Map<String, dynamic> json) {
    String assignedTo = json['assignedto'] ?? '';
    // Xử lý chuỗi để lấy giá trị trước ký tự '<'
    if (assignedTo.contains('<')) {
      assignedTo = assignedTo.split('<')[0].trim();
    }

    return CoderCaseReport(
      assignedTo: assignedTo,
      canXuLy: json['canXuLy'] ?? 0,
      xuLyTre: json['xuLyTre'] ?? 0,
      soCaseTrongNgay: json['soCaseTrongNgay'] ?? 0,
      tgCanXyLy: json['tgCanXyLy'] ?? 0,
      luongGioTrongNgay: json['luongGioTrongNgay'] ?? 0,
    );
  }

  // Chuyển từ đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'assignedto': assignedTo,
      'canXuLy': canXuLy,
      'xuLyTre': xuLyTre,
      'soCaseTrongNgay': soCaseTrongNgay,
      'tgCanXyLy': tgCanXyLy,
      'luongGioTrongNgay': luongGioTrongNgay,
    };
  }
}
