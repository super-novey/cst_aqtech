class CaseWaitingTime {
  List<String> macase;
  int soCase;
  String tuanSo;

  CaseWaitingTime({
    required this.macase,
    required this.soCase,
    required this.tuanSo,
  });

  factory CaseWaitingTime.fromJson(Map<String, dynamic> json) {
    return CaseWaitingTime(
      macase: List<String>.from(json['macase'] ?? []),
      soCase: json['soCase'] ?? 0,
      tuanSo: json['tuanSo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'macase': macase,
      'soCase': soCase,
      'tuanSo': tuanSo,
    };
  }
}

