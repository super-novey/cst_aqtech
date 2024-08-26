class GeneralTimeOff {
  int id;
  DateTime dateFrom;
  DateTime dateTo;
  int sumDay;
  String reason;
  String note;

  GeneralTimeOff({
    required this.id,
    required this.dateFrom,
    required this.dateTo,
    required this.sumDay,
    required this.reason,
    required this.note,
  });

  GeneralTimeOff.empty()
      : id = 0,
        dateFrom = DateTime.now(),
        dateTo = DateTime.now(),
        sumDay = 1,
        reason = '',
        note = '';

  factory GeneralTimeOff.fromJson(Map<String, dynamic> json) => GeneralTimeOff(
        id: json['id'],
        dateFrom: DateTime.parse(json['dateFrom']),
        dateTo: DateTime.parse(json['dateTo']),
        sumDay: json['sumDay'] ?? 0,
        reason: json['reason'] ?? '',
        note: json['note'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateFrom': dateFrom.toIso8601String(),
      'dateTo': dateTo.toIso8601String(),
      'sumDay': sumDay,
      'reason': reason,
      'note': note,
    };
  }
}
