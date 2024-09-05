class OverTime {
  int id;
  DateTime date;
  double time;
  int memberId;
  String note;

  OverTime({
    this.id = 0,
    DateTime? date,
    this.time = 0.0,
    this.memberId = 0,
    this.note = "",
  }) : date = date ?? DateTime.now();

  // Phương thức fromJson để parse dữ liệu JSON thành model
  factory OverTime.fromJson(Map<String, dynamic> json) {
    return OverTime(
      id: json['id'] ?? 0,
      date: DateTime.parse(json['date']),
      time: json['time'].toDouble() ?? 0.0,
      memberId: json['memberId'] ?? 0,
      note: json['note'] ?? "",
    );
  }

  // Phương thức toJson để chuyển đổi model thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'time': time,
      'memberId': memberId,
      'note': note,
    };
  }
}
